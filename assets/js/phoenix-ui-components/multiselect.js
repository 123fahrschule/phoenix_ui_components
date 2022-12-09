import dropdown from './dropdown';
import { isElementInViewport } from '../helpers/isElementInViewport';

export default ({ scrollOptionsIntoView = true }) => ({
  ...dropdown(),
  allOptions: {},
  groupedOptions: [],
  selectedValues: [],
  filterString: '',

  get normalizedFilterString() {
    return this.filterString.toLowerCase();
  },
  get filteredOptionsGroups() {
    if (!this.normalizedFilterString) {
      return this.groupedOptions;
    }

    return this.groupedOptions
      .map((group) => ({
        ...group,
        options: group.options.filter(({ normalizedLabel }) =>
          normalizedLabel.includes(this.normalizedFilterString)
        )
      }))
      .filter((group) => group.options.length);
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
    const options = Array.from(this.$root.querySelectorAll('option'));
    const groups = Array.from(this.$root.querySelectorAll('optgroup'));

    this.allOptions = options.reduce((acc, { value, innerText: label }) => {
      acc[value] = { value, label, normalizedLabel: label.toLowerCase() };
      return acc;
    }, {});

    this.selectedValues = options.filter(({ selected }) => selected).map(({ value }) => value);

    let groupedOptions = [];

    if (groups.length) {
      groupedOptions = Array.from(groups).map((group) => {
        const options = Array.from(group.querySelectorAll('option'));

        return {
          options,
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
      this.$watch('isOpen', (isOpen) => {
        if (isOpen) {
          this.scrollToOptions();
        }
      });
    }
  }
});
