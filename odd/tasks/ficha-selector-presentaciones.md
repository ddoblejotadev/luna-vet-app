# Ficha con selector de presentaciones + calculadora embebida

## Objetivo
Que cada ficha de medicamento tenga un "recuadro con opciones" para cambiar presentacion/concentracion (ej. 10% vs 5%, o las 3 presentaciones de Mastilac) y que la dosis se actualice automaticamente, ademas de una calculadora rapida embebida (peso -> mg y mL) sin tener que re-buscar el farmaco.

## Contexto
- DB: project ybzojpypjkgitxcawmxe, tabla public.medicamentos (238 activos).
- Schema actual: nombre, principio_activo, familia_terapeutica, presentacion, concentracion (texto libre), dosis_recomendada (texto), dosis_minima_mg_kg, dosis_maxima_mg_kg, via_administracion, especies_permitidas, nivel_riesgo, activo, indicaciones, efectos_secundarios, contraindicaciones, notas, fuente, url_referencia, creado_por.
- Ficha actual: src/pages/MedicamentoDetallePage.jsx (solo lectura + boton "Calcular dosis" a /calculadora?medicamento=<id>).
- Calculadora: src/pages/CalculadoraPage.jsx (metodos peso/catalogo/bsa/margen; NO calcula mL ni lee ?medicamento=).
- Servicio: src/services/medicamentosService.js (busca por nombre/principio/familia/dosis/indicaciones; sensible a acentos).

## Farmacos faltantes detectados (pedido de usuaria)
- Tiopental (induccion barbiturica, 5-15 mg/kg IV per AAHA).
- Epinefrina / adrenalina (emergencias, anafilaxia, PCR).
- Norepinefrina / noradrenalina (shock vasodilatador, infusion mcg/kg/min).
- Etamsilato = marca "Hemodrag" (hemostatico, 5-12.5 mg/kg IV/IM).
- Mastilac: marca con 3 presentaciones (intramamario lincomicina+neomicina+betametasona; inyectable amoxicilina+clavulanato; secado ampicilina+cloxacilina).

## Duplicados reales a consolidar
- Atropina x3 (todas activas) -> conservar 1.
- Sucralfato x2 (ambas activas) -> conservar 1.
- (Los de mismo principio_activo pero distinta presentacion son intencionales: Ketamina, Ketoprofeno, Meloxicam, Fentanilo, Metadona, Lidocaina.)

## Modelo de datos (decision)
- Agregar columna `presentaciones` JSONB: array de { etiqueta, presentacion, concentracion, concentracion_mg_ml, dosis_min_mg_kg, dosis_max_mg_kg, dosis_texto }.
- Agregar columna `concentracion_mg_ml` NUMERIC (presentacion principal, para calcular mL).
- Compatibilidad: presentaciones nulo/vacio -> la ficha usa columnas top-level (ningun cambio para los 238 existentes).
- Farmacos multi-presentacion (Mastilac) -> presentaciones con N entries, cada una con su dosis.

## Tareas
1. Migracion DB: columnas presentaciones (jsonb) + concentracion_mg_ml (numeric).
2. DB: cargar farmacos faltantes (tiopental, epinefrina, norepinefrina, etamsilato/Hemodrag, Mastilac con sus 3 presentaciones) + rangos numericos.
3. DB: consolidar duplicados Atropina x3 y Sucralfato x2.
4. Feature: ficha (MedicamentoDetallePage) con selector de presentaciones ("recuadro con opciones") + calculadora embebida (peso -> mg + mL) que se auto-actualiza al cambiar presentacion.
5. Feature: CalculadoraPage con input de concentracion (mg/mL) para calcular mL a administrar.
6. Busqueda: cubrir notas/concentracion/presentacion + insensible a acentos (normalizacion NFD).
7. Auditoria de dosis: verificar contra Plumb's/MSD. Lote 1 = Anestesia/Sedantes + farmacos nuevos. (Catálogo completo 238 = tarea larga, por familias.)

## Criterios de aceptacion
- Ficha de Mastilac muestra 3 opciones; al cambiar, cambia dosis/concentracion mostrada.
- Calculadora embebida en ficha da mg y mL sin salir de la ficha.
- Cambiar concentracion 10%<->5% recalcula mL.
- Atropina y Sucralfato aparecen una sola vez.
- Buscar "norepinefrina" o "hemodrag" encuentra el farmaco (con/sin acentos).

## Fuentes
- Plumb's Veterinary Drug Handbook (10a ed.); AAHA Anesthesia Guidelines; MSD Veterinary Manual; Lumb & Jones'.
- Fichas de producto Mastilac (Laboratorios Callbest / Zoetis / Veterland); Hemodrag (etamsilato).
