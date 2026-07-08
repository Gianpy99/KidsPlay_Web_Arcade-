"""
portal_register.py - Registra/aggiorna questa app nel Family Portal.

Aggiorna il registro live del portale (services.json) montato in /cfg.
Metadati letti da variabili d'ambiente (passate dalla pipeline Jenkins):
  APP_ID, APP_NAME, APP_DESC, APP_CAT, APP_ICON (o APP_ICON_CP), APP_COLOR, APP_PORT
Idempotente: sostituisce l'eventuale voce con lo stesso id.
"""
import json
import os

PATH = "/cfg/services.json"
PI_HOST = os.environ.get("PI_HOST", "192.168.1.129")

with open(PATH, encoding="utf-8") as f:
    data = json.load(f)

# L'icona puo' arrivare come emoji (APP_ICON) o come code point/i esadecimali
# separati da virgola (APP_ICON_CP), piu' robusto attraverso la pipeline.
icon = os.environ.get("APP_ICON", "")
icon_cp = os.environ.get("APP_ICON_CP", "").strip()
if icon_cp:
    icon = "".join(chr(int(c, 16)) for c in icon_cp.split(",") if c.strip())

entry = {
    "id": os.environ["APP_ID"],
    "name": os.environ["APP_NAME"],
    "description": os.environ.get("APP_DESC", ""),
    "url": "http://%s:%s/" % (PI_HOST, os.environ["APP_PORT"]),
    "location": "pi",
    "category": os.environ.get("APP_CAT", "Tools"),
    "port": int(os.environ["APP_PORT"]),
    "icon": icon,
    "color": os.environ.get("APP_COLOR", "#4f8cff"),
    "healthCheck": True,
    "status": "running",
}

services = [s for s in data.get("services", []) if s.get("id") != entry["id"]]
services.append(entry)
data["services"] = services

with open(PATH, "w", encoding="utf-8") as f:
    json.dump(data, f, ensure_ascii=False, indent=2)

print("registered '%s' on port %s" % (entry["id"], entry["port"]))
