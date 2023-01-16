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

// js/helpers/isElementInViewport.js
function isElementInViewport(element) {
  const rect = element.getBoundingClientRect();
  return rect.top >= 0 && rect.left >= 0 && rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) && rect.right <= (window.innerWidth || document.documentElement.clientWidth);
}

// js/phoenix-ui-components/multiselect.js
var multiselect_default = ({ scrollOptionsIntoView = true }) => ({
  ...dropdown_default(),
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
    return this.groupedOptions.map((group) => ({
      ...group,
      options: group.options.filter(({ normalizedLabel }) => normalizedLabel.includes(this.normalizedFilterString))
    })).filter((group) => group.options.length);
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
  toggleGroup(group) {
    const selectedValues = new Set(this.selectedValues);
    const values = group.options.map(({ value }) => value);
    const allSelected = values.length && values.every((value) => selectedValues.has(value));
    if (allSelected) {
      values.forEach((value) => {
        selectedValues.delete(value);
      });
    } else {
      values.forEach((value) => {
        selectedValues.add(value);
      });
    }
    this.selectedValues = [...selectedValues];
  },
  scrollToOptions() {
    this.$nextTick(() => {
      const optionsElement = this.$root.querySelector('[x-bind="panel"]');
      if (!isElementInViewport(optionsElement)) {
        optionsElement.scrollIntoView();
      }
    });
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
      groupedOptions = Array.from(groups).map((group) => {
        const options2 = Array.from(group.querySelectorAll("option"));
        return {
          options: options2,
          label: group.label
        };
      });
    } else {
      groupedOptions = [{ options }];
    }
    this.groupedOptions = groupedOptions.map((optionsGroup) => ({
      ...optionsGroup,
      options: optionsGroup.options.map(({ value }) => this.allOptions[value])
    }));
    if (scrollOptionsIntoView) {
      this.$watch("isOpen", (isOpen) => {
        if (isOpen) {
          this.scrollToOptions();
        }
      });
    }
  }
});

// js/phoenix-ui-components/pagination.js
var pagination_default = () => ({
  updateQueryParams(event) {
    const page = event.target.elements.page.value.replace(/\D/g, "");
    if (!page) {
      return;
    }
    const params = new URLSearchParams(window.location.search);
    params.set("page", page.value);
    window.location.search = params;
  }
});

// js/phoenix-ui-components/flash_message.js
var DEFAULT_FLASH_HIDE_DELAY = 5e3;
var flash_message_default = (type) => ({
  show: true,
  close() {
    this.show = false;
  },
  init() {
    if (type === "error") {
      return;
    }
    setTimeout(() => {
      this.close();
    }, DEFAULT_FLASH_HIDE_DELAY);
  }
});
export {
  dropdown_default as dropdown,
  flash_message_default as flashMessage,
  multiselect_default as multiselect,
  pagination_default as pagination
};
//# sourceMappingURL=module.mjs.map
