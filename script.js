// Sidebar buttons: About / Experience / Projects swap the page content; the rest open links in a new tab.
document.addEventListener('DOMContentLoaded', () => {
  const buttons = document.querySelectorAll('.header-links button');
  const views = document.querySelectorAll('.view');

  function show(id) {
    views.forEach(v => { v.hidden = v.id !== id; });
    buttons.forEach(b => b.classList.toggle('current', b.dataset.view === id));
    window.scrollTo(0, 0);
  }

  buttons.forEach(button => {
    button.addEventListener('click', () => {
      if (button.dataset.view) show(button.dataset.view);
      else window.open(button.dataset.link, '_blank');
    });
  });
});
