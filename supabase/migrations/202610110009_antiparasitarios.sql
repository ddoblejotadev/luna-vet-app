-- Migración: antiparasitarios (isoxazolinas, amitraz, lactonas macrocíclicas,
-- praziquantel, fipronil, imidacloprid, sulfadimetoxina, miltefosina,
-- ronidazol, nitenpiram, ponazuril, mebendazol)
-- Fuentes: FDA DailyMed / VMD UK SPC / Plumb's Veterinary Drug Handbook

BEGIN;

-- ── ISOXAZOLINAS (riesgo convulsivo) ───────────────────
-- Afoxolaner, Fluralaner, Lotilaner, Sarolaner
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de reacciones neurológicas (convulsiones, temblores) en animales con historia de convulsiones. No usar en menores de 8 semanas ni en peso <2 kg.',
  embarazo_lactancia = 'Seguridad no establecida en gestación. Usar si el beneficio justifica el riesgo.',
  contraindicaciones = 'Historia de convulsiones, menores de 8 semanas, peso <2 kg.',
  efectos_secundarios = 'Vómito, diarrea, letargo, convulsiones (casos raros), temblores.',
  interacciones = 'No combinar con otros antiparasitarios sin criterio veterinario.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%afoxolaner%' OR nombre ILIKE '%fluralaner%' OR nombre ILIKE '%lotilaner%' OR nombre ILIKE '%sarolaner%';

-- ── AMITRAZ (tóxico en gatos y equinos) ───────────────
UPDATE public.medicamentos SET
  precauciones = 'Agonista alpha-2: sedación, hipotensión, bradicardia, hipoglucemia, hipotermia. TÓXICO EN GATOS Y EQUINOS. Cuidado en perros miniatura (Chihuahua) y ancianos.',
  embarazo_lactancia = 'Seguridad no establecida. Evitar.',
  contraindicaciones = 'Gatos, equinos, enfermedad hepática, diabetes, hipotensión.',
  efectos_secundarios = 'Sedación, hipotensión, bradicardia, hipoglucemia, hipotermia, piloerección.',
  interacciones = 'Agonistas alpha-2 (potenciación). Atipamezol (reverso).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%amitraz%';

-- ── LACTONAS MACROCÍCLICAS (neurotoxicidad MDR1) ──────
-- Milbemicina Oxima, Moxidectina, Selamectina
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de neurotoxicidad en razas con deficiencia MDR1 (collie, pastor). No usar concentraciones altas en razas sensibles. Ajustar dosis por especie.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Razas sensibles MDR1 (a dosis altas), enfermedad hepática severa.',
  efectos_secundarios = 'Salivación, vómito, ataxia, midriasis, ceguera temporal, convulsiones (sobredosis).',
  interacciones = 'Espirometrina (toxicidad CNS aditiva). Ciclosporina (niveles elevados).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%milbemicina%' OR nombre ILIKE '%moxidectina%' OR nombre ILIKE '%selamectina%';

-- ── PRAZIQUANTEL (tenias) ──────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Baja toxicidad. Efectivo contra tenias y trematodos. Puede causar somnolencia.',
  embarazo_lactancia = 'Seguridad no establecida. Usar si el beneficio justifica el riesgo.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Vómito, diarrea, ataxia, somnolencia, salivación.',
  interacciones = 'Pirimetamina (aumenta absorción).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%praziquantel%';

-- ── FIPRONIL ────────────────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Evitar en conejos (tóxico). No usar en animales que se lamen (riesgo de ingestión). Cuidado en animales debilitados.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Conejos, hipersensibilidad.',
  efectos_secundarios = 'Irritación cutánea, salivación (si se lame).',
  interacciones = 'Otros insecticidas (potenciación).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%fipronil%';

-- ── IMIDACLOPRID ────────────────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Baja toxicidad. Evitar ingestión. Cuidado en animales debilitados.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Irritación cutánea, salivación.',
  interacciones = 'Otros insecticidas.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%imidacloprid%';

-- ── SULFADIMETOXINA (cristaluria, KCS) ────────────────
UPDATE public.medicamentos SET
  precauciones = 'Riesgo de cristales en orina (cristaluria). Mantener hidratación adecuada. Hiperrespuesta inmunomediada en Doberman. KCS (ojo seco).',
  embarazo_lactancia = 'Teratogénico. Evitar.',
  contraindicaciones = 'Insuficiencia renal, enfermedad hepática, hipersensibilidad a sulfonamidas.',
  efectos_secundarios = 'Vómito, diarrea, fiebre, KCS, cristaluria, hipersensibilidad.',
  interacciones = 'Metotrexato, warfarina (potenciación).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%sulfadimetoxina%';

-- ── MILTEFOSINA (teratogénico, leishmania) ─────────────
UPDATE public.medicamentos SET
  precauciones = 'TERATÓGENICO. Contraindicado en embarazo/lactancia. Nefrotoxicidad. Sabor amargo (administración oral).',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico).',
  contraindicaciones = 'Embarazo, lactancia, insuficiencia renal severa.',
  efectos_secundarios = 'Vómito, diarrea, pérdida de apetito, nefrotoxicidad.',
  interacciones = 'No combinar con otros nefrotóxicos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%miltefosina%';

-- ── RONIDAZOL (teratogénico, neurotóxico) ──────────────
UPDATE public.medicamentos SET
  precauciones = 'Sabor muy amargo. TERATÓGENO y mutagénico. Cuidado en gestación. Neurotoxicidad a dosis altas.',
  embarazo_lactancia = 'CONTRAINDICADO (teratogénico).',
  contraindicaciones = 'Gestación, lactancia, insuficiencia hepática.',
  efectos_secundarios = 'Neurotoxicidad (convulsiones), vómito.',
  interacciones = 'Otros neurotóxicos.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ronidazol%';

-- ── NITENPIRAM (pulgas, rápido) ────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Rápido y seguro. Efecto en minutos. Cuidado en animales debilitados.',
  embarazo_lactancia = 'Seguridad no establecida. Usar si el beneficio justifica el riesgo.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Vómito, diarrea, letargo (raro).',
  interacciones = 'Otros antiparasitarios.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%nitenpiram%';

-- ── PONAZURIL (coccidias) ──────────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Baja toxicidad. Efectivo contra coccidios. Evitar en gestación.',
  embarazo_lactancia = 'Seguridad no establecida. Usar bajo criterio veterinario.',
  contraindicaciones = 'Hipersensibilidad.',
  efectos_secundarios = 'Vómito, diarrea (raro).',
  interacciones = 'Otros anticoccidiales.',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%ponazuril%';

-- ── MEBENDAZOL (benzimidazol) ──────────────────────────
UPDATE public.medicamentos SET
  precauciones = 'Baja toxicidad. Cuidado en gestación (teratogénico). Uso prolongado puede causar mielosupresión.',
  embarazo_lactancia = 'Teratogénico. Evitar.',
  contraindicaciones = 'Gestación temprana.',
  efectos_secundarios = 'Vómito, diarrea, anorexia, mielosupresión (uso prolongado).',
  interacciones = 'Dexametasona (aumenta absorción).',
  fuente = 'FDA DailyMed / VMD UK SPC'
WHERE nombre ILIKE '%mebendazol%';

COMMIT;
