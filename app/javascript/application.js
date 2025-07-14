import Rails from "@rails/ujs"
Rails.start()

import { Turbo } from "@hotwired/turbo-rails"
window.Turbo = Turbo

document.addEventListener("turbo:load", () => {
    document.querySelectorAll(".flash-message").forEach((msg) => {
        setTimeout(() => {
        msg.style.transition = "opacity 0.5s";
        msg.style.opacity = "0";
        setTimeout(() => msg.remove(), 500);
        }, 3500);
    });
});

