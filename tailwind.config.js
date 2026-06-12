/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: 'media',
  content: [
    "./Views/**/*.cshtml",
    "./Views/**/*.html",
    "./wwwroot/**/*.html",
    "./wwwroot/**/*.js",
  ],
  theme: {
    extend: {
      fontFamily: {
        sans: ['Geist', 'ui-sans-serif', 'system-ui', 'sans-serif'],
      },
      colors: {
        /* Layout backgrounds */
        page:    'var(--bg-page)',
        surface: 'var(--bg-surface)',
        hover:   'var(--bg-hover)',
        subtle:  'var(--bg-subtle)',

        /* Text palette */
        primary:   'var(--text-primary)',
        secondary: 'var(--text-secondary)',
        tertiary:  'var(--text-tertiary)',
        link:      'var(--text-link)',

        /* Border tones */
        medium: 'var(--border-medium)',
        strong: 'var(--border-strong)',

        /* Accent — purple */
        accent:          'var(--accent)',
        'accent-bg':     'var(--accent-bg)',
        'accent-text':   'var(--accent-text)',
        'accent-border': 'var(--accent-border)',

        /* Verified — green */
        verified:          'var(--verified)',
        'verified-bg':     'var(--verified-bg)',
        'verified-text':   'var(--verified-text)',
        'verified-border': 'var(--verified-border)',

        /* Featured — amber */
        featured:          'var(--featured)',
        'featured-bg':     'var(--featured-bg)',
        'featured-text':   'var(--featured-text)',
        'featured-border': 'var(--featured-border)',

        /* MRR Backgrounds */
        'mrr-0-bg':       'var(--mrr-0-bg)',
        'mrr-1k-bg':      'var(--mrr-1k-bg)',
        'mrr-10k-bg':     'var(--mrr-10k-bg)',
        'mrr-100k-bg':    'var(--mrr-100k-bg)',
        'mrr-big-bg':     'var(--mrr-big-bg)',
      },
      fontSize: {
        '10': ['10px', { lineHeight: '1.4' }],
        '11': ['11px', { lineHeight: '1.5' }],
        '12': ['12px', { lineHeight: '1.5' }],
        '13': ['13px', { lineHeight: '1.7' }],
        '14': ['14px', { lineHeight: '1.6' }],
        '16': ['16px', { lineHeight: '1.5' }],
        '18': ['18px', { lineHeight: '1.4' }],
        '22': ['22px', { lineHeight: '1.3' }],
      },
      borderWidth: {
        DEFAULT: '0.5px',
        '0': '0',
        '1': '1px',
        '2': '2px',
      },
      borderColor: {
        DEFAULT: 'var(--border-default)',
        medium:  'var(--border-medium)',
        strong:  'var(--border-strong)',
      },
      borderRadius: {
        sm:   '4px',
        md:   '8px',
        lg:   '12px',
        xl:   '16px',
        full: '9999px',
      },
    },
  },
  plugins: [],
}
