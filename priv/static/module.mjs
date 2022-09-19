// js/phoenix-ui-components/dropdown.js
var dropdown_default = (isOpen = false) => ({
  isOpen,
  open() {
    this.isOpen = true;
  },
  close() {
    this.isOpen = false;
  },
  toggle() {
    this.isOpen = !this.isOpen;
  },
  toggler: {
    "@click"() {
      this.toggle();
    }
  },
  arrowIcon: {
    ":class"() {
      return this.isOpen ? "rotate-180" : "";
    }
  },
  panel: {
    "x-show"() {
      return this.isOpen;
    },
    "x-transition:enter": "transition ease-out duration-100",
    "x-transition:enter-start": "transform opacity-0 scale-95",
    "x-transition:enter-end": "transform opacity-100 scale-100",
    "x-transition:leave": "transition ease-in duration-75",
    "x-transition:leave-start": "transform opacity-100 scale-100",
    "x-transition:leave-end": "transform opacity-0 scale-95"
  }
});
export {
  dropdown_default as dropdown
};
//# sourceMappingURL=module.mjs.map
