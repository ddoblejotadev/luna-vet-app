# LunaVet App

Calculadora veterinaria inteligente para gestión de dosis y catálogo de medicamentos.

## Características Principales

- 📊 Catálogo de medicamentos organizado por familias terapéuticas
- ⚡ Cálculo automático de dosis en función del peso del animal
- 📱 Diseño responsive para uso en iPhone, iPad y computadoras
- 🔒 Privacidad y seguridad en datos
- 📖 Gestión de medicamentos personalizada por veterinario

## FAMILIAS TERAPÉUTICAS

- 💉 Sedantes y Anestésicos
- 💊 Analgésicos / Antiinflamatorios
- 🦠 Antibióticos / Antimicrobianos
- 🧪 Vitaminas y Suplementos
- 🤢 Gastrointestinales
- 🫀 Cardiovasculares

## ESTRUCTURA DEL PROYECTO

- `src/components/` - Componentes React reutilizables
- `src/hooks/` - Hooks personalizados (lógica de cálculo)
- `src/services/` - Servicios (Supabase, API)
- `src/utils/` - Funciones utilitarias
- `supabase/` - Configuración de base de datos
- `public/` - Recursos estáticos (iconos, imágenes)

## INSTALACIÓN Y EJECUCIÓN

1. Instalar dependencias:
```bash
npm install
```

2. Iniciar entorno de desarrollo:
```bash
npm run dev
```

3. Iniciar base de datos Supabase:
```bash
npm run db:studio
```

## FUENTES DE DATOS

Los datos de los medicamentos se basan en fuentes oficiales:
- [DailyMed](https://dailymed.nlm.nih.gov/) - Etiquetas de aprobación FDA
- [NOAH Compendium](https://www.noahcompendium.co.uk/) - UK Veterinary Medicines
- [WSAVA](https://wsava.org/) - World Small Animal Veterinary Association
- Argentina SENASA - Registro oficial de productos

## DESARROLLO

Para más información sobre el desarrollo, ver las guías de estilo y convenciones en el repositorio.

## LICENCIA

Este proyecto es un software educativo y de demostración. Todos los datos son proporcionados por terceras partes y no constituyen consejo médico profesional.