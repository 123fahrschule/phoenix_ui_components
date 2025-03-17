const plugin = require('tailwindcss/plugin');

module.exports = plugin(function ({ addComponents, theme }) {
  addComponents({
    '.badge': {
      display: 'inline-flex',
      alignItems: 'center',
      justifyContent: 'center',
      gap: '2px',
      borderRadius: '9999px',
      fontWeight: '600',
      boxShadow: theme('boxShadow.small-200'),
      verticalAlign: 'middle',
      userSelect: 'none',
      maxWidth: '100%',
      minWidth: '0px'
    },

    '.badge-label': {
      '@apply truncate': {}
    },

    '.badge-remove-button': {
      '@apply inline-flex rounded-full outline-current': {}
    },

    '.badge-neutral': {
      color: theme('colors.neutral.700'),
      backgroundColor: theme('colors.neutral.300'),

      '& .badge-remove-button:hover, .badge-remove-button:focus': {
        backgroundColor: theme('colors.neutral.400')
      }
    },
    '.badge-info': {
      color: theme('colors.info.400'),
      backgroundColor: theme('colors.info.100'),

      '& .badge-remove-button:hover, .badge-remove-button:focus': {
        backgroundColor: theme('colors.info.200')
      }
    },
    '.badge-success': {
      color: theme('colors.success.400'),
      backgroundColor: theme('colors.success.100'),

      '& .badge-remove-button:hover, .badge-remove-button:focus': {
        backgroundColor: theme('colors.success.200')
      }
    },
    '.badge-warning': {
      color: theme('colors.warning.500'),
      backgroundColor: theme('colors.warning.100'),

      '& .badge-remove-button:hover, .badge-remove-button:focus': {
        backgroundColor: theme('colors.warning.200')
      }
    },
    '.badge-error': {
      color: theme('colors.error.400'),
      backgroundColor: theme('colors.error.100'),

      '& .badge-remove-button:hover, .badge-remove-button:focus': {
        backgroundColor: theme('colors.error.200')
      }
    },

    '.badge-xs': {
      '@apply text-body-xs': {},

      padding: '2px 6px',

      '& .icon': { fontSize: '12px' },

      '&:has(.icon:first-child)': { paddingLeft: '4px' },
      '&:has(.icon:last-child)': { paddingRight: '4px' },

      '&:has(> .icon:only-child)': { padding: '2px' }
    },

    '.badge-sm': {
      '@apply text-body-xs': {},

      padding: '4px 8px',

      '& .icon': { fontSize: '16px' },

      '&:has(> .icon:first-child)': { paddingLeft: '6px' },
      '&:has(> .icon:last-child)': { paddingRight: '6px' },

      '&:has(> .icon:only-child)': { padding: '4px' }
    },
    '.badge-md': {
      '@apply text-body-sm': {},

      padding: '6px 10px',

      '& .icon': { fontSize: '20px' },

      '&:has(> .icon:first-child)': { paddingLeft: '6px' },
      '&:has(* ~ .icon)': { paddingRight: '6px' },

      '&:has(> .icon:only-child)': { padding: '6px' }
    },
    '.badge-lg': {
      '@apply text-body': {},

      padding: '8px 12px',

      '& .icon': { fontSize: '24px' },

      '&:has(.icon:first-child)': { paddingLeft: '8px' },
      '&:has(.icon:last-child)': { paddingRight: '8px' },

      '&:has(> .icon:only-child)': { padding: '8px' }
    }
  });
});
