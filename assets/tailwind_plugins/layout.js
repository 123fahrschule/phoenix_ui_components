const plugin = require('tailwindcss/plugin');

module.exports = plugin(function ({ addComponents }) {
  addComponents({
    '.page': {
      height: '100%',
      display: 'grid',
      gridTemplateRows: 'auto 1fr auto',
      gridTemplateAreas: '"header" "content" "footer"'
    },

    '.page-header': {
      '@apply bg-neutral-200 border-b border-neutral-300 px-14 pt-5': {},

      gridArea: 'header'
    },

    '.page-content': {
      '@apply px-14 pt-8 pb-6': {},

      overflow: 'auto',
      gridArea: 'content'
    },

    '.page-footer': {
      '@apply bg-neutral-100 flex items-center border-t border-neutral-300 px-14 py-4': {},

      height: '72px',
      gridArea: 'footer'
    }
  });
});
