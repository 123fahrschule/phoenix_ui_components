const plugin = require('tailwindcss/plugin');

module.exports = plugin(function ({ addVariant }) {
  addVariant('phx-click-loading', ['.phx-click-loading&', '.phx-click-loading &']);

  addVariant('phx-submit-loading', ['.phx-submit-loading&', '.phx-submit-loading &']);

  addVariant('phx-change-loading', ['.phx-change-loading&', '.phx-change-loading &']);
});
