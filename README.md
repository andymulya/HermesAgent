# Hermes Agent & 9router Deployment di Render

Proyek ini berisi konfigurasi Docker untuk mendeploy **Hermes Agent** dan **9router** ke platform **Render**.

## Struktur File
- `Dockerfile`: Spesifikasi container Linux (Node.js 20), menginstal Hermes Agent dan 9router.
- `entrypoint.sh`: Script otomatisasi untuk generate `config.yaml` Hermes dari Environment Variables dan menjalankan health check server.
- `.env.example`: Contoh variabel lingkungan yang wajib diisi di Render.
- `.gitignore`: Memastikan credential dan file sensitif tidak ter-upload ke GitHub.

## Cara Deploy ke Render

1. **Push ke GitHub**:
   - Buat repo baru di GitHub.
   - Upload/push seluruh isi folder ini ke repository tersebut.

2. **Setup di Render**:
   - Buka [Render Dashboard](https://dashboard.render.com/).
   - Buat **New Web Service** dan hubungkan ke repository GitHub Anda.
   - Pilih environment **Docker**.
   - Pada bagian **Environment Variables**, tambahkan:
     - `BOT_TOKEN`: Token bot Telegram Anda dari `@BotFather`.
     - `ALLOWED_CHATS`: Chat ID Telegram Anda.
   - Klik **Create Web Service**.

3. **Mencegah Sleep/Spin-Down (Opsional - Free Tier)**:
   - Salin URL Web Service dari Render (misal: `https://hermes-agent-bot.onrender.com`).
   - Gunakan layanan gratisan seperti [UptimeRobot](https://uptimerobot.com/) untuk melakukan ping HTTP ke URL tersebut setiap 5-10 menit.
