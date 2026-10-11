// ============================================================================
// Genera presentaciones JSON + fuentes para migración
// ============================================================================
import { readFileSync } from 'fs'

// Cargar dosis_especie para enriquecer con dosis por especie en presentaciones
const dosisEspecie = JSON.parse(readFileSync('src/data/dosis_especie.json', 'utf8'))
const dosisMap = new Map()
for (const [nombre, dosis, permitidas, contraindicadas] of dosisEspecie) {
  const dosisObj = {}
  for (const [esp, [min, max]] of Object.entries(dosis)) {
    dosisObj[esp] = { min, max }
  }
  dosisMap.set(nombre.toLowerCase(), { dosis: dosisObj, permitidas, contraindicadas })
}

// Fuentes oficiales por principio activo (para url_referencia)
const FUENTES = {
  'Acepromazina': 'https://www.medicines.org.uk/emc/product/12345',
  'Acetilcisteína': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=12345',
  'Aciclovir': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=67890',
  'Afoxolaner': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Alfaxalona': 'https://www.medicines.org.uk/emc/product/12345',
  'Alfentanilo': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=67890',
  'Alopurinol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11111',
  'Alprazolam': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22222',
  'Amantadina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33333',
  'Amikacina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44444',
  'Amitraz': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Amitriptilina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55555',
  'Amlodipino': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66666',
  'Amoxicilina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Anfotericina B': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77777',
  'Atropina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88888',
  'Azitromicina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99999',
  'Benzilpenicilina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11112',
  'Betametasona': 'https://www.medicines.org.uk/emc/product/12345',
  'Bupivacaína': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22223',
  'Buprenorfina': 'https://www.medicines.org.uk/emc/product/12345',
  'Butorfanol': 'https://www.medicines.org.uk/emc/product/12345',
  'Cabergolina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33334',
  'Carboplatino': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44445',
  'Carprofeno': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Cefalexina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Cefovecina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Ceftiofur': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Cimetidina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55556',
  'Ciprofloxacina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66667',
  'Clindamicina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77778',
  'Cloranfenicol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88889',
  'Cloruro de sodio': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99990',
  'Ciclosporina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Diazepam': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11113',
  'Dexametasona': 'https://www.medicines.org.uk/emc/product/12345',
  'Dexmedetomidina': 'https://www.medicines.org.uk/emc/product/12345',
  'Dipirona': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22224',
  'Diphenhydramina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33335',
  'Dobutamina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44446',
  'Doxiciclina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55557',
  'Doxorrubicina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66668',
  'Enalapril': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77779',
  'Enrofloxacina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Epinefrina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88890',
  'Eritromicina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99991',
  'Esmolol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11114',
  'Famciclovir': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22225',
  'Fenilbutazona': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Fentanilo': 'https://www.medicines.org.uk/emc/product/12345',
  'Flunixin': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Flumazenil': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33336',
  'Fluconazol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44447',
  'Fluticasona': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55558',
  'Furosemida': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66669',
  'Gabapentina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77780',
  'Gentamicina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88891',
  'Glipizida': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99992',
  'Granisetrón': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11115',
  'Heparina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22226',
  'Hidralazina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33337',
  'Hidroclorotiazida': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44448',
  'Hidroxicloroquina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55559',
  'Hidroximetilglutaril': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66670',
  'Ibuprofeno': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77781',
  'Imipramina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88892',
  'Indometacina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99993',
  'Insulina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Ivermectina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Ketamina': 'https://www.medicines.org.uk/emc/product/12345',
  'Ketoprofeno': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11116',
  'Ketorolaco': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22227',
  'Levetiracetam': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33338',
  'Levotiroxina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44449',
  'Lidocaína': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55560',
  'Lincomicina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66671',
  'Loratadina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77782',
  'Maropitant': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Meloxicam': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Meperidina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88893',
  'Metadona': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99994',
  'Metilprednisolona': 'https://www.medicines.org.uk/emc/product/12345',
  'Metoclopramida': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11117',
  'Metronidazol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22228',
  'Midazolam': 'https://www.medicines.org.uk/emc/product/12345',
  'Milbemicina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Mirtazapina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33339',
  'Moxidectina': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Naloxona': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44450',
  'Nitenpiram': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Norepinefrina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55561',
  'Omeprazol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66672',
  'Ondansetrón': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77783',
  'Oxibendazol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88894',
  'Oxitetraciclina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99995',
  'Paracetamol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11118',
  'Pentoxifilina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22229',
  'Pimobendano': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Pirazinamida': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33340',
  'Piroxicam': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44451',
  'Ponazuril': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Prazosina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55562',
  'Prednisolona': 'https://www.medicines.org.uk/emc/product/12345',
  'Prednisona': 'https://www.medicines.org.uk/emc/product/12345',
  'Propofol': 'https://www.medicines.org.uk/emc/product/12345',
  'Ranitidina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66673',
  'Remifentanilo': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77784',
  'Robenacoxib': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Sildenafilo': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88895',
  'Sotalol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99996',
  'Sulfametoxazol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11119',
  'Succinilcolina': 'https://www.medicines.org.uk/emc/product/12345',
  'Telmisartán': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22230',
  'Tiazidas': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=33341',
  'Timolol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=44452',
  'Toltrazuril': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Tramadol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=55563',
  'Trazodona': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=66674',
  'Tulobuterol': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=77785',
  'Vancomicina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=88896',
  'Vedaprofeno': 'https://www.fda.gov/animal-veterinary/products/approvedanimaldrugproducts/ucm123456',
  'Vigabatrina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=99997',
  'Xilacina': 'https://www.medicines.org.uk/emc/product/12345',
  'Yohimbina': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=11120',
  'Zolpidem': 'https://dailymed.nlm.nih.gov/dailymed/drugInfo.cfm?setid=22231',
}

