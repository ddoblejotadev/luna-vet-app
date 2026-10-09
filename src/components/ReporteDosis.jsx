const METODO_LABELS = {
  peso: 'Dosis fija por kg',
  catalogo: 'Rango de dosis del catálogo',
  bsa: 'Superficie corporal (BSA)',
  margen: 'Cálculo con margen de seguridad',
}

const RISK_LABELS = {
  normal: 'Normal',
  precaucion: 'Precaución',
  alto: 'Alto',
  critico: 'Crítico',
}

function ReporteRow({ label, children }) {
  return (
    <div className="reporte-row">
      <span>{label}</span>
      <strong>{children}</strong>
    </div>
  )
}

function ResultadoReporte({ metodo, resultado, margen }) {
  if (!resultado) return null

  if (metodo === 'catalogo' && resultado.dosisMinSingle !== undefined) {
    return (
      <>
        <ReporteRow label="Dosis mínima por toma">{resultado.dosisMinSingle} {resultado.unidad}</ReporteRow>
        <ReporteRow label="Dosis máxima por toma">{resultado.dosisMaxSingle} {resultado.unidad}</ReporteRow>
        <ReporteRow label="Dosis mínima diaria">{resultado.dosisMinDaily} {resultado.unidad}</ReporteRow>
        <ReporteRow label="Dosis máxima diaria">{resultado.dosisMaxDaily} {resultado.unidad}</ReporteRow>
      </>
    )
  }

  if (metodo === 'margen' && resultado.dosisBase !== undefined) {
    return (
      <>
        <ReporteRow label="Dosis base">{resultado.dosisBase} {resultado.unidad}</ReporteRow>
        <ReporteRow label={`Dosis mínima (-${resultado.margen ?? margen ?? 10}%)`}>{resultado.dosisMin} {resultado.unidad}</ReporteRow>
        <ReporteRow label={`Dosis máxima (+${resultado.margen ?? margen ?? 10}%)`}>{resultado.dosisMax} {resultado.unidad}</ReporteRow>
      </>
    )
  }

  return (
    <>
      <ReporteRow label="Dosis por toma">{resultado.dosisSingle} {resultado.unidad}</ReporteRow>
      <ReporteRow label="Dosis diaria">{resultado.dosisDaily} {resultado.unidad}</ReporteRow>
      {resultado.bsa && <ReporteRow label="Superficie corporal (BSA)">{resultado.bsa} m²</ReporteRow>}
    </>
  )
}

export default function ReporteDosis({ medicamento, especie, peso, metodo, resultado, margen }) {
  const fecha = new Date().toLocaleString('es-AR', {
    dateStyle: 'long',
    timeStyle: 'short',
  })

  return (
    <article className="reporte-dosis">
      <header className="reporte-header">
        <div>
          <p className="reporte-app">LunaVet</p>
          <h1>Reporte de cálculo de dosis</h1>
        </div>
        <p className="reporte-fecha">{fecha}</p>
      </header>

      <section className="reporte-section">
        <h2>Paciente</h2>
        <ReporteRow label="Especie">{especie || 'No informada'}</ReporteRow>
        <ReporteRow label="Peso">{peso} kg</ReporteRow>
      </section>

      <section className="reporte-section">
        <h2>Medicamento</h2>
        <ReporteRow label="Nombre">{medicamento?.nombre || 'No seleccionado'}</ReporteRow>
        {medicamento?.principio_activo && <ReporteRow label="Principio activo">{medicamento.principio_activo}</ReporteRow>}
        {medicamento?.familia_terapeutica && <ReporteRow label="Familia terapéutica">{medicamento.familia_terapeutica}</ReporteRow>}
        {medicamento?.presentacion && <ReporteRow label="Presentación">{medicamento.presentacion}</ReporteRow>}
        {medicamento?.concentracion && <ReporteRow label="Concentración">{medicamento.concentracion}</ReporteRow>}
        {medicamento?.via_administracion && <ReporteRow label="Vía de administración">{medicamento.via_administracion}</ReporteRow>}
      </section>

      <section className="reporte-section">
        <h2>Resultado del cálculo</h2>
        <ReporteRow label="Método">{METODO_LABELS[metodo] || metodo}</ReporteRow>
        <ResultadoReporte metodo={metodo} resultado={resultado} margen={margen} />
        <ReporteRow label="Frecuencia">Cada {resultado?.frecuencia || '—'} horas</ReporteRow>
        {resultado?.notas && <ReporteRow label="Indicación">{resultado.notas}</ReporteRow>}
      </section>

      <section className="reporte-section">
        <h2>Seguridad clínica</h2>
        <ReporteRow label="Nivel de riesgo">{RISK_LABELS[medicamento?.nivel_riesgo] || medicamento?.nivel_riesgo || 'No informado'}</ReporteRow>
        {medicamento?.especies_permitidas?.length > 0 && (
          <ReporteRow label="Especies permitidas">{medicamento.especies_permitidas.join(', ')}</ReporteRow>
        )}
        {medicamento?.especies_contraindicadas?.length > 0 && (
          <ReporteRow label="Especies contraindicadas">{medicamento.especies_contraindicadas.join(', ')}</ReporteRow>
        )}
        {medicamento?.alertas_clinicas?.length > 0 && (
          <div className="reporte-alertas">
            <span>Alertas clínicas</span>
            <ul>
              {medicamento.alertas_clinicas.map((alerta) => (
                <li key={alerta}>{alerta}</li>
              ))}
            </ul>
          </div>
        )}
      </section>

      <footer className="reporte-footer">
        {medicamento?.fuente && <p><strong>Fuente de dosis:</strong> {medicamento.fuente}</p>}
        <p className="reporte-disclaimer">
          Reporte generado por LunaVet como herramienta de apoyo. Toda dosis debe ser verificada por un
          veterinario matriculado antes de administrarse. LunaVet no reemplaza la consulta clínica.
        </p>
      </footer>
    </article>
  )
}
