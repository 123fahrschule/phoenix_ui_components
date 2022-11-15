export default () => ({
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
      .map((group) =>
        group.filter(({ normalizedLabel }) => normalizedLabel.includes(this.normalizedFilterString))
      )
      .filter((group) => group.length);
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
    const options = Array.from(this.$root.querySelectorAll('option'));
    const groups = Array.from(this.$root.querySelectorAll('optgroup'));

    this.allOptions = options.reduce((acc, { value, innerText: label }) => {
      acc[value] = { value, label, normalizedLabel: label.toLowerCase() };
      return acc;
    }, {});

    this.selectedValues = options.filter(({ selected }) => selected).map(({ value }) => value);

    let groupedOptions = [];

    if (groups.length) {
      groupedOptions = Array.from(groups).map((group) =>
        Array.from(group.querySelectorAll('option'))
      );
    } else {
      groupedOptions = [options];
    }

    this.groupedOptions = groupedOptions.map((optionsGroup) =>
      optionsGroup.map(({ value }) => this.allOptions[value])
    );
  }
});
