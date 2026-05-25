document.addEventListener("DOMContentLoaded", () => {
  document.body.classList.add("is-ready");

  document.querySelectorAll("form").forEach((form) => {
    form.addEventListener("submit", () => {
      if (!form.dataset.noLoader) document.body.classList.add("is-loading");
    });
  });

  const counters = document.querySelectorAll("[data-count]");
  counters.forEach((counter) => {
    const target = Number(counter.dataset.count || 0);
    const formatter = new Intl.NumberFormat();
    const duration = 720;
    const start = performance.now();

    const tick = (now) => {
      const progress = Math.min((now - start) / duration, 1);
      const value = Math.round(target * progress);
      counter.textContent = formatter.format(value);
      if (progress < 1) requestAnimationFrame(tick);
    };

    requestAnimationFrame(tick);
  });

  const revealTargets = document.querySelectorAll(".vehicle-card, .admin-panel, .premium-tile, .testimonial-card");
  const observer = new IntersectionObserver((entries) => {
    entries.forEach((entry) => {
      if (entry.isIntersecting) {
        entry.target.classList.add("is-visible");
        observer.unobserve(entry.target);
      }
    });
  }, { threshold: 0.16 });

  revealTargets.forEach((target) => observer.observe(target));
});
