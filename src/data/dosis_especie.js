// ============================================================================
// DOSIS POR ESPECIE — dataset canónico (mg/kg)
// Fuentes oficiales: Plumb's Veterinary Drug Handbook, Merck Veterinary Manual,
// FDA DailyMed, VMD (UK) SPC, Zoetis dosing charts.
//
// Formato por fármaco:
//   [ nombreExactoDB,
//     { Especie: [min, max] },   // dosis mg/kg (solo especies de uso)
//     ["Perro","Gato"],           // especies_permitidas
//     ["Gato"]                     // especies_contraindicadas (opcional)
//   ]
//
// Notas:
//  - Fármacos tópicos/oftálmicos/fluidos (dosis no mg/kg) se excluyen:
//    la calculadora de mg/kg no les aplica.
//  - Inhalatorios (isoflurano, sevoflurano, desflurano) usan MAC en frontend.
//  - Dosis en µg/kg se convierten a mg/kg (÷1000).
// ============================================================================

const DOSIS_ESPECIE = [
  // ── SEDANTES / ANESTÉSICOS ──────────────────────────────────
  ["Acepromazina", { Perro: [0.02, 0.1], Gato: [0.02, 0.1], Caballo: [0.05, 0.1] }, ["Perro","Gato","Caballo","Vaca"]],
  ["Alfaxalona (IV)", { Perro: [2, 5], Gato: [2, 5] }, ["Perro","Gato"]],
  ["Dexmedetomidina", { Perro: [0.001, 0.005], Gato: [0.001, 0.005], Caballo: [0.0025, 0.005] }, ["Perro","Gato","Caballo"]],
  ["Diazepam", { Perro: [0.5, 2], Gato: [0.2, 0.5] }, ["Perro","Gato"]],
  ["Ketamina (anestesia)", { Perro: [5, 10], Gato: [5, 15], Caballo: [2.2, 2.2] }, ["Perro","Gato","Caballo"]],
  ["Ketamina (baja)", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Medetomidina", { Perro: [0.001, 0.005], Gato: [0.001, 0.005], Caballo: [0.0025, 0.005] }, ["Perro","Gato","Caballo"]],
  ["Midazolam", { Perro: [0.1, 0.4], Gato: [0.1, 0.4] }, ["Perro","Gato"]],
  ["Propofol", { Perro: [4, 6], Gato: [2, 4] }, ["Perro","Gato"]],
  ["Tiletamina + Zolazepam (Telazol)", { Perro: [4, 8], Gato: [4, 8] }, ["Perro","Gato"]],
  ["Tiopental", { Perro: [8, 12], Gato: [8, 12] }, ["Perro","Gato"]],
  ["Xilacina", { Perro: [1, 2], Gato: [0.5, 1], Caballo: [0.5, 1], Vaca: [0.02, 0.05] }, ["Perro","Gato","Caballo","Vaca"]],

  // ── BLOQUEANTES NEUROMUSCULARES ──────────────────────────────
  ["Atracurio", { Perro: [0.2, 0.5], Gato: [0.2, 0.5] }, ["Perro","Gato"]],
  ["Cisatracurio", { Perro: [0.1, 0.2], Gato: [0.1, 0.2] }, ["Perro","Gato"]],
  ["Rocuronio", { Perro: [0.3, 0.6], Gato: [0.3, 0.6] }, ["Perro","Gato"]],
  ["Succinilcolina", { Perro: [0.3, 1], Gato: [0.3, 1], Caballo: [0.02, 0.05] }, ["Perro","Gato","Caballo"]],

  // ── ANESTÉSICOS LOCALES ─────────────────────────────────────
  ["Bupivacaína (regional)", { Perro: [2, 4], Gato: [2, 4] }, ["Perro","Gato"]],
  ["Levobupivacaína", { Perro: [2, 4], Gato: [2, 4] }, ["Perro","Gato"]],
  ["Lidocaína", { Perro: [4, 6], Gato: [4, 6] }, ["Perro","Gato"]],
  ["Mepivacaína", { Perro: [2, 4], Gato: [2, 4] }, ["Perro","Gato"]],
  ["Ropivacaína (regional)", { Perro: [2, 4], Gato: [2, 4] }, ["Perro","Gato"]],
  ["Tetracaína", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],

  // ── REVERSOR NM ─────────────────────────────────────────────
  ["Neostigmina", { Perro: [0.02, 0.04], Gato: [0.02, 0.04] }, ["Perro","Gato"]],

  // ── OPIOIDES ────────────────────────────────────────────────
  ["Alfentanilo", { Perro: [0.005, 0.02], Gato: [0.005, 0.02] }, ["Perro","Gato"]],
  ["Butorfanol (analgesia)", { Perro: [0.2, 0.4], Gato: [0.2, 0.4], Caballo: [0.01, 0.05] }, ["Perro","Gato","Caballo"]],
  ["Fentanilo (inyectable)", { Perro: [0.002, 0.005], Gato: [0.002, 0.005] }, ["Perro","Gato"]],
  ["Hidromorfona", { Perro: [0.05, 0.1], Gato: [0.05, 0.1] }, ["Perro","Gato"]],
  ["Metadona (analgesia)", { Perro: [0.1, 0.5], Gato: [0.1, 0.25] }, ["Perro","Gato"]],
  ["Metadona oral", { Perro: [0.2, 0.5], Gato: [0.1, 0.25] }, ["Perro","Gato"]],
  ["Oxicodona", { Perro: [0.1, 0.2], Gato: [0.1, 0.2] }, ["Perro","Gato"]],
  ["Oximorfona", { Perro: [0.05, 0.1], Gato: [0.05, 0.1] }, ["Perro","Gato"]],
  ["Remifentanilo", { Perro: [0.001, 0.003], Gato: [0.001, 0.003] }, ["Perro","Gato"]],
  ["Tapentadol", { Perro: [2, 4] }, ["Perro"]],
  ["Tramadol", { Perro: [2, 5], Gato: [1, 2] }, ["Perro","Gato"]],

  // ── AINEs ───────────────────────────────────────────────────
  ["Carprofeno", { Perro: [2.2, 4.4] }, ["Perro"], ["Gato"]],
  ["Cimicoxib", { Perro: [1, 2] }, ["Perro"], ["Gato"]],
  ["Ibuprofeno", {}, [], ["Perro","Gato"]],
  ["Ketoprofeno", { Perro: [1, 2], Gato: [1, 1] }, ["Perro","Gato"]],
  ["Ketoprofeno oral", { Perro: [1, 1] }, ["Perro"], ["Gato"]],
  ["Mavacoxib", { Perro: [2, 2] }, ["Perro"], ["Gato"]],
  ["Meloxicam inyectable", { Perro: [0.1, 0.2], Gato: [0.2, 0.3] }, ["Perro","Gato"]],
  ["Naproxeno", { Perro: [2.5, 5] }, ["Perro"], ["Gato"]],
  ["Piroxicam", { Perro: [0.3, 0.3] }, ["Perro"], ["Gato"]],
  ["Tenoxicam", { Perro: [0.4, 0.4] }, ["Perro"], ["Gato"]],
  ["Tepoxalina", { Perro: [10, 20] }, ["Perro"], ["Gato"]],
  ["Vedaprofeno", { Perro: [0.5, 0.5], Gato: [1, 1] }, ["Perro","Gato"]],

  // ── ANALGÉSICOS / ANTIINFLAMATORIOS ─────────────────────────
  ["Amantadina", { Perro: [3, 5], Gato: [3, 5] }, ["Perro","Gato"]],
  ["Amitriptilina", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Aspirina", { Perro: [10, 25], Gato: [10, 25] }, ["Perro","Gato"]],
  ["Buprenorfina", { Perro: [0.01, 0.03], Gato: [0.01, 0.03] }, ["Perro","Gato"]],
  ["Codeína", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Deracoxib", { Perro: [1, 2] }, ["Perro"], ["Gato"]],
  ["Dipirona", { Perro: [25, 40], Gato: [25, 40] }, ["Perro","Gato"]],
  ["Fentanilo (parche)", { Perro: [0.002, 0.004], Gato: [0.002, 0.004] }, ["Perro","Gato"]],
  ["Firocoxib", { Perro: [5, 5] }, ["Perro"], ["Gato"]],
  ["Flunixin Meglumina", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Gabapentina", { Perro: [10, 20], Gato: [10, 20] }, ["Perro","Gato"]],
  ["Grapiprant", { Perro: [2, 2] }, ["Perro"], ["Gato"]],
  ["Meloxicam", { Perro: [0.1, 0.2], Gato: [0.05, 0.1] }, ["Perro","Gato"]],
  ["Morfina", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Paracetamol", { Perro: [10, 15] }, ["Perro"], ["Gato"]],
  ["Pregabalina", { Perro: [4, 6], Gato: [4, 6] }, ["Perro","Gato"]],
  ["Robenacoxib", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],

  // ── ADYUVANTES ──────────────────────────────────────────────
  ["Duloxetina", { Perro: [0.5, 1] }, ["Perro"]],
  ["Venlafaxina", { Perro: [1, 2] }, ["Perro"]],

  // ── ANTIBIÓTICOS ────────────────────────────────────────────
  ["Amikacina", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Amoxicilina", { Perro: [11, 22], Gato: [11, 15], Vaca: [6.6, 11], Cerdo: [6.6, 11] }, ["Perro","Gato","Vaca","Cerdo"]],
  ["Azitromicina", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Cefadroxila", { Perro: [22, 30], Gato: [22, 30] }, ["Perro","Gato"]],
  ["Cefazolina", { Perro: [10, 20], Gato: [10, 20] }, ["Perro","Gato"]],
  ["Cefovecina", { Perro: [8, 8], Gato: [8, 8] }, ["Perro","Gato"]],
  ["Cefpodoxima", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Ceftiofur", { Perro: [2.2, 2.2], Vaca: [1.1, 2.2], Caballo: [1.1, 2.2] }, ["Perro","Vaca","Caballo"]],
  ["Ciprofloxacina", { Perro: [5, 15], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Clindamicina", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Cloranfenicol", { Perro: [25, 50], Gato: [25, 50] }, ["Perro","Gato"]],
  ["Enrofloxacina 10%", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Gentamicina", { Perro: [3, 5], Gato: [3, 5], Vaca: [2.2, 4.4] }, ["Perro","Gato","Vaca"]],
  ["Marbofloxacina", { Perro: [2.75, 5.5], Gato: [2.75, 5.5] }, ["Perro","Gato"]],
  ["Metronidazol", { Perro: [10, 25], Gato: [10, 15] }, ["Perro","Gato"]],
  ["Nitrofurantoína", { Perro: [2, 5], Gato: [2, 5] }, ["Perro","Gato"]],
  ["Ofloxacina", { Perro: [2.5, 5], Gato: [2.5, 5] }, ["Perro","Gato"]],
  ["Orbifloxacina", { Perro: [2.5, 7.5], Gato: [2.5, 7.5] }, ["Perro","Gato"]],
  ["Pradofloxacina", { Perro: [3, 6], Gato: [3, 6] }, ["Perro","Gato"]],
  ["Rifampicina", { Perro: [5, 10], Gato: [5, 10], Caballo: [5, 10] }, ["Perro","Gato","Caballo"]],
  ["Sulfadimetoxina", { Perro: [25, 50], Gato: [25, 50], Vaca: [25, 50] }, ["Perro","Gato","Vaca"]],
  ["Sulfametoxazol + Trimetoprima", { Perro: [15, 30], Gato: [15, 30] }, ["Perro","Gato"]],
  ["Tobramicina", { Perro: [3, 5], Gato: [3, 5] }, ["Perro","Gato"]],
  ["Tylosina", { Perro: [10, 20], Cerdo: [10, 20] }, ["Perro","Cerdo"]],

  // ── ANTIFÚNGICOS ────────────────────────────────────────────
  ["Anfotericina B", { Perro: [0.25, 0.5], Gato: [0.25, 0.5] }, ["Perro","Gato"]],
  ["Fluconazol", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Griseofulvina", { Perro: [25, 50], Gato: [25, 50] }, ["Perro","Gato"]],
  ["Itraconazol", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Ketoconazol", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Terbinafina", { Perro: [20, 40], Gato: [20, 40] }, ["Perro","Gato"]],
  ["Voriconazol", { Perro: [2, 5], Gato: [2, 5] }, ["Perro","Gato"]],

  // ── ANTIHISTAMÍNICOS / DERMATOLÓGICOS ───────────────────────
  ["Cetirizina", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Ciclosporina", { Perro: [5, 5], Gato: [7, 7] }, ["Perro","Gato"]],
  ["Dexametasona", { Perro: [0.1, 0.3], Gato: [0.1, 0.3] }, ["Perro","Gato"]],
  ["Diphenhydramina", { Perro: [2, 4], Gato: [2, 4] }, ["Perro","Gato"]],
  ["Hidroxizina", { Perro: [0.5, 2], Gato: [0.5, 2] }, ["Perro","Gato"]],
  ["Lokivetmab", { Perro: [1, 3] }, ["Perro"]],
  ["Loratadina", { Perro: [0.1, 0.5], Gato: [0.1, 0.5] }, ["Perro","Gato"]],
  ["Metilprednisolona", { Perro: [0.5, 2], Gato: [0.5, 2] }, ["Perro","Gato"]],
  ["Oclacitinib", { Perro: [0.4, 0.6] }, ["Perro"]],
  ["Prednisona", { Perro: [0.5, 2], Gato: [0.5, 2] }, ["Perro","Gato"]],
  ["Prednisolona", { Perro: [0.5, 2], Gato: [0.5, 2] }, ["Perro","Gato"]],
  ["Triamcinolona", { Perro: [0.1, 0.5], Gato: [0.1, 0.5] }, ["Perro","Gato"]],

  // ── ANTIPARASITARIOS ────────────────────────────────────────
  ["Afoxolaner", { Perro: [2.5, 6.8] }, ["Perro"]],
  ["Amitraz", {}, ["Perro"], ["Gato"]],
  ["Diethylcarbamaza", { Perro: [3, 6] }, ["Perro"], ["Gato"]],
  ["Espinosad", { Perro: [1.5, 2.5] }, ["Perro"]],
  ["Febantel", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Fenbendazol", { Perro: [50, 50], Gato: [50, 50] }, ["Perro","Gato"]],
  ["Fipronil", { Perro: [6, 12], Gato: [6, 12] }, ["Perro","Gato"]],
  ["Fluralaner", { Perro: [25, 56] }, ["Perro"]],
  ["Ivermectina", { Perro: [0.006, 0.012], Gato: [0.024, 0.024] }, ["Perro","Gato"]],
  ["Imidacloprid", { Perro: [10, 10], Gato: [10, 10] }, ["Perro","Gato"]],
  ["Lotilaner", { Perro: [20, 43] }, ["Perro"]],
  ["Mebendazol", { Perro: [10, 20], Gato: [10, 20] }, ["Perro","Gato"]],
  ["Milbemicina Oxima", { Perro: [0.5, 1], Gato: [2, 2] }, ["Perro","Gato"]],
  ["Miltefosina", { Perro: [2, 2] }, ["Perro"]],
  ["Moxidectina", { Perro: [0.0025, 0.005], Gato: [0.001, 0.002] }, ["Perro","Gato"]],
  ["Nitenpiram", { Perro: [1.3, 2.2], Gato: [0.9, 1.4] }, ["Perro","Gato"]],
  ["Oxfendazol", { Perro: [5, 10], Gato: [5, 10], Caballo: [10, 10] }, ["Perro","Gato","Caballo"]],
  ["Oxibendazol", { Perro: [5, 10], Gato: [5, 10], Caballo: [5, 10] }, ["Perro","Gato","Caballo"]],
  ["Permetrina", {}, ["Perro"], ["Gato"]],
  ["Pirantel Pamoato", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Praziquantel", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],
  ["Ponazuril", { Caballo: [5, 5], Perro: [20, 50], Gato: [20, 50] }, ["Caballo","Perro","Gato"]],
  ["Ronidazol", { Gato: [30, 60], Perro: [30, 60] }, ["Gato","Perro"]],
  ["Sarolaner", { Perro: [2, 4] }, ["Perro"]],
  ["Selamectina", { Perro: [6, 12], Gato: [6, 12] }, ["Perro","Gato"]],
  ["Toltrazuril", { Perro: [10, 20], Gato: [10, 20], Caballo: [5, 15] }, ["Perro","Gato","Caballo"]],

  // ── ANTINEOPLÁSICOS / QUIMIOTERAPIA ─────────────────────────
  ["Carboplatino", { Perro: [10, 15], Gato: [8, 12] }, ["Perro","Gato"]],
  ["Ciclofosfamida", { Perro: [5, 15], Gato: [5, 15] }, ["Perro","Gato"]],
  ["Doxorubicina", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Lomustina", { Perro: [1.5, 2.5], Gato: [1.5, 2.5] }, ["Perro","Gato"]],
  ["Masitinib", { Perro: [12.5, 12.5] }, ["Perro"]],
  ["Toceranib", { Perro: [2.75, 2.75] }, ["Perro"]],
  ["Vincristina", { Perro: [0.5, 0.75], Gato: [0.5, 0.75] }, ["Perro","Gato"]],

  // ── ANTIVIRALES ─────────────────────────────────────────────
  ["Aciclovir", { Perro: [10, 20], Gato: [10, 20] }, ["Perro","Gato"]],
  ["Famciclovir", { Gato: [40, 90], Perro: [20, 40] }, ["Gato","Perro"]],

  // ── ANTÍDOTOS / EMERGENCIAS ─────────────────────────────────
  ["Acetilcisteína", { Perro: [70, 140], Gato: [70, 140] }, ["Perro","Gato"]],
  ["Carbón activado", { Perro: [1, 5], Gato: [1, 5] }, ["Perro","Gato"]],
  ["Flumazenil", { Perro: [0.01, 0.02], Gato: [0.01, 0.02] }, ["Perro","Gato"]],
  ["Naloxona (anestesia)", { Perro: [0.01, 0.04], Gato: [0.01, 0.04] }, ["Perro","Gato"]],
  ["Yohimbina", { Perro: [0.05, 0.1], Gato: [0.05, 0.1], Caballo: [0.075, 0.075] }, ["Perro","Gato","Caballo"]],

  // ── ANTICOLINÉRGICOS ────────────────────────────────────────
  ["Atropina", { Perro: [0.02, 0.04], Gato: [0.02, 0.04], Caballo: [0.01, 0.02] }, ["Perro","Gato","Caballo"]],
  ["Glicopirrolato", { Perro: [0.005, 0.01], Gato: [0.005, 0.01] }, ["Perro","Gato"]],

  // ── ANTICONVULSIVANTES ──────────────────────────────────────
  ["Bromuro de potasio", { Perro: [15, 40] }, ["Perro"], ["Gato"]],
  ["Fenobarbital", { Perro: [2, 5], Gato: [2, 5] }, ["Perro","Gato"]],
  ["Levetiracetam", { Perro: [20, 30], Gato: [20, 30] }, ["Perro","Gato"]],

  // ── CARDIOVASCULARES ────────────────────────────────────────
  ["Amlodipino", { Perro: [0.1, 0.3], Gato: [0.625, 1.25] }, ["Perro","Gato"]],
  ["Atenolol", { Perro: [0.5, 1], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Benazepril", { Perro: [0.25, 0.5], Gato: [0.25, 0.5] }, ["Perro","Gato"]],
  ["Captopril", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Carvedilol", { Perro: [0.1, 0.2], Gato: [0.1, 0.2] }, ["Perro","Gato"]],
  ["Clopidogrel", { Perro: [1, 3], Gato: [3, 4] }, ["Perro","Gato"]],
  ["Digoxina", { Perro: [0.005, 0.01], Gato: [0.005, 0.01] }, ["Perro","Gato"]],
  ["Diltiazem", { Perro: [0.5, 1], Gato: [1.5, 2] }, ["Perro","Gato"]],
  ["Enalapril", { Perro: [0.25, 0.5], Gato: [0.25, 0.5] }, ["Perro","Gato"]],
  ["Espironolactona", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Hidralazina", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Hidroclorotiazida", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Losartán", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Metoprolol", { Perro: [0.2, 1], Gato: [0.2, 1] }, ["Perro","Gato"]],
  ["Pimobendán", { Perro: [0.25, 0.5], Gato: [0.25, 0.5] }, ["Perro","Gato"]],
  ["Propranolol", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Ramipril", { Perro: [0.125, 0.25], Gato: [0.125, 0.25] }, ["Perro","Gato"]],
  ["Sildenafilo", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Sotalol", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Tadalafilo", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Telmisartán", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Torsemida", { Perro: [0.1, 0.2], Gato: [0.1, 0.2] }, ["Perro","Gato"]],

  // ── VASOPRESORES ────────────────────────────────────────────
  ["Epinefrina", { Perro: [0.01, 0.02], Gato: [0.01, 0.02] }, ["Perro","Gato"]],
  ["Norepinefrina", { Perro: [0.001, 0.01], Gato: [0.001, 0.01] }, ["Perro","Gato"]],

  // ── ENDOCRINOS ──────────────────────────────────────────────
  ["Alopurinol", { Perro: [10, 20], Gato: [10, 20] }, ["Perro","Gato"]],
  ["Cabergolina", { Perro: [0.005, 0.01], Gato: [0.005, 0.01] }, ["Perro","Gato"]],
  ["Desmopresina", { Perro: [0.001, 0.002], Gato: [0.001, 0.002] }, ["Perro","Gato"]],
  ["Desoxicorticosterona", { Perro: [0.15, 0.2] }, ["Perro"]],
  ["Fenilpropanolamina", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Fludrocortisona", { Perro: [0.01, 0.02], Gato: [0.01, 0.02] }, ["Perro","Gato"]],
  ["Levotiroxina", { Perro: [0.01, 0.02], Gato: [0.015, 0.03] }, ["Perro","Gato"]],
  ["Metimazol", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Mitotano", { Perro: [25, 50] }, ["Perro"], ["Gato"]],
  ["Trilostano", { Perro: [2, 5], Gato: [2, 5] }, ["Perro","Gato"]],

  // ── GASTROINTESTINALES ──────────────────────────────────────
  ["Cimetidina", { Perro: [3, 5], Gato: [3, 5] }, ["Perro","Gato"]],
  ["Cisaprida", { Perro: [0.1, 0.5], Gato: [0.1, 0.5] }, ["Perro","Gato"]],
  ["Domperidona", { Perro: [0.2, 0.5], Gato: [0.2, 0.5] }, ["Perro","Gato"]],
  ["Famotidina", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Loperamida", { Perro: [0.1, 0.2] }, ["Perro"], ["Gato"]],
  ["Maropitant", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Metoclopramida", { Perro: [0.2, 0.5], Gato: [0.2, 0.5] }, ["Perro","Gato"]],
  ["Misoprostol", { Perro: [2, 3], Gato: [2, 3] }, ["Perro","Gato"]],
  ["Omeprazol", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Ondansetrón", { Perro: [0.1, 0.5], Gato: [0.1, 0.5] }, ["Perro","Gato"]],
  ["Pantoprazol", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Rabeprazol", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["SAMe", { Perro: [10, 20], Gato: [10, 20] }, ["Perro","Gato"]],
  ["Sucralfato", { Perro: [0.25, 1], Gato: [0.25, 1] }, ["Perro","Gato"]],
  ["Ursodiol", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],

  // ── HEMOSTÁTICOS ────────────────────────────────────────────
  ["Etamsilato", { Perro: [5, 10], Gato: [5, 10] }, ["Perro","Gato"]],

  // ── RESPIRATORIOS / BRONCODILATADORES ───────────────────────
  ["Salbutamol", { Perro: [0.02, 0.1], Gato: [0.02, 0.1] }, ["Perro","Gato"]],
  ["Teofilina", { Perro: [4, 6], Gato: [4, 6] }, ["Perro","Gato"]],
  ["Terbutalina", { Perro: [0.3, 0.6], Gato: [0.3, 0.6] }, ["Perro","Gato"]],

  // ── REVERSOR ALPHA-2 ────────────────────────────────────────
  ["Atipamezol", { Perro: [0.005, 0.05], Gato: [0.005, 0.05], Caballo: [0.005, 0.05] }, ["Perro","Gato","Caballo"]],

  // ── UROLÓGICOS ──────────────────────────────────────────────
  ["Fenoxibenzamina", { Perro: [0.2, 0.5], Gato: [0.2, 0.5] }, ["Perro","Gato"]],
  ["Finasterida", { Perro: [0.1, 0.5] }, ["Perro"], ["Gato"]],
  ["Prazosina", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Tamsulosina", { Perro: [0.004, 0.01], Gato: [0.004, 0.01] }, ["Perro","Gato"]],

  // ── VITAMINAS Y SUPLEMENTOS ─────────────────────────────────
  ["Coenzima Q10", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Condroitina", { Perro: [10, 20], Gato: [10, 20] }, ["Perro","Gato"]],
  ["Glucosamina", { Perro: [10, 20], Gato: [10, 20] }, ["Perro","Gato"]],
  ["L-Carnitina", { Perro: [25, 50] }, ["Perro"], ["Gato"]],
  ["Omega-3 (EPA/DHA)", { Perro: [10, 40], Gato: [10, 40] }, ["Perro","Gato"]],
  ["Silymarina", { Perro: [1, 2], Gato: [1, 2] }, ["Perro","Gato"]],
  ["Taurina", { Perro: [0.2, 0.5], Gato: [0.2, 0.5] }, ["Perro","Gato"]],
  ["Vitamina B Complex", { Perro: [0.5, 1], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Vitamina B12", { Perro: [0.005, 0.01], Gato: [0.005, 0.01] }, ["Perro","Gato"]],
  ["Vitamina K1", { Perro: [1, 5], Gato: [1, 5] }, ["Perro","Gato"]],

  // ── CONDUCTA / PSICOTRÓPICOS ────────────────────────────────
  ["Alprazolam", { Perro: [0.02, 0.1], Gato: [0.02, 0.1] }, ["Perro","Gato"]],
  ["Clomipramina", { Perro: [0.5, 2], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Fluoxetina", { Perro: [0.5, 2], Gato: [0.5, 1] }, ["Perro","Gato"]],
  ["Selegilina", { Perro: [0.5, 1] }, ["Perro"], ["Gato"]],
  ["Trazodona", { Perro: [3, 7], Gato: [2, 5] }, ["Perro","Gato"]],

];

// Exportación para uso en build/migración y (opcional) frontend
if (typeof module !== "undefined" && module.exports) {
  module.exports = { DOSIS_ESPECIE };
}
