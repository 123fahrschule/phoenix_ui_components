const DEFAULT_FLASH_HIDE_DELAY = 5000;

export const FlashMessage = {
  timer: null,

  remove() {
    this.el.remove();
    clearTimeout(this.timer);
  },

  mounted() {
    const type = this.el.dataset.type;

    this.el.querySelector("[data-type='close-btn']")?.addEventListener('click', () => {
      this.remove();
    });

    if (type !== 'error') {
      this.timer = setTimeout(() => {
        this.remove();
      }, DEFAULT_FLASH_HIDE_DELAY);
    }
  }
};
