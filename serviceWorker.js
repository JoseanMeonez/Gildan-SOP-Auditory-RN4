const app = "gildan-rn4-sop";
const assets = [
  "./index.php",
	"./views/login/login.php",
  "./assets/css/style.css",
	"./assets/css/main.css",
	"./assets/css/.css",
  "./assets/js/main.js",
	"./assets/js/login.js"
];

self.addEventListener("install", installEvent => {
  installEvent.waitUntil(
    caches.open(app).then(cache => {
      cache.addAll(assets);
    })
  );
});

self.addEventListener("fetch", fetchEvent => {
  fetchEvent.respondWith(
    caches.match(fetchEvent.request).then(res => {
      return res || fetch(fetchEvent.request);
    })
  );
});
