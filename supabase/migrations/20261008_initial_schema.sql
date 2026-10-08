-- ============================================================================
-- LUNAVET DATABASE SCHEMA
-- Calculadora Veterinaria Inteligente
-- ============================================================================

-- Habilitar extensiones necesarias
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- ============================================================================
-- TABLA: medicamentos
-- Catálogo principal de medicamentos veterinarios
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.medicamentos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nombre VARCHAR(255) NOT NULL,
  principio_activo VARCHAR(255),
  familia_terapeutica VARCHAR(100) NOT NULL,
  presentacion VARCHAR(255),
  concentracion VARCHAR(100),
  dosis_recomendada TEXT,
  dosis_minima_mg_kg DECIMAL(10, 4),
  dosis_maxima_mg_kg DECIMAL(10, 4),
  via_administracion VARCHAR(50),
  frecuencia_horas INTEGER,
  contraindicaciones TEXT,
  efectos_secundarios TEXT,
  interacciones TEXT,
  notas TEXT,
  fuente VARCHAR(100),
  url_referencia TEXT,
  activo BOOLEAN DEFAULT true,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Índices para búsquedas rápidas
CREATE INDEX idx_medicamentos_nombre ON public.medicamentos(nombre);
CREATE INDEX idx_medicamentos_familia ON public.medicamentos(familia_terapeutica);
CREATE INDEX idx_medicamentos_principio ON public.medicamentos(principio_activo);
CREATE INDEX idx_medicamentos_activo ON public.medicamentos(activo);

