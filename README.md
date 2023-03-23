# Easyroam Linux Helper
Hilfsskript zur Einrichtung von Eduroam auf Linux. 

Extrahiert Zertifikate und Identifier aus der PKCS12-Datein von Easyroam und installiert die Zertifikate im Anschluss. Danach kann die Netzwerkverbindung mit dem ensprechenden Netzwerk-Manager eingerichtet werden.

## Benutzung
Der [DNF-Anleitung](https://doku.tid.dfn.de/de:eduroam:easyroam#installation_der_easyroam_profile_auf_linux_geraeten) bis inklusive Schritt 4 folgen. Schritt 5 wird durch das Skript erledigt, dazu diesen Befehl ausführen:

```
chmod u+x easyroam_linux_helper.sh
sudo ./easyroam_linux_helper.sh <Pfad zur PKCS12-Datei>
```

Zusätzlich kann ein Zielordner für die Zertifikate angegeben werden, sonst wird `/etc/ssl/certs/` verwendet.

Das Skript gibt den Speicherort der Zertifikate und den Identifier aus, diese müssen im Netzwerk-Manager eingetragen werden.

## Netzwerk-Konfiguration
### NetworkManager
Diese Kombination wird z.B. bei Ubuntu oder Manjaro+Gnome verwendet. 
[Genaue beschreibung kommt noch]


## Wofür brauche ich das?
Eduroam ist das WLAN-Netzwerk, das in vielen europäischen Unis benutzt wird. Die Anmeldung ist deutlich komplizierter als das Angeben von Netzwerkname und Passwort, wie man es von zu Hause kennt. 

Für Windows, Android etc. gibt es Programme, die diesen Ablauf automatisieren, besonders für Unis, die Easyroam benutzen. Für Linux muss man aber leider viel manuell machen. Den technisch aufwändigsten Teil habe ich in diesem Skript automatisiert.