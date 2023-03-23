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

Das Skript gibt den Speicherort der Zertifikate und den Identifier aus, diese können dann in der Netzwerkkonfiguration verwendet werden.

## Netzwerk-Konfiguration
### NetworkManager
NetworkManager wird z.B. bei Ubuntu oder Manjaro+Gnome verwendet. Dazu einfach edurom in der Liste verfügbarer WLAN-Netwerke auswählen. Ein Fenster wie dieses sollte sich öffnen:

![networkmanager](https://user-images.githubusercontent.com/10237613/227229459-e4beb382-8ea5-4a7a-983c-491b53008e3c.jpg)

| Feld | Inhalt |
| --- | --- |
| Security | WPA & WPA2 Enterprise |
| Authentication | TLS |
| Identity | Skript-Output für Identity |
| User certificate | Skript-Output für easyroam_client_cert.pem |
| CA certificate | Skript-Output für easyroam_root_ca.pem |
| Private key | Skript-Output für easyroam_client_key.pem |
| Private key password | Wie im Skript ausgewählt |

## Wofür brauche ich das?
Eduroam ist ein WLAN-Netzwerk, das in vielen europäischen Unis benutzt wird. Die Anmeldung ist deutlich komplizierter als das Angeben von Netzwerkname und Passwort, wie man es von zu Hause kennt. 

Für Windows, Android etc. gibt es Programme, die diesen Ablauf automatisieren, besonders für Unis, die Easyroam benutzen. Für Linux muss man aber leider viel manuell machen. Den technisch aufwändigsten Teil habe ich in diesem Skript automatisiert.
