export const Sidebar = {
  mounted() {
    this.setActiveLinks();
  },
  updated() {
    this.setActiveLinks();
  },

  setActiveLinks() {
    const { pathname } = window.location;

    const links = this.el.querySelectorAll('a');
    for (const link of links) {
      if (pathname.startsWith(link.getAttribute('href'))) {
        link.classList.add('active');
      } else {
        link.classList.remove('active');
      }
    }
  }
};
