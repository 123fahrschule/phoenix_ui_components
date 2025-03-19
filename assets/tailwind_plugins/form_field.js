const plugin = require('tailwindcss/plugin');

module.exports = plugin(function ({ addComponents, theme }) {
  addComponents({
    '.form-field': {
      width: '100%',
      display: 'flex',
      flexDirection: 'column'
    },

    '.select': {
      backgroundImage:
        "url(\"data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%230F61AD' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e\")",
      backgroundPosition: 'right 0.5rem center',
      backgroundRepeat: 'no-repeat',
      backgroundSize: '1.5em 1.5em'
    },
    '.select:disabled': {
      backgroundImage:
        "url(\"data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%23CAD2DA' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e\")"
    },
    '.select.form-field-input-error': {
      backgroundImage:
        "url(\"data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 20 20'%3e%3cpath stroke='%23C71938' stroke-linecap='round' stroke-linejoin='round' stroke-width='1.5' d='M6 8l4 4 4-4'/%3e%3c/svg%3e\")"
    }
  });

  addComponents({
    '.form-field-label': {
      display: 'block',
      color: theme('colors.neutral.900'),
      fontWeight: 600,
      order: -1,
      marginBottom: '4px',

      '&.disabled': {
        color: theme('colors.neutral.400')
      }
    },

    '.form-field-label-sm': {
      '@apply text-body-xs': {}
    },

    '.form-field-label-md': {
      '@apply text-body-sm': {}
    },

    '.form-field-label-lg': {
      '@apply text-body': {}
    }
  });

  addComponents({
    '.form-field-input': {
      width: '100%',
      borderRadius: '9999px',
      border: `1px solid ${theme('colors.neutral.300')}`,
      boxShadow: theme('boxShadow.input'),
      backgroundColor: 'rgba(245, 247, 250, 0.5)',
      color: theme('colors.neutral.900'),
      fontWeight: 'normal',

      '&::placeholder': {
        color: theme('colors.neutral.600')
      },

      '&:focus': {
        borderColor: theme('colors.primary.300'),
        boxShadow: theme('boxShadow.input-focus')
      },

      '.form-field &.form-field-input-error': {
        backgroundColor: 'rgba(254, 227, 212, 0.32)',
        borderColor: theme('colors.error.300'),
        boxShadow: theme('boxShadow.input-error')
      },

      '.form-field &.form-field-input-error form-field-icon': {
        color: theme('colors.error.300')
      },

      'textarea&': {
        border: `1px solid ${theme('colors.neutral.300')}`,
        borderRadius: '12px'
      },

      '&:disabled': {
        color: theme('colors.neutral.400'),
        backgroundColor: 'rgba(224, 229, 235, 0.5)',
        border: `1px solid ${theme('colors.neutral.300')}`,
        boxShadow: theme('boxShadow.input'),
        cursor: 'not-allowed'
      }
    },

    '.form-field-input-sm': {
      '@apply text-body-xs': {},
      padding: '8px 12px'
    },
    '.form-field-input-md': {
      '@apply text-body-sm': {},
      padding: '8px 12px'
    },
    '.form-field-input-lg': {
      '@apply text-body': {},
      padding: '8px 12px'
    }
  });

  addComponents({
    '.form-field-error': {
      '@apply text-helper': {},
      color: theme('colors.error.300'),
      marginTop: '4px',
      order: 1
    }
  });
});
