import { CURACION_COMPLEMENTARIA } from './src/data/curacion_complementaria.js';
import fs from 'fs';

const lines = [
  '-- ==========================================================================',
  '-- Migración: 202610110016_curacion_complementaria.sql',
  '-- Curación complementaria: 43 fármacos que no matchearon en la ronda anterior.',
  '-- Solo actualiza campos NULL.',
  '-- ==========================================================================',
  '',
];

function esc(s) {
  if (s == null) return null;
  return s.replace(/'/g, "''");
}

for (const row of CURACION_COMPLEMENTARIA) {
  const [nombre, mecanismo, farmacocinetica, frecuencia_horas, concentracion_mg_ml, dosis_min, dosis_max] = row;

  const sets = [];

  if (mecanismo) sets.push(`mecanismo_accion = COALESCE(mecanismo_accion, '${esc(mecanismo)}')`);
  if (farmacocinetica) sets.push(`farmacocinetica = COALESCE(farmacocinetica, '${esc(farmacocinetica)}')`);
  if (frecuencia_horas != null && frecuencia_horas > 0) sets.push(`frecuencia_horas = COALESCE(frecuencia_horas, ${frecuencia_horas})`);
  if (concentracion_mg_ml != null) sets.push(`concentracion_mg_ml = COALESCE(concentracion_mg_ml, ${concentracion_mg_ml})`);
  if (dosis_min != null) sets.push(`dosis_minima_mg_kg = COALESCE(dosis_minima_mg_kg, ${dosis_min})`);
  if (dosis_max != null) sets.push(`dosis_maxima_mg_kg = COALESCE(dosis_maxima_mg_kg, ${dosis_max})`);

  if (sets.length === 0) continue;

  lines.push(`UPDATE public.medicamentos SET`);
  lines.push(`  ${sets.join(',\n  ')}`);
  lines.push(`WHERE nombre = '${esc(nombre)}' AND activo = true;`);
  lines.push('');
}

const sql = lines.join('\n');
fs.writeFileSync('supabase/migrations/202610110016_curacion_complementaria.sql', sql);
console.log(`Migración generada: ${sql.length} bytes, ${CURACION_COMPLEMENTARIA.length} fármacos.`);
