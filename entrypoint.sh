#!/bin/bash

# Buat direktori konfigurasi Hermes jika belum ada
mkdir -p ~/.hermes

# Generate config.yaml otomatis dari Environment Variables Render
cat <<EOF > ~/.hermes/config.yaml
telegram:
  enabled: true
  bot_token: "${BOT_TOKEN}"
  allowed_chats: "${ALLOWED_CHATS}"
EOF

echo "Konfigurasi Hermes berhasil di-generate."

# Jalankan gateway atau Hermes Agent daemon
if command -v hermes &> /dev/null; then
    echo "Menjalankan Hermes Gateway..."
    hermes gateway restart || hermes gateway start
else
    echo "Menjalankan 9router / fallback service..."
    9router start
fi

# Dummy HTTP server agar Web Service Render tetap berstatus LIVE (PORT 10000)
node -e '
const http = require("http");
const server = http.createServer((req, res) => {
  res.writeHead(200, { "Content-Type": "text/plain" });
  res.end("Hermes Agent & 9router is running on Render!");
});
server.listen(process.env.PORT || 10000, () => {
  console.log("Health check server running on port " + (process.env.PORT || 10000));
});
'
