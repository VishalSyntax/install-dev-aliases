document.addEventListener("DOMContentLoaded", function () {
  document.querySelectorAll("a.md-button").forEach(function (link) {
    link.addEventListener("click", function (e) {
      const url = link.href;
      const filename = url.split("/").pop();
      e.preventDefault();
      fetch(url)
        .then((res) => res.blob())
        .then((blob) => {
          const a = document.createElement("a");
          a.href = URL.createObjectURL(blob);
          a.download = filename;
          a.click();
          URL.revokeObjectURL(a.href);
        });
    });
  });
});
