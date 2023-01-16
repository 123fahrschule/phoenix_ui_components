export default () => ({
  updateQueryParams(event) {
    const page = event.target.elements.page.value.replace(/\D/g, '');
    if (!page) {
      return;
    }

    const params = new URLSearchParams(window.location.search);
    params.set('page', page.value);

    window.location.search = params;
  }
});
