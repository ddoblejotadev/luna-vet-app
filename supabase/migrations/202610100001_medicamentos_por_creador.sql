-- Agregar columna de creador a medicamentos
-- Permite que cada usuario gestione solo los medicamentos que agrega
ALTER TABLE public.medicamentos ADD COLUMN IF NOT EXISTS creado_por UUID REFERENCES auth.users(id);

-- Políticas de RLS por creador
-- INSERT: cualquier usuario autenticado puede crear, pero solo con su propio ID
CREATE POLICY "Usuarios pueden insertar sus propios medicamentos"
  ON public.medicamentos
  FOR INSERT
  TO authenticated
  WITH CHECK (creado_por = auth.uid());

-- UPDATE: solo el creador (o un admin) puede actualizar
CREATE POLICY "Creadores y admins pueden actualizar medicamentos"
  ON public.medicamentos
  FOR UPDATE
  TO authenticated
  USING (creado_por = auth.uid() OR (auth.jwt() ->> 'role'::text) = 'admin'::text);

-- DELETE: solo el creador puede eliminar (ni admins pueden borrar medicamentos de otros)
CREATE POLICY "Creadores pueden eliminar sus medicamentos"
  ON public.medicamentos
  FOR DELETE
  TO authenticated
  USING (creado_por = auth.uid());

-- Eliminar las políticas antiguas de admin-only (ya no aplican)
DROP POLICY IF EXISTS "Solo admins pueden insertar medicamentos" ON public.medicamentos;
DROP POLICY IF EXISTS "Solo admins pueden actualizar medicamentos" ON public.medicamentos;
