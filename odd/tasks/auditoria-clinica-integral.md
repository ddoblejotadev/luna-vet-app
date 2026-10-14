# Auditoría Clínica Integral y Limpieza de Datos

## Specs
- S1: Eliminar ceros redundantes (`0.0000`) de forma absoluta en el origen (`src/data/dosis_especie.json`) y en el contenido de las migraciones SQL.
- S2: Auditar y corregir rangos de dosis clínicamente sospechosos (ej. rangos inexplicablemente amplios como `70 - 140 mg/kg` que no se corresponden con referencias estándar tipo Plumb's o textos guía).
- S3: Garantizar que la interfaz (`MedicamentoDetallePage.jsx`, `CalculadoraPage.jsx`, catálogo) no muestre ceros redundantes ni rangos mal calculados/configurados.

## Tasks

1. **Limpiar dosis_especie.json de valores como `0.0000` o `1.0000`**.
2. **Auditar dosis a la luz de referencias clínicas confiables**.
- T1: Limpiar `src/data/dosis_especie.json` de strings con ceros redundantes.
- T2: Script de auditoría para detectar rangos de dosis sospechosos (ej. `max > min * 3` o valores extremos).
- T3: Validación manual de los hallazgos críticos del script T2 mediante investigación (`research`).
- T4: Corrección masiva de rangos en `src/data/dosis_especie.json` y actualización de migraciones.

## Log
- L1: Inicio de auditoría masiva tras reporte de usuario sobre ceros redundantes persistentes y rangos de dosis ilógicos en producción.
