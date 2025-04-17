export const LocaleSelect = {
  mounted() {
    this.el.addEventListener('set-locale', (event) => {
      this.setLocale(event.detail.locale);
    });
  },

  setLocale(locale) {
    const EXPIRY_TIME_IN_DAYS = 365;

    const expiryDate = new Date();
    expiryDate.setTime(expiryDate.getTime() + EXPIRY_TIME_IN_DAYS * 24 * 60 * 60 * 1000);
    const expires = 'expires=' + expiryDate.toUTCString();
    document.cookie = `app_locale=${locale};${expires};path=/`;
    window.location.reload();
  }
};
