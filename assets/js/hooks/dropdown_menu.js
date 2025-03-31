import { autoUpdate, computePosition, flip, hide, offset, shift } from '@floating-ui/dom';

export const DropdownMenu = {
  menu: null,
  reference: null,

  autoUpdateCleanup: null,

  setPosition() {
    this.autoUpdateCleanup = autoUpdate(this.reference, this.menu, () => {
      computePosition(this.reference, this.menu, {
        placement: this.el.dataset.placement,
        strategy: this.el.dataset.strategy,
        middleware: [offset(6), flip(), shift({ padding: 10 }), hide()]
      }).then(({ x, y, middlewareData }) => {
        Object.assign(this.menu.style, {
          left: `${x}px`,
          top: `${y}px`,
          visibility: middlewareData.hide.referenceHidden ? 'hidden' : 'visible',

          ...('fitReferenceWidth' in this.el.dataset && {
            width: `${this.reference.clientWidth}px`
          })
        });
      });
    });
  },
  setup() {
    this.menu = this.el;
    this.reference = this.menu.dataset.reference
      ? document.querySelector(this.menu.dataset.reference)
      : this.el.previousElementSibling;

    this.setPosition();
  },
  cleanup() {
    this.autoUpdateCleanup?.();
  },

  mounted() {
    this.setup();
  },
  updated() {
    this.cleanup();

    this.setup();
  },
  destroyed() {
    this.cleanup();
  }
};
