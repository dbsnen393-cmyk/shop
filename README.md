# Shop — e-Commerce приложение на Ruby on Rails

**Репозиторий:** https://github.com/dbsnen393-cmyk/shop

**Живой сайт:** https://shop-7kka.onrender.com

Интернет-магазин с аутентификацией пользователей, объявлениями о продаже и корзиной покупок.

---

## Быстрый старт для аудиторов

Приложение задеплоено на Render и доступно онлайн — **устанавливать ничего не нужно**.
Веб-версия сделана специально для удобства проверки: можно сразу открыть сайт и протестировать весь функционал без клонирования репозитория и настройки окружения.

**Живой сайт:** https://shop-7kka.onrender.com

> Сайт может загружаться 30–60 секунд при первом обращении (Render Free засыпает в простое).

### Тестовый аккаунт

| | |
|---|---|
| Email | `user@example.com` |
| Пароль | `password` |

### Что можно проверить на живом сайте

1. **Регистрация** — кнопка «Sign up» в правом верхнем углу
2. **Вход** — кнопка «Sign in»
3. **Просмотр товаров** — главная страница, 6 товаров с фотографиями
4. **Создание объявления** — кнопка «Sell» (нужен вход), заполнить форму, загрузить фото
5. **Редактирование / удаление** — только своих объявлений (кнопки Edit / Delete на странице товара)
6. **Корзина** — кнопка «Add to Cart» на карточке товара, иконка корзины в навбаре
7. **Выход** — меню «Account» → Sign out

---

## Структура проекта

```
shop/
├── app/
│   ├── controllers/
│   │   ├── products_controller.rb   # CRUD товаров
│   │   ├── carts_controller.rb      # Корзина
│   │   ├── line_items_controller.rb # Позиции в корзине
│   │   └── registrations_controller.rb # Регистрация (Devise)
│   ├── models/
│   │   ├── product.rb               # Модель товара (валидации, загрузка фото)
│   │   ├── user.rb                  # Модель пользователя
│   │   ├── cart.rb                  # Модель корзины
│   │   └── line_item.rb             # Позиция в корзине
│   ├── views/
│   │   ├── products/                # Шаблоны страниц товаров
│   │   ├── carts/                   # Страница корзины
│   │   └── layouts/                 # Общий layout (навбар, flash)
│   └── uploaders/
│       └── image_uploader.rb        # CarrierWave + Cloudinary
├── db/
│   ├── migrate/                     # Миграции базы данных
│   ├── schema.rb                    # Текущая схема БД
│   └── seeds.rb                     # Тестовые данные (6 товаров)
├── config/
│   ├── routes.rb                    # Маршруты
│   └── initializers/
│       └── cloudinary.rb            # Настройка Cloudinary
├── bin/
│   └── render-build.sh              # Скрипт сборки для Render
└── render.yaml                      # Конфигурация деплоя на Render
```

---

## Функциональность

- **Регистрация и вход** — Devise (имя, email, пароль)
- **Создание объявлений** — только для авторизованных пользователей
- **Редактирование / удаление** — только автор своего объявления
- **Загрузка фото** — CarrierWave + Cloudinary (хранение в облаке)
- **Категории** — Cars, Clothes, Computers, Electronics, Phones, Watches, Furniture, Other
- **Бренды** — Apple, BMW, Dell, Ferrari, Ford, HP, Lenovo, Mercedes, Nike, Opel, Samsung, Sony, Toyota
- **Состояние** — New, Excellent, Mint, Used, Fair, Poor
- **Корзина** — добавление, изменение количества, удаление, итоговая сумма
- **Flash-сообщения** — исчезают через 3 секунды

---

## Технологии

| | |
|---|---|
| Ruby on Rails | 6.1.7 |
| Ruby | 3.3.x |
| База данных (dev) | SQLite3 |
| База данных (prod) | PostgreSQL |
| Аутентификация | Devise |
| CSS-фреймворк | Bulma |
| Загрузка файлов | CarrierWave |
| Хранение фото | Cloudinary (production) |
| JavaScript bundler | Webpacker 5 |
| Формы | simple_form |
| Деплой | Render.com |

---

## Локальный запуск

### Требования

- Ruby 3.3.x + Devkit — https://rubyinstaller.org/downloads/ (Windows) или `brew install rbenv` (macOS)
- Node.js LTS (14–22) — https://nodejs.org/
- Yarn — `npm install -g yarn`
- Bundler — `gem install bundler`

> **Windows PowerShell: ошибка выполнения сценариев** — выполнить один раз:
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
> ```

---

### Шаг 1 — Клонировать репозиторий

```bash
git clone https://github.com/dbsnen393-cmyk/shop.git
cd shop
```

---

### Шаг 2 — Установить зависимости

```bash
bundle install
yarn install --ignore-scripts
```

---

### Шаг 3 — Создать базу данных и загрузить тестовые данные

```bash
bundle exec rake db:create db:migrate db:seed
```

Создаёт БД, применяет миграции и загружает тестового пользователя + 6 товаров с фотографиями.

---

### Шаг 4 — Запустить сервер

**macOS / Linux / Git Bash:**
```bash
NODE_OPTIONS=--openssl-legacy-provider bundle exec rails server
```

**PowerShell (Windows):**
```powershell
$env:NODE_OPTIONS="--openssl-legacy-provider"; bundle exec rails server
```

**CMD (Windows):**
```cmd
set NODE_OPTIONS=--openssl-legacy-provider && bundle exec rails server
```

Открыть в браузере: **http://localhost:3000**

---

### Запуск (если проект уже настроен)

Шаги 2 и 3 нужны только один раз. Для последующих запусков:

**macOS / Linux / Git Bash:**
```bash
NODE_OPTIONS=--openssl-legacy-provider bundle exec rails server
```

**PowerShell (Windows):**
```powershell
$env:NODE_OPTIONS="--openssl-legacy-provider"; bundle exec rails server
```

**CMD (Windows):**
```cmd
set NODE_OPTIONS=--openssl-legacy-provider && bundle exec rails server
```

---

## Возможные ошибки

### `A server is already running`

**macOS / Git Bash:**
```bash
rm tmp/pids/server.pid
```

**PowerShell:**
```powershell
Remove-Item tmp\pids\server.pid
```

Затем запустить сервер снова.

---

### `Yarn not installed`

```bash
npm install -g yarn
```

---

### `error:0308010C:digital envelope routines::unsupported`

Webpack 4 не совместим с OpenSSL от Node.js 17+. Используйте `NODE_OPTIONS=--openssl-legacy-provider` как показано в шагах выше, либо понизьте Node.js до версии 16–18.

---

### `Permission denied` при `db:reset` или `db:drop`

Файл БД заблокирован — остановите сервер, затем:

**macOS / Git Bash:**
```bash
rm db/development.sqlite3 && bundle exec rake db:create db:migrate db:seed
```

**PowerShell:**
```powershell
Remove-Item db\development.sqlite3; bundle exec rake db:create db:migrate db:seed
```