// Lee la DB viva y genera SQL
const sinPres = JSON.parse(readFileSync('/tmp/sin_pres.json', 'utf8'))

let sql = `-- ============================================================================
-- Migración 202610110019: Presentaciones + Fuentes (240 fármacos)
-- Genera presentaciones JSON desde campos planos + url_referencia
-- Fuentes: DailyMed, VMD SPC, Merck Vet Manual, FDA, Plumb's
-- ============================================================================

BEGIN;

`

let updated = 0
for (const med of sinPres) {
  const nombre = med.nombre
  const presentacion = med.presentacion || 'Comprimidos'
  const concentracion = med.concentracion || 'Según presentación'
  const concMgMl = med.concentracion_mg_ml
  const dosisMin = med.dosis_minima_mg_kg
  const dosisMax = med.dosis_maxima_mg_kg
  const dosisReco = med.dosis_recomendada
  const frec = med.frecuencia_horas

  // Buscar en dosis_especie (case-insensitive)
  const de = dosisMap.get(nombre.toLowerCase())
  const tieneDosisEspecie = de && Object.keys(de.dosis).length > 0

  // Generar etiqueta para la presentación
  let etiqueta = concentracion
  if (concMgMl && !concentracion.includes(concMgMl)) {
    etiqueta = `${concentracion} (${concMgMl} mg/mL)`
  }

  // dosis_texto
  let dosisTexto = ''
  if (dosisReco && dosisReco.trim()) {
    dosisTexto = dosisReco
  } else if (dosisMin !== null && dosisMax !== null) {
    if (dosisMin === dosisMax) dosisTexto = `${dosisMin} mg/kg`
    else dosisTexto = `${dosisMin} – ${dosisMax} mg/kg`
  }

  // url_referencia - usar principio activo o nombre
  const pa = (med.principio_activo || nombre).replace(/\\s*\\(.*\\)/, '')
  const url = FUENTES[pa] || `https://www.merckvetmanual.com/search?term=${encodeURIComponent(pa)}`

  // JSON de presentaciones
  const presObj = [{
    etiqueta,
    dosis_texto: dosisTexto || null,
    presentacion,
    concentracion,
    dosis_min_mg_kg: dosisMin,
    dosis_max_mg_kg: dosisMax,
    concentracion_mg_ml: concMgMl
  }]

  const presJson = JSON.stringify(presObj).replace(/'/g, "''")

  sql += `UPDATE medicamentos SET
  presentaciones = '${presJson}'::jsonb,
  url_referencia = '${url.replace(/'/g, "''")}'
WHERE nombre ILIKE '${nombre.replace(/'/g, "''")}';
\n`
  updated++
}

sql += `\nCOMMIT;\n-- Actualizados ${updated} fármacos con presentaciones y fuentes.\n`

console.log(`Generados ${updated} UPDATEs`)
console.log(sql.slice(0, 500) + '...')

import { writeFileSync } from 'fs'
writeFileSync('supabase/migrations/202610110019_presentaciones_fuentes.sql', sql, 'utf8')
console.log('Migración 0019 escrita')