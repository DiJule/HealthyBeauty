# Інструкція деплою на Render

## Передумови
1. GitHub репозиторій зі всім кодом
2. Облікові записи на:
   - [Render.com](https://render.com) (Free plan)
   - GitHub

## Крок 1: Підготовка репозиторію

Переконайтеся що в репозиторії є:
- ✅ `Dockerfile` (оновлений для PostgreSQL)
- ✅ `Gemfile` з `gem "pg"` для production
- ✅ `config/database.yml` з PostgreSQL конфігурацією
- ✅ `bin/docker-entrypoint` (оновлений для assets precompile)
- ✅ `render.yaml` (конфігурація для Render)
- ✅ `.ruby-version` (3.3.5)
- ✅ `config/master.key` (НЕ комітити, додати в .gitignore)

Команди для перевірки:
```bash
git status
git log --oneline -3
```

## Крок 2: Push код на GitHub

```bash
git add .
git commit -m "Prepare for Render deployment: PostgreSQL, Docker, assets precompile"
git push origin main
```

## Крок 3: Налаштування на Render

### 3.1 Створення нового Web Service

1. Відкрити [Render Dashboard](https://dashboard.render.com)
2. Натиснути **"New +"** → **"Web Service"**
3. Вибрати **"Deploy an existing repository"**
4. Вибрати ваш GitHub репозиторій (healthybeauty)
5. Налаштування:
   - **Name**: `healthybeauty`
   - **Environment**: `Docker`
   - **Region**: `Frankfurt` (або потрібна)
   - **Branch**: `main`
   - **Build Command**: (залишити порожнім - автоматично)
   - **Start Command**: (залишити порожнім - автоматично)
   - **Plan**: `Free`

### 3.2 Додавання Environment Variables

На сторінці Web Service перейти в **"Environment"** і додати:

```
RAILS_ENV=production
RAILS_LOG_TO_STDOUT=true
RAILS_SERVE_STATIC_FILES=true
RAILS_MASTER_KEY=<скопіюйте з config/master.key>
```

Як отримати `RAILS_MASTER_KEY`:
```bash
cat config/master.key
```

### 3.3 Створення PostgreSQL Database

1. На Render Dashboard натиснути **"New +"** → **"PostgreSQL"**
2. Налаштування:
   - **Name**: `healthybeauty-db`
   - **Database**: `healthybeauty_production`
   - **Region**: `Frankfurt`
   - **PostgreSQL Version**: `15`
   - **Plan**: `Free`

3. Після створення скопіюйте **Internal Database URL** (починається з `postgres://`)

### 3.4 Підключення Database до Web Service

1. Повернутися на сторінку Web Service
2. Перейти в **"Environment"**
3. Додати змінну:
   ```
   DATABASE_URL=<paste Internal Database URL from PostgreSQL service>
   ```

## Крок 4: Deploy

1. На сторінці Web Service натиснути **"Deploy latest commit"** або чекати автоматичного деплою після push
2. Слідити за логами (вкладка **"Logs"**):
   - `=> Booting Puma` - хороший знак
   - `db:prepare` - готує БД
   - `assets:precompile` - компілює assets
   - Помилки видаватимуться червоним кольором

### Очікувані логи:
```
=> Preparing database...
=> Precompiling assets...
=> Booting Puma
* Listening on http://0.0.0.0:3000
Use Ctrl-C to stop
```

## Крок 5: Verifying Deployment

1. Дочекатися статусу **"Live"** (зелена точка)
2. Відкрити URL вашого сервісу (наприклад: `https://healthybeauty-xxxx.onrender.com`)
3. Перевірити:
   - ✅ Головна сторінка завантажується
   - ✅ Стилі CSS завантажуються (перевірити інспектор)
   - ✅ JavaScript працює
   - ✅ База даних доступна (якщо є сторінки з даними)

## Крок 6: Налаштування Custom Domain (опціонально)

1. На сторінці Web Service перейти в **"Settings"**
2. В секції **"Custom Domains"** натиснути **"Add Custom Domain"**
3. Внести ваш домен (наприклад: `healthybeauty.com`)
4. Слідити за інструкціями щоб оновити DNS записи

## Troubleshooting

### Deploy Failed
**Проблема**: Build не пройшов
**Рішення**:
1. Перевірити логи в Render Dashboard
2. Поширені проблеми:
   - Gemfile.lock не синхронізований: `bundle lock --add-platform x86_64-linux` локально
   - Помилки у Dockerfile: перевірити синтаксис
   - Відсутня RAILS_MASTER_KEY: додати в Environment Variables

### Assets not loading (404 errors on CSS/JS)
**Проблема**: Сторінка завантажується, але без стилів
**Рішення**:
1. Перевірити логи за помилками при `assets:precompile`
2. Переконатися що `RAILS_SERVE_STATIC_FILES=true` встановлена
3. Рестартувати Deploy

### Database connection error
**Проблема**: "could not connect to server"
**Рішення**:
1. Перевірити що DATABASE_URL встановлена правильно
2. Переконатися що PostgreSQL service є у "Live" статусі
3. Рестартувати Web Service

### Migrations didn't run
**Проблема**: `PG::UndefinedTable` помилки
**Рішення**:
1. Логи мають показувати `db:prepare` - якщо немає, перевірити Dockerfile
2. Вручну запустити міграції (якщо потрібно):
   - На Render у Web Service натиснути **"Shell"** і запустити:
     ```bash
     ./bin/rails db:migrate
     ```

## Оновлення коду після deployment

Щоб оновити production:
```bash
git add .
git commit -m "Description of changes"
git push origin main
```

Render автоматично перекомпілює і редеплоює.

## Додаткові ресурси

- [Render Docs: Docker](https://render.com/docs/docker)
- [Render Docs: Rails](https://render.com/docs/deploy-rails)
- [PostgreSQL на Render](https://render.com/docs/databases)
