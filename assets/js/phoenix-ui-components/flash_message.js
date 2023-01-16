const DEFAULT_FLASH_HIDE_DELAY = 5000;

export default (type) => ({
  show: true,
  close() {
    this.show = false;
  },
  init() {
    if (type === 'error') {
      return;
    }
    setTimeout(() => {
      this.close();
    }, DEFAULT_FLASH_HIDE_DELAY);
  }
});
