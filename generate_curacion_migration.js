import { CURACION_CLINICA } from './src/data/curacion_clinica.js';
import fs from 'fs';

const lines = [
  '-- ==========================================================================',
  '-- Migración: 202610110015_curacion_final_farmacologica.sql',
  '-- Curación farmacológica masiva (mecanismo, farmacocinética, frecuencia,',
  '-- concentración, dosis, duración) para 224 fármacos.',
  '-- Solo actualiza campos que sean NULL (no sobrescribe datos existentes).',
  '-- Fuentes: Plumb\'s Veterinary Drug Handbook, Merck Veterinary Manual,',
  '-- FDA DailyMed, VMD (UK) SPC.',
  '-- ==========================================================================',
  '',
];

function esc(s) {
  if (s == null) return null;
  return s.replace(/'/g, "''");
}

for (const row of CURACION_CLINICA) {
  const [nombre, mecanismo, farmacocinetica, frecuencia_horas, concentracion_mg_ml, dosis_min, dosis_max, duracion] = row;

  const sets = [];

  if (mecanismo) sets.push(`mecanismo_accion = COALESCE(mecanismo_accion, '${esc(mecanismo)}')`);
  if (farmacocinetica) sets.push(`farmacocinetica = COALESCE(farmacocinetica, '${esc(farmacocinetica)}')`);
  if (frecuencia_horas != null && frecuencia_horas > 0) sets.push(`frecuencia_horas = COALESCE(frecuencia_horas, ${frecuencia_horas})`);
  if (concentracion_mg_ml != null) sets.push(`concentracion_mg_ml = COALESCE(concentracion_mg_ml, ${concentracion_mg_ml})`);
  if (dosis_min != null) sets.push(`dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, ${dosis_min})`);
  if (dosis_max != null) sets.push(`dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, ${dosis_max})`);
  // duracion: no existe columna; skip

  if (sets.length === 0) continue;

  lines.push(`UPDATE public.medicamentos SET`);
  lines.push(`  ${sets.join(',\n  ')}`);
  lines.push(`WHERE nombre = '${esc(nombre)}' AND activo = true;`);
  lines.push('');
}

const sql = lines.join('\n');
fs.writeFileSync('supabase/migrations/202610110015_curacion_final_farmacologica.sql', sql);
console.log(`Migración generada: ${sql.length} bytes, ${CURACION_CLINICA.length} fármacos.`);
