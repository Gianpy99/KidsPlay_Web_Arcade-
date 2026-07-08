// KILL SWITCH Service Worker
// Questo SW sostituisce le vecchie versioni con caching (es. kidsplay-v2.2).
// Non fa caching: elimina tutte le cache esistenti, si de-registra da solo
// e ricarica i client, cosi' i dispositivi con un vecchio SW attivo tornano
// a scaricare i file aggiornati direttamente dalla rete.

self.addEventListener('install', (event) => {
    self.skipWaiting(); // Attiva subito, senza attendere
});

self.addEventListener('activate', (event) => {
    event.waitUntil(
        (async () => {
            // Svuota tutte le cache lasciate dalle vecchie versioni
            const cacheNames = await caches.keys();
            await Promise.all(cacheNames.map((name) => caches.delete(name)));

            // De-registra questo Service Worker
            await self.registration.unregister();

            // Prende il controllo e ricarica tutte le schede aperte
            const clients = await self.clients.matchAll({ type: 'window' });
            clients.forEach((client) => client.navigate(client.url));
        })()
    );
});

// Nessuna intercettazione delle richieste: tutto passa direttamente in rete.
