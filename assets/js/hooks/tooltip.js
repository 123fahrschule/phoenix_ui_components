import { arrow, autoUpdate, computePosition, flip, hide, offset, shift } from '@floating-ui/dom';

export const Tooltip = {
  tooltip: null,
  reference: null,
  arrowElement: null,

  timer: null,
  controller: null,
  autoUpdateCleanup: null,

  showTooltip() {
    if (this.timer) return;
    const delay = parseInt(this.el.dataset.delay) || 0;

    this.timer = setTimeout(() => {
      this.tooltip.style.display = 'block';
      this.setPosition();
    }, delay);
  },
  hideTooltip() {
    clearTimeout(this.timer);
    this.timer = null;
    this.tooltip.style.display = 'none';
    this.autoUpdateCleanup?.();
  },
  setPosition() {
    this.autoUpdateCleanup = autoUpdate(this.reference, this.tooltip, () => {
      computePosition(this.reference, this.tooltip, {
        placement: this.el.dataset.placement,
        strategy: this.el.dataset.strategy,
        middleware: [
          offset(6),
          flip(),
          shift({ padding: 10 }),
          arrow({ element: this.arrowElement }),
          hide()
        ]
      }).then(({ x, y, placement, middlewareData }) => {
        Object.assign(this.tooltip.style, {
          left: `${x}px`,
          top: `${y}px`,
          visibility: middlewareData.hide.referenceHidden ? 'hidden' : 'visible'
        });

        const { x: arrowX, y: arrowY } = middlewareData.arrow;

        const staticSide = {
          top: 'bottom',
          right: 'left',
          bottom: 'top',
          left: 'right'
        }[placement.split('-')[0]];

        Object.assign(this.arrowElement.style, {
          left: arrowX != null ? `${arrowX}px` : '',
          top: arrowY != null ? `${arrowY}px` : '',
          right: '',
          bottom: '',
          [staticSide]: '-4px'
        });
      });
    });
  },
  setup() {
    this.tooltip = this.el;
    this.reference = this.tooltip.dataset.reference
      ? document.querySelector(this.tooltip.dataset.reference)
      : this.el.previousElementSibling;
    this.arrowElement = this.el.querySelector('[data-tooltip-arrow]');

    this.showTooltip = this.showTooltip.bind(this);
    this.hideTooltip = this.hideTooltip.bind(this);
    this.setPosition = this.setPosition.bind(this);

    this.controller = new AbortController();

    this.el.addEventListener('tooltip:show', this.showTooltip, { signal: this.controller.signal });
    this.el.addEventListener('tooltip:hide', this.hideTooltip, { signal: this.controller.signal });

    if (!('disableHover' in this.el.dataset)) {
      [
        ['mouseenter', this.showTooltip],
        ['mouseleave', this.hideTooltip]
      ].forEach(([event, listener]) => {
        this.reference.addEventListener(event, listener, { signal: this.controller.signal });
      });
    }
  },
  cleanup() {
    clearTimeout(this.timer);
    this.timer = null;
    this.controller?.abort();
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
