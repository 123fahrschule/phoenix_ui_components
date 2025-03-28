const plugin = require('tailwindcss/plugin');

module.exports = plugin(function ({ addComponents, theme }) {
  addComponents({
    '.banner': {
      width: '100%',
      display: 'flex',
      alignItems: 'center',
      gap: '2px',
      borderRadius: '12px',
      color: theme('colors.neutral.900'),

      '& .close-button': {
        color: 'currentColor',
        padding: '8px',
        borderRadius: '9999px',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center'
      }
    },

    '.banner-icon-container': {
      display: 'flex',
      alignItems: 'center',
      justifyContent: 'center',
      borderRadius: '8px',
      boxShadow: theme('boxShadow.small-200'),
      backgroundColor: 'currentColor'
    },

    '.banner-icon': {
      color: theme('colors.neutral.100')
    },

    '.banner-label': {
      color: 'currentColor',
      fontWeight: 'bold'
    },

    '.banner-info': {
      backgroundColor: theme('colors.info.100')
    },
    '.banner-info .banner-label': {
      color: theme('colors.info.400')
    },
    '.banner-info .banner-icon-container': {
      backgroundColor: theme('colors.info.400')
    },
    '.banner-info .close-button': {
      color: theme('colors.info.400')
    },
    '.banner-success': {
      backgroundColor: theme('colors.success.100')
    },
    '.banner-success .banner-label': {
      color: theme('colors.success.300')
    },
    '.banner-success .banner-icon-container': {
      backgroundColor: theme('colors.success.300')
    },
    '.banner-success .close-button': {
      color: theme('colors.success.300')
    },

    '.banner-warning': {
      backgroundColor: theme('colors.warning.100')
    },
    '.banner-warning .banner-icon-container': {
      backgroundColor: theme('colors.warning.300')
    },
    '.banner-warning .banner-label': {
      color: theme('colors.warning.300')
    },
    '.banner-warning .close-button': {
      color: theme('colors.warning.300')
    },

    '.banner-error': {
      backgroundColor: theme('colors.error.100')
    },
    '.banner-error .banner-icon-container': {
      backgroundColor: theme('colors.error.300')
    },
    '.banner-error .banner-label': {
      color: theme('colors.error.300')
    },
    '.banner-error .close-button': {
      color: theme('colors.error.300')
    },

    '.banner-sm': {
      '@apply text-body-xs': {},

      padding: '8px',
      gap: '8px',

      '& .banner-icon-container': {
        width: '24px',
        height: '24px',
        padding: '4px'
      },

      '& .banner-icon': {
        fontSize: '16px'
      }
    },
    '.banner-md': {
      '@apply text-body-sm': {},

      padding: '8px',
      gap: '8px',

      '& .banner-icon-container': {
        width: '32px',
        height: '32px',
        padding: '4px'
      },

      '& .banner-icon': {
        fontSize: '24px'
      }
    },
    '.banner-lg': {
      '@apply text-body-sm': {},

      padding: '12px',
      gap: '12px',

      '& .banner-icon-container': {
        width: '40px',
        height: '40px',
        padding: '8px'
      },

      '& .banner-icon': {
        fontSize: '24px'
      }
    }
  });
});
