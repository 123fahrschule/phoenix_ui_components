export const FlashMessage = {
  timer: null,

  remove() {
    this.el.remove();
    clearTimeout(this.timer);
    this.liveSocket.execJS(this.el, this.el.getAttribute('phx-remove'));
  },

  mounted() {
    const type = this.el.dataset.type;

    this.el.querySelector("[data-type='close-btn']")?.addEventListener('click', () => {
      this.remove();
    });

    if (type !== 'error') {
      this.timer = setTimeout(() => {
        this.remove();
      }, 5_000);
    }
  }
};
