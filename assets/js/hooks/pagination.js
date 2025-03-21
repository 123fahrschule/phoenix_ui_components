export const Pagination = {
  submitting: false,

  mounted() {
    this.el.querySelector('input').addEventListener('input', (event) => {
      const maxValue = parseInt(event.target.dataset.maxValue);
      const nextValue = event.target.value.replace(/\D/, '');

      event.target.value = nextValue;

      const page = parseInt(nextValue);

      if (!Number.isFinite(page)) return;

      event.target.value = Math.min(page, maxValue);
    });

    this.el.querySelectorAll('input,select').forEach((element) => {
      element.addEventListener('change', (event) => {
        event.target.form.requestSubmit();
      });
    });

    this.el.addEventListener('update-pagination-page', (event) => {
      const { page, page_size } = event.detail;

      this.updatePaginationParams(page, page_size);
    });

    this.el.querySelector('form').addEventListener('submit', (event) => {
      event.preventDefault();
      if (this.submitting) {
        return;
      }

      this.submitting = true;

      const formData = new FormData(event.currentTarget);

      this.updatePaginationParams(
        parseInt(formData.get('page')),
        parseInt(formData.get('page-size'))
      );

      setTimeout(() => {
        this.submitting = false;
      }, 100);
    });
  },

  updatePaginationParams(page, pageSize) {
    const { changeEvent, target } = this.el.dataset;

    const payload = { ...(page && { page }), page_size: pageSize };

    if (changeEvent) {
      if (target) {
        this.pushEventTo(target, changeEvent, payload);
      } else {
        this.pushEvent(changeEvent, payload);
      }
      return;
    }

    const url = new URL(window.location.href);

    if (Number.isFinite(page)) {
      url.searchParams.set('page', page);
    }

    if (Number.isFinite(pageSize)) {
      url.searchParams.set('page_size', pageSize);
    }

    const encodedJS = '[["patch",{"replace":false,"href":"' + url + '"}]]';
    this.liveSocket.execJS(document.body, encodedJS);
  }
};
