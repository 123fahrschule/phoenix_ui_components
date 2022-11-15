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

// js/phoenix-ui-components/multiselect.js
var multiselect_default = () => ({
  allOptions: {},
  groupedOptions: [],
  selectedValues: [],
  filterString: "",
  get normalizedFilterString() {
    return this.filterString.toLowerCase();
  },
  get filteredOptionsGroups() {
    if (!this.normalizedFilterString) {
      return this.groupedOptions;
    }
    return this.groupedOptions.map((group) => group.filter(({ normalizedLabel }) => normalizedLabel.includes(this.normalizedFilterString))).filter((group) => group.length);
  },
  get tags() {
    return this.selectedValues.map((value) => this.allOptions[value]);
  },
  toggleOption(value) {
    const index = this.selectedValues.indexOf(value);
    if (index >= 0) {
      this.selectedValues.splice(index, 1);
    } else {
      this.selectedValues.push(value);
    }
  },
  deselectOption(value) {
    this.selectedValues.splice(this.selectedValues.indexOf(value), 1);
  },
  init() {
    const options = Array.from(this.$root.querySelectorAll("option"));
    const groups = Array.from(this.$root.querySelectorAll("optgroup"));
    this.allOptions = options.reduce((acc, { value, innerText: label }) => {
      acc[value] = { value, label, normalizedLabel: label.toLowerCase() };
      return acc;
    }, {});
    this.selectedValues = options.filter(({ selected }) => selected).map(({ value }) => value);
    let groupedOptions = [];
    if (groups.length) {
      groupedOptions = Array.from(groups).map((group) => Array.from(group.querySelectorAll("option")));
    } else {
      groupedOptions = [options];
    }
    this.groupedOptions = groupedOptions.map((optionsGroup) => optionsGroup.map(({ value }) => this.allOptions[value]));
  }
});
export {
  dropdown_default as dropdown,
  multiselect_default as multiselect
};
//# sourceMappingURL=module.mjs.map
