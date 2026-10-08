# Configuración de Supabase para LunaVet

## Requisitos Previos

- Node.js 18+ instalado
- Cuenta en [Supabase](https://supabase.com)
- Supabase CLI (opcional para desarrollo local)

## Opción 1: Desarrollo Local con Supabase CLI

### 1. Instalar Supabase CLI

```bash
npm install -g supabase
```

### 2. Iniciar servicios locales

```bash
cd /home/doblejota94/Projects/ProyectosLunita/Luna1
npx supabase start
```

Esto iniciará:
- PostgreSQL en `localhost:54322`
- API en `localhost:54321`
- Studio en `http://localhost:54323`

### 3. Aplicar migraciones

```bash
npx supabase db push
```

### 4. Cargar datos de prueba

```bash
npx supabase db seed
```

### 5. Configurar variables de entorno

Copia `.env.example` a `.env` y actualiza con las credenciales locales:

```bash
cp .env.example .env
```

Edita `.env`:
```env
VITE_SUPABASE_URL=http://localhost:54321
VITE_SUPABASE_ANON_KEY=<tu-anon-key-local>
```

## Opción 2: Supabase Cloud (Producción)

### 1. Crear proyecto en Supabase

1. Ve a [https://app.supabase.com](https://app.supabase.com)
2. Crea un nuevo proyecto
3. Guarda:
   - **Project URL**: `https://tu-proyecto.supabase.co`
   - **Anon Public Key**: `eyJhbG...`

### 2. Aplicar esquema

Puedes aplicar el esquema de dos formas:

#### Opción A: SQL Editor en Supabase Studio

1. Abre tu proyecto en Supabase
2. Ve a **SQL Editor**
3. Copia y pega el contenido de `supabase/migrations/20261008_initial_schema.sql`
4. Ejecuta el script
5. Repite con `supabase/seed.sql` para datos de ejemplo

#### Opción B: Supabase CLI

```bash
# Enlazar tu proyecto local con Supabase Cloud
npx supabase link --project-ref <tu-project-id>

# Aplicar migraciones
npx supabase db push
```

### 3. Configurar variables de entorno

Edita `.env`:
```env
VITE_SUPABASE_URL=https://tu-proyecto.supabase.co
VITE_SUPABASE_ANON_KEY=eyJhbG...
```

## Estructura de la Base de Datos

### Tablas

1. **medicamentos**: Catálogo de medicamentos veterinarios
   - Nombre, principio activo, familia terapéutica
   - Dosis recomendada (min/max)
   - Vía de administración, frecuencia
   - Contraindicaciones, efectos secundarios

2. **especies**: Especies animales con parámetros específicos
   - Nombre común y científico
   - Factores para cálculo de BSA (superficie corporal)
   - Peso promedio

3. **usuarios**: Veterinarios registrados
   - Email, nombre, matrícula
   - Plan de suscripción

4. **historial_calculos**: Registro de cálculos realizados
   - Usuario, medicamento, especie
   - Peso, método y frecuencia
   - Dosis única calculada para cálculos manuales
   - Rango mínimo/máximo calculado para medicamentos del catálogo
   - Dosis mínima/máxima mg/kg usada como fuente del cálculo

5. **medicamentos_favoritos**: Medicamentos guardados por usuario
   - Acceso rápido a medicamentos frecuentes

### Row Level Security (RLS)

- ✅ **Medicamentos**: Lectura pública, escritura solo admin
- ✅ **Especies**: Lectura pública
- ✅ **Usuarios**: Solo pueden ver/editar su propio perfil
- ✅ **Historial**: Solo pueden ver su propio historial
- ✅ **Favoritos**: Solo pueden ver/editar sus propios favoritos

## Comandos Útiles

```bash
# Iniciar Supabase local
npm run db:studio

# Ver logs de la base de datos
npx supabase logs db

# Resetear base de datos local
npx supabase db reset

# Crear nueva migración
npx supabase migration new nombre_migracion

# Ver diferencias entre local y remoto
npx supabase db diff
```

## Solución de Problemas Comunes

### Error: "Maximum combo retry limit reached"

Este error ocurre cuando Supabase intenta reconectar muchas veces sin éxito.

**Soluciones:**

1. **Verifica tu conexión de red**
2. **Revisa las credenciales en `.env`**
3. **Aumenta el timeout en `supabase.js`:**

```javascript
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY, {
  auth: {
    persistSession: true,
    autoRefreshToken: true,
  },
  global: {
    headers: {
      'x-client-info': 'lunavet-app',
    },
  },
  db: {
    schema: 'public',
  },
  realtime: {
    params: {
      eventsPerSecond: 2,
    },
    timeout: 30000, // 30 segundos
  },
})
```

4. **Usa el servicio de pagos con reintentos** (ya implementado en `paymentService.js`)

### Error: "relation does not exist"

Significa que las tablas no fueron creadas.

```bash
# Aplicar migraciones
npx supabase db push
```

### Error de autenticación

Verifica que las políticas RLS estén habilitadas y configuradas correctamente.

## Recursos Adicionales

- [Documentación de Supabase](https://supabase.com/docs)
- [Supabase CLI](https://supabase.com/docs/guides/cli)
- [Row Level Security](https://supabase.com/docs/guides/auth/row-level-security)
- [API de JavaScript](https://supabase.com/docs/reference/javascript/introduction)

## Próximos Pasos

1. ✅ Ejecutar migraciones
2. ✅ Cargar datos de ejemplo
3. ✅ Configurar autenticación de usuarios
4. ⏳ Implementar búsqueda full-text
5. ⏳ Agregar más medicamentos al catálogo
6. ⏳ Implementar sistema de reportes