-- ============================================================================
-- TABLA: especies
-- Especies animales para cálculos específicos
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.especies (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  nombre VARCHAR(100) NOT NULL UNIQUE,
  nombre_cientifico VARCHAR(100),
  factor_bsa DECIMAL(10, 4) DEFAULT 10.1,
  exponente_bsa DECIMAL(5, 2) DEFAULT 0.67,
  peso_promedio_kg DECIMAL(10, 2),
  notas TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- ============================================================================
-- TABLA: usuarios
-- Veterinarios registrados en la plataforma
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.usuarios (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  email VARCHAR(255) NOT NULL UNIQUE,
  nombre VARCHAR(100),
  apellido VARCHAR(100),
  matricula VARCHAR(50),
  pais VARCHAR(2) DEFAULT 'AR',
  activo BOOLEAN DEFAULT true,
  plan VARCHAR(20) DEFAULT 'free',
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_usuarios_email ON public.usuarios(email);
CREATE INDEX idx_usuarios_activo ON public.usuarios(activo);

-- ============================================================================
-- TABLA: historial_calculos
-- Registro de cálculos realizados por usuario
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.historial_calculos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  usuario_id UUID REFERENCES public.usuarios(id) ON DELETE CASCADE,
  medicamento_id UUID REFERENCES public.medicamentos(id) ON DELETE SET NULL,
  especie_id UUID REFERENCES public.especies(id) ON DELETE SET NULL,
  peso_kg DECIMAL(10, 2) NOT NULL,
  dosis_calculada DECIMAL(10, 4) NOT NULL,
  metodo_calculo VARCHAR(20) NOT NULL, -- 'peso', 'bsa', 'margen'
  frecuencia_horas INTEGER,
  notas TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE INDEX idx_historial_usuario ON public.historial_calculos(usuario_id);
CREATE INDEX idx_historial_medicamento ON public.historial_calculos(medicamento_id);
CREATE INDEX idx_historial_fecha ON public.historial_calculos(created_at);

-- ============================================================================
-- TABLA: medicamentos_favoritos
-- Medicamentos guardados por usuario para acceso rápido
-- ============================================================================
CREATE TABLE IF NOT EXISTS public.medicamentos_favoritos (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  usuario_id UUID REFERENCES public.usuarios(id) ON DELETE CASCADE,
  medicamento_id UUID REFERENCES public.medicamentos(id) ON DELETE CASCADE,
  notas_personales TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
  UNIQUE(usuario_id, medicamento_id)
);

CREATE INDEX idx_favoritos_usuario ON public.medicamentos_favoritos(usuario_id);

-- ============================================================================
-- FUNCIONES Y TRIGGERS
-- ============================================================================

-- Función para actualizar updated_at automáticamente
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger para medicamentos
CREATE TRIGGER update_medicamentos_updated_at
  BEFORE UPDATE ON public.medicamentos
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- Trigger para usuarios
CREATE TRIGGER update_usuarios_updated_at
  BEFORE UPDATE ON public.usuarios
  FOR EACH ROW
  EXECUTE FUNCTION update_updated_at_column();

-- ============================================================================
-- ROW LEVEL SECURITY (RLS)
-- ============================================================================

-- Habilitar RLS en todas las tablas
ALTER TABLE public.medicamentos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.especies ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.usuarios ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.historial_calculos ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.medicamentos_favoritos ENABLE ROW LEVEL SECURITY;

-- Políticas para medicamentos (lectura pública, escritura admin)
CREATE POLICY "Medicamentos son públicos para lectura"
  ON public.medicamentos FOR SELECT
  USING (activo = true);

CREATE POLICY "Solo admins pueden insertar medicamentos"
  ON public.medicamentos FOR INSERT
  WITH CHECK (auth.jwt() ->> 'role' = 'admin');

CREATE POLICY "Solo admins pueden actualizar medicamentos"
  ON public.medicamentos FOR UPDATE
  USING (auth.jwt() ->> 'role' = 'admin');

-- Políticas para especies (lectura pública)
CREATE POLICY "Especies son públicas para lectura"
  ON public.especies FOR SELECT
  USING (true);

-- Políticas para usuarios (solo propios datos)
CREATE POLICY "Usuarios pueden ver su propio perfil"
  ON public.usuarios FOR SELECT
  USING (auth.uid() = id);

CREATE POLICY "Usuarios pueden actualizar su propio perfil"
  ON public.usuarios FOR UPDATE
  USING (auth.uid() = id);

-- Políticas para historial (solo propios datos)
CREATE POLICY "Usuarios pueden ver su propio historial"
  ON public.historial_calculos FOR SELECT
  USING (auth.uid() = usuario_id);

CREATE POLICY "Usuarios pueden insertar en su propio historial"
  ON public.historial_calculos FOR INSERT
  WITH CHECK (auth.uid() = usuario_id);

-- Políticas para favoritos (solo propios datos)
CREATE POLICY "Usuarios pueden ver sus propios favoritos"
  ON public.medicamentos_favoritos FOR SELECT
  USING (auth.uid() = usuario_id);

CREATE POLICY "Usuarios pueden insertar sus propios favoritos"
  ON public.medicamentos_favoritos FOR INSERT
  WITH CHECK (auth.uid() = usuario_id);

CREATE POLICY "Usuarios pueden eliminar sus propios favoritos"
  ON public.medicamentos_favoritos FOR DELETE
  USING (auth.uid() = usuario_id);

-- ============================================================================
-- DATOS INICIALES: Especies comunes
-- ============================================================================
INSERT INTO public.especies (nombre, nombre_cientifico, factor_bsa, exponente_bsa, peso_promedio_kg) VALUES
  ('Perro', 'Canis lupus familiaris', 10.1, 0.67, 15.0),
  ('Gato', 'Felis catus', 10.0, 0.67, 4.5),
  ('Caballo', 'Equus caballus', 10.1, 0.67, 450.0),
  ('Vaca', 'Bos taurus', 10.1, 0.67, 600.0),
  ('Oveja', 'Ovis aries', 10.1, 0.67, 70.0),
  ('Cerdo', 'Sus scrofa domesticus', 10.1, 0.67, 100.0),
  ('Conejo', 'Oryctolagus cuniculus', 10.0, 0.67, 2.5)
ON CONFLICT (nombre) DO NOTHING;

-- ============================================================================
-- DATOS INICIALES: Medicamentos de ejemplo
-- ============================================================================
INSERT INTO public.medicamentos (
  nombre, 
  principio_activo, 
  familia_terapeutica, 
  presentacion, 
  concentracion,
  dosis_recomendada, 
  dosis_minima_mg_kg, 
  dosis_maxima_mg_kg,
  via_administracion,
  frecuencia_horas,
  fuente
) VALUES
  (
    'Ketamina 10%', 
    'Ketamina', 
    'Sedantes y Anestésicos', 
    'Inyectable', 
    '100 mg/ml',
    '5-15 mg/kg IM', 
    5.0, 
    15.0,
    'Intramuscular',
    24,
    'DailyMed'
  ),
  (
    'Meloxicam', 
    'Meloxicam', 
    'Analgésicos / Antiinflamatorios', 
    'Suspensión oral', 
    '1.5 mg/ml',
    '0.1-0.2 mg/kg PO cada 24h', 
    0.1, 
    0.2,
    'Oral',
    24,
    'NOAH'
  ),
  (
    'Enrofloxacina 10%', 
    'Enrofloxacina', 
    'Antibióticos / Antimicrobianos', 
    'Inyectable', 
    '100 mg/ml',
    '5-10 mg/kg SC/IM cada 24h', 
    5.0, 
    10.0,
    'Subcutánea/Intramuscular',
    24,
    'SENASA'
  ),
  (
    'Vitamina B Complex', 
    'Complejo B', 
    'Vitaminas y Suplementos', 
    'Inyectable', 
    'Variable',
    '1-2 ml IM cada 7 días', 
    0.05, 
    0.1,
    'Intramuscular',
    168,
    'WSAVA'
  ),
  (
    'Metoclopramida', 
    'Metoclopramida', 
    'Gastrointestinales', 
    'Inyectable', 
    '5 mg/ml',
    '0.2-0.5 mg/kg SC/IM cada 8h', 
    0.2, 
    0.5,
    'Subcutánea/Intramuscular',
    8,
    'DailyMed'
  ),
  (
    'Enalapril', 
    'Enalapril', 
    'Cardiovasculares', 
    'Comprimidos', 
    '5 mg',
    '0.5 mg/kg PO cada 12-24h', 
    0.25, 
    1.0,
    'Oral',
    12,
    'NOAH'
  )
ON CONFLICT DO NOTHING;

-- ============================================================================
-- COMENTARIOS
-- ============================================================================
COMMENT ON TABLE public.medicamentos IS 'Catálogo de medicamentos veterinarios con dosis y referencias';
COMMENT ON TABLE public.especies IS 'Especies animales con parámetros específicos para cálculo';
COMMENT ON TABLE public.usuarios IS 'Veterinarios registrados en la plataforma';
COMMENT ON TABLE public.historial_calculos IS 'Historial de cálculos de dosis realizados';
COMMENT ON TABLE public.medicamentos_favoritos IS 'Medicamentos guardados por usuario';
