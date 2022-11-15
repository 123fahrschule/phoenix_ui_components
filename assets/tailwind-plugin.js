module.exports = ({ addBase, addVariant, theme }) => {
  addBase({
    h1: {
      fontSize: theme('fontSize.5xl'),
      lineHeight: theme('lineHeight.tight'),
      fontWeight: 'bold',
      letterSpacing: '0.24px'
    },
    h2: {
      fontSize: '2rem',
      lineHeight: theme('lineHeight.normal'),
      fontWeight: 'bold',
      letterSpacing: '0.16px'
    },
    h3: {
      fontSize: theme('fontSize.2xl'),
      lineHeight: 1.333333,
      fontWeight: 'bold'
    },
    h4: {
      fontSize: theme('fontSize.xl'),
      lineHeight: 1.4,
      fontWeight: 'bold'
    },
    h5: {
      fontSize: theme('fontSize.normal'),
      lineHeight: theme('lineHeight.tight'),
      fontWeight: 'bold'
    },
    h6: {
      fontSize: theme('fontSize.sm'),
      lineHeight: 1.333333,
      fontWeight: 'bold',
      letterSpacing: '0.48px',
      textTransform: 'uppercase'
    }
  });
  addVariant('group-selected', ':merge(.group).selected &');
};
