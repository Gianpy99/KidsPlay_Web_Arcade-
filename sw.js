const CACHE_NAME = 'kidsplay-v2.1-fixed'; // Aggiornato per forzare nuovo cache
const urlsToCache = [
    '/',
    '/index.html',
    '/common/core/game-engine.js',
    '/common/core/input-manager.js',
    '/common/core/audio-manager.js',
    '/common/styles/base.css',
    '/common/styles/mobile.css',
    '/games.json',
    '/manifest.json',
    '/games/educational/snake/index.html'
];

self.addEventListener('install', (event) => {
    console.log('SW: Installing...');
    event.waitUntil(
        caches.open(CACHE_NAME)
            .then((cache) => {
                console.log('SW: Cache opened');
                return cache.addAll(urlsToCache);
            })
            .catch((error) => {
                console.error('SW: Install failed:', error);
            })
    );
    self.skipWaiting(); // Forza l'attivazione immediata
});

self.addEventListener('activate', (event) => {
    console.log('SW: Activating...');
    event.waitUntil(
        caches.keys().then((cacheNames) => {
            return Promise.all(
                cacheNames.map((cacheName) => {
                    if (cacheName !== CACHE_NAME) {
                        console.log('SW: Deleting old cache:', cacheName);
                        return caches.delete(cacheName);
                    }
                })
            );
        }).then(() => {
            console.log('SW: Activated');
            return self.clients.claim(); // Prende controllo immediato
        })
    );
});

self.addEventListener('fetch', (event) => {
    // Ignora richieste non-HTTP per evitare errori
    if (!event.request.url.startsWith('http')) {
        return;
    }
    
    event.respondWith(
        caches.match(event.request)
            .then((response) => {
                if (response) {
                    return response;
                }
                return fetch(event.request).catch((error) => {
                    console.log('SW: Fetch failed:', error);
                    return new Response('Offline', { status: 503 });
                });
            })
            .catch((error) => {
                console.error('SW: Cache match failed:', error);
                return fetch(event.request);
            })
    );
});
