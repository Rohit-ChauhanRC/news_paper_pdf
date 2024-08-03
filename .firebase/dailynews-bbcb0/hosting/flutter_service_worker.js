'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "bba5e109564d5697d0334000154398f6",
"version.json": "6780d9e62e5c4ba20355a0d8f4c7a8d6",
"index.html": "63d7fe507e2fd4779a9877f860c0ec5f",
"/": "63d7fe507e2fd4779a9877f860c0ec5f",
"main.dart.js": "1e0ffe1d39db9c8fac98a9841907c9c4",
"flutter.js": "383e55f7f3cce5be08fcf1f3881f585c",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "d33d313e2de592e24871c7903f33347b",
"assets/AssetManifest.json": "7a7be55a1394cd778ff1b2291bc066d7",
"assets/NOTICES": "0e3cfa209e3a87201e9e56c865eb142a",
"assets/FontManifest.json": "7b2a36307916a9721811788013e65289",
"assets/AssetManifest.bin.json": "17bea8deffe251a76c6f793e235a655c",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "6f418556a1f1647c16e65d2df1f67be8",
"assets/fonts/MaterialIcons-Regular.otf": "69439e09ff5d06aea578d5569858394c",
"assets/assets/images/loksatta.png": "fb1da63f616cfa62e2c2ff1403e8a1a1",
"assets/assets/images/the_tribune.jpeg": "74eadd02e0a6e936a9157778ec5b9fb0",
"assets/assets/images/pioneer.jpeg": "4141c4a51c6827b44686f144b233254b",
"assets/assets/images/financial_express.jpeg": "ed3ce64b902fc3fcd452bfc8ffdf4b40",
"assets/assets/images/hari.png": "5714ac0b2b463d89fc84caf90f90ae3c",
"assets/assets/images/navbharat.png": "6dba92a992b79dd339f08d040051b3c3",
"assets/assets/images/daily.png": "f0ef69495e88bb3281033b77a0b22fc2",
"assets/assets/images/fress_press.png": "d70d1fc10dac06c984bd4373b8023208",
"assets/assets/images/deccan_chronical.jpeg": "938ca2fb99f03e3f84050cfea01ff54b",
"assets/assets/images/rastriya.jpeg": "ff0c5396608ab03e190c1d6d578e536a",
"assets/assets/images/times_of_india.png": "9d9eb9ff655442b9e41ee09637805d93",
"assets/assets/images/the_stateman.png": "5c212cb29d25e0c088c8c07abaaeaa76",
"assets/assets/images/danik_navjyoti.png": "c11d2bc44b392ed32c8cd6df1c82c0f1",
"assets/assets/images/amar.jpeg": "27745dc8af1bb083ecb32a09184f3ee8",
"assets/assets/images/rajasthan.png": "59f3860f5a180d7aeade1e8e9b315db9",
"assets/assets/images/logo.jpg": "ef411ae670d582944c919233a37a8728",
"assets/assets/images/danik_jagran.png": "e88deddaafdc9e8298cab519362e347c",
"assets/assets/images/et.png": "13081fb26afdcae878b78293e0587525",
"assets/assets/images/the_hindu.png": "cdaac114738953a9aad00fb7eaf7466c",
"assets/assets/images/the_telegraph.png": "dfda1af63e8d2d9661f4501345848328",
"assets/assets/images/danik_bhaskar.jpeg": "919379f70b8687a22dd5fc0fe4dfab78",
"assets/assets/images/the_asian_age.jpeg": "4f85c5cf2d9febf1cc1607bd03cc521e",
"assets/assets/images/punjab.png": "8a1467229b27d7b0f070bda090a6bf67",
"assets/assets/images/jansatta.png": "26a8e9081ab6f34da82bd54c570cb992",
"assets/assets/images/parbhat.png": "2bcf387d5fd8ad26be369412a02b6d83",
"canvaskit/skwasm.js": "5d4f9263ec93efeb022bb14a3881d240",
"canvaskit/skwasm.js.symbols": "c3c05bd50bdf59da8626bbe446ce65a3",
"canvaskit/canvaskit.js.symbols": "74a84c23f5ada42fe063514c587968c6",
"canvaskit/skwasm.wasm": "4051bfc27ba29bf420d17aa0c3a98bce",
"canvaskit/chromium/canvaskit.js.symbols": "ee7e331f7f5bbf5ec937737542112372",
"canvaskit/chromium/canvaskit.js": "901bb9e28fac643b7da75ecfd3339f3f",
"canvaskit/chromium/canvaskit.wasm": "399e2344480862e2dfa26f12fa5891d7",
"canvaskit/canvaskit.js": "738255d00768497e86aa4ca510cce1e1",
"canvaskit/canvaskit.wasm": "9251bb81ae8464c4df3b072f84aa969b",
"canvaskit/skwasm.worker.js": "bfb704a6c714a75da9ef320991e88b03"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
