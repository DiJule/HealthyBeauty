# ✅ ЧЕКЛІСТ ПЕРЕД ДЕПЛОЄМ НА RENDER

## 1. Локальна підготовка
- [ ] `git status` - немає незафіксованих змін
- [ ] `bundle install` - всі gems встановлені
- [ ] `rails db:test:prepare` - тестова БД готова
- [ ] `bin/rails test` - усі тести проходять
- [ ] Локально запустити `rails server` и перевірити http://localhost:3000

## 2. Конфіг-файли для Production
- [ ] `Gemfile` містить `gem "pg"` в production групі
- [ ] `config/database.yml` має PostgreSQL конфіг для production
- [ ] `Dockerfile` - multi-stage build, no assets precompile у build stage
- [ ] `bin/docker-entrypoint` - виконує `db:prepare` i `assets:precompile`
- [ ] `.ruby-version` = `3.3.5`

## 3. Assets & Static Files
- [ ] `app/assets/stylesheets/application.css` існує
- [ ] `app/javascript/application.js` існує
- [ ] `config/environments/production.rb`:
  - `config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present?`
  - `config.force_ssl = false` (Render використовує свій SSL)

## 4. Environment Variables
- [ ] `config/master.key` - НЕ в гіті (перевірити `.gitignore`)
- [ ] `.env` - НЕ в гіті
- [ ] `.env.example` - публічна копія змінних
- [ ] Список змінних для Render:
  - `RAILS_ENV=production`
  - `RAILS_LOG_TO_STDOUT=true`
  - `RAILS_SERVE_STATIC_FILES=true`
  - `RAILS_MASTER_KEY=<from config/master.key>`
  - `DATABASE_URL=<from PostgreSQL service>`

## 5. Git & GitHub
- [ ] `git add .` - додати всі файли (окрім gitignore)
- [ ] `git commit -m "Prepare for Render: Docker, PostgreSQL, assets precompile"`
- [ ] `git push origin main` - push на GitHub
- [ ] GitHub репозиторій публічний або Render має доступ

## 6. Render Setup
### Web Service
- [ ] Name: `healthybeauty`
- [ ] Runtime: `Docker`
- [ ] Region: `Frankfurt` (або потрібна)
- [ ] Plan: `Free`
- [ ] Branch: `main`
- [ ] Environment Variables додані:
  - [ ] RAILS_ENV=production
  - [ ] RAILS_LOG_TO_STDOUT=true
  - [ ] RAILS_SERVE_STATIC_FILES=true
  - [ ] RAILS_MASTER_KEY=<from config/master.key>
  - [ ] DATABASE_URL=<from PostgreSQL>

### PostgreSQL Service
- [ ] Name: `healthybeauty-db`
- [ ] Database: `healthybeauty_production`
- [ ] Region: `Frankfurt`
- [ ] PostgreSQL Version: `15`
- [ ] Plan: `Free`
- [ ] DATABASE_URL скопійована (Internal Database URL)

## 7. Deploy & Verify
- [ ] Web Service статус: **"Live"** (зелена точка)
- [ ] Логи відображають:
  - `=> Preparing database...`
  - `=> Precompiling assets...`
  - `Listening on http://0.0.0.0:3000`
- [ ] URL відкривається без помилок
- [ ] Стилі CSS завантажуються (F12 → Network → перевірити .css файли)
- [ ] JavaScript працює (консоль F12 без помилок)

## 8. Post-Deploy
- [ ] Налаштувати Custom Domain (якщо потрібно)
- [ ] Налаштувати Environment Variables для API ключів (якщо потрібні)
- [ ] Запустити admin seed data (якщо потрібні дані):
  ```bash
  # У Render Shell (Web Service → Shell)
  ./bin/rails db:seed
  ```

## 🚀 Готово до Production!

Якщо щось не вийшло:
1. Перевірте Logs на Render Dashboard
2. Прочитайте [DEPLOY.md](DEPLOY.md)
3. Спробуйте `Redeploy` на сторінці Web Service
