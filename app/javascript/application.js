document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".flash-message").forEach((msg) => {
        setTimeout(() => {
        msg.style.transition = "opacity 0.5s";
        msg.style.opacity = "0";
        setTimeout(() => msg.remove(), 500);
        }, 5000);
    });
    }
);