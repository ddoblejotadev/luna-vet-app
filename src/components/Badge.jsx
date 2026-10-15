import './Badge.css'

export default function Badge({ children, icon, className = '' }) {
  return (
    <span className={`badge ${className}`}>
      {icon && <span className="badge-icon">{icon}</span>}
      {children}
    </span>
  )
}
