/**
 * Sticker kawaii de LunaVet: un gatito redondo con moño rosa.
 * Original (no es la marca Hello Kitty), dibujado en SVG para que
 * escale sin pérdida de calidad.
 */
export default function KawaiiSticker({ size = 48, className = '', alt = 'LunaVet' }) {
  return (
    <svg
      className={`kawaii-sticker ${className}`}
      width={size}
      height={size}
      viewBox="0 0 64 64"
      role="img"
      aria-label={alt}
      aria-hidden={alt ? undefined : true}
    >
      <circle cx="32" cy="34" r="24" fill="#FFFFFF" stroke="#F472B6" strokeWidth="2.5" />
      <path d="M12 22 L18 8 L26 18 Z" fill="#FFFFFF" stroke="#F472B6" strokeWidth="2.5" strokeLinejoin="round" />
      <path d="M52 22 L46 8 L38 18 Z" fill="#FFFFFF" stroke="#F472B6" strokeWidth="2.5" strokeLinejoin="round" />
      <path d="M16 19 L19 12 L23 17 Z" fill="#FCE7F3" />
      <path d="M48 19 L45 12 L41 17 Z" fill="#FCE7F3" />
      <path d="M32 10 C26 2 16 4 16 10 C16 15 24 16 32 12 C40 16 48 15 48 10 C48 4 38 2 32 10 Z" fill="#F472B6" />
      <circle cx="32" cy="11" r="2.6" fill="#DB2777" />
      <path d="M20 32 Q24 28 28 32" fill="none" stroke="#43304F" strokeWidth="2.5" strokeLinecap="round" />
      <path d="M36 32 Q40 28 44 32" fill="none" stroke="#43304F" strokeWidth="2.5" strokeLinecap="round" />
      <path d="M30 37 Q32 39 34 37 Q32 41 30 37 Z" fill="#F472B6" />
      <path d="M32 41 Q32 44 29 44 M32 41 Q32 44 35 44" fill="none" stroke="#43304F" strokeWidth="2" strokeLinecap="round" />
      <ellipse cx="18" cy="38" rx="3.5" ry="2.2" fill="#FCE7F3" />
      <ellipse cx="46" cy="38" rx="3.5" ry="2.2" fill="#FCE7F3" />
    </svg>
  )
}
