const plugin = require('tailwindcss/plugin');

const textStyles = {
  h1: {
    fontSize: '3rem',
    lineHeight: '3.75rem',
    fontWeight: 700,
    letterSpacing: '0.24px'
  },
  h2: {
    fontSize: '2rem',
    lineHeight: '3rem',
    fontWeight: 700,
    letterSpacing: '0.16px'
  },
  h3: {
    fontSize: '1.5rem',
    lineHeight: '2rem',
    fontWeight: 700
  },
  h4: {
    fontSize: '1.25rem',
    lineHeight: '1.75rem',
    fontWeight: 700
  },
  h5: {
    fontSize: '1rem',
    lineHeight: '1.25rem',
    fontWeight: 700
  },
  h6: {
    fontSize: '0.75rem',
    lineHeight: '1rem',
    fontWeight: 700,
    letterSpacing: '0.48px',
    textTransform: 'uppercase'
  },
  body: {
    fontSize: '1rem',
    lineHeight: '1.5rem'
  },
  'body-sm': {
    fontSize: '0.875rem',
    lineHeight: '1.25rem'
  },
  'body-xs': {
    fontSize: '0.75rem',
    lineHeight: '1rem'
  },
  'button-lg': {
    fontSize: '1rem',
    lineHeight: '1.5rem',
    fontWeight: 700
  },
  button: {
    fontSize: '0.875rem',
    lineHeight: '1.25rem',
    fontWeight: 700
  },
  'button-sm': {
    fontSize: '0.75rem',
    lineHeight: '1rem',
    fontWeight: 700
  },
  helper: {
    fontSize: '11px',
    lineHeight: '12px'
  }
};

module.exports = plugin(function ({ addBase }) {
  addBase(
    Object.fromEntries(
      Object.entries(textStyles).map(([name, styles]) => [`.text-${name}`, styles])
    )
  );
});

module.exports.textStyles = textStyles;
