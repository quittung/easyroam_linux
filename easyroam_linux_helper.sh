#!/bin/sh

# Fehler abfangen 
set -e
usage_string="Aufruf: ./easyroam_linux_helper.sh <Pfad zur PKCS12-Datei> <Pfad zum Output-Ordner>"

# PKCS12-Datei ($1) überprüfen
if [ ! -f "$1" ]; then
    echo "Keine PKCS12-Datei angegeben!"
    echo "$usage_string"
    exit 1
fi

pkcs12_path="$1"
echo "PKCS12-Datei: $pkcs12_path"

# Output-Ordner ($2 oder /etc/ssl/easyroam) wählen
if [ -z "$2" ]; then
    output_path="/etc/ssl/easyroam"
else
    output_path="$2"
fi
#!/bin/sh

# Fehler abfangen 
set -e

# PKCS12-Datei ($1) überprüfen
if [ ! -f "$1" ]; then
    echo "Keine PKCS12-Datei angegeben!"
    echo "Aufruf: ./easyroam_linux_helper.sh <Pfad zur PKCS12-Datei> <Pfad zum Output-Ordner>"
    exit 1
fi

pkcs12_path="$1"
echo "PKCS12-Datei: $pkcs12_path"

# Output-Ordner ($2 oder /etc/ssl/easyroam) wählen
if [ -z "$2" ]; then
    output_path="/etc/ssl/certs/easyroam"
else
    output_path="$2"
fi

output_path=$(echo $output_path | sed 's/\/$//') # / am Ende entfernen
mkdir -p $output_path
echo "Output-Ordner: $output_path"

# tmp-Ordner erstellen
tmp_path="/tmp/easyroam_tmp"
mkdir -p $tmp_path

# Zertifikate extrahieren
echo "Generiere Zertifikate..."
openssl pkcs12 -legacy -in "$pkcs12_path" -nokeys -passin pass: > "$tmp_path/easyroam_client_cert.pem"
echo -n "Passwort für den privaten Schlüssel festlegen - "
openssl pkcs12 -legacy -in "$pkcs12_path" -nodes -nocerts -passin pass: | openssl rsa -aes256 -out "$tmp_path/easyroam_client_key.pem"
openssl pkcs12 -legacy -in "$pkcs12_path" -cacerts -passin pass: -passout pass: > "$tmp_path/easyroam_root_ca.pem"

# Common Name auslesen
common_name=$(openssl pkcs12 -info -in $pkcs12_path -legacy -nodes -passin pass: 2>/dev/null\
  | sed -n 's/subject=.*CN = \([^,]*\),.*$/\1/p')

# Zertifikate verschieben
echo "Verschiebe Zertifikate..."
mv $tmp_path/easyroam_*.pem $output_path/

# Zugriffsrechte setzen
echo "Setze Zugriffsrechte..."
chown root:root $output_path/easyroam_*.pem
chmod 644 $output_path/easyroam_*.pem

# Aufräumen
rm -r $tmp_path

# Abschließende Meldung
echo "Fertig! Die Zertifikate wurden in $output_path gespeichert: "
ls -l $output_path/easyroam_*.pem
echo "Der Identifier lautet: $common_name"
echo "Diese Daten können jetzt für die Netzwerkkonfiguration verwendet werden."
