# Shop — e-Commerce приложение на Ruby on Rails

Интернет-магазин с аутентификацией пользователей, объявлениями о продаже и корзиной покупок.

---

## Что нужно установить

### 1. Ruby

Скачать и установить с официального сайта: https://rubyinstaller.org/downloads/

Версия, используемая в проекте: **Ruby 3.3.11+Devkit (x64)**. Нужна именно версия с Devkit — она включает компилятор для сборки нативных гемов.

Проверка после установки:
```
ruby --version
```

---

### 2. Node.js

Скачать с официального сайта: https://nodejs.org/

Версии 14–22 совместимы с проектом. Node.js 23+ не поддерживается Webpack 4.

Проверка:
```
node --version
```

---

### 3. Yarn

После установки Node.js выполнить в терминале:

**PowerShell / CMD:**
```
npm install -g yarn
```

> **Ошибка в PowerShell: `выполнение сценариев отключено`** — выполнить один раз:
> ```powershell
> Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
> ```
> Нажать `Y` → Enter. После этого повторить `npm install -g yarn`.

Проверка:
```
yarn --version
```

---

### 4. Bundler (менеджер Ruby-гемов)

```
gem install bundler
```

Проверка:
```
bundler --version
```

---

## Первый запуск (выполняется один раз)

Открыть терминал в папке проекта и выполнить команды по порядку.

### Шаг 1 — Установка Ruby-зависимостей

**PowerShell:**
```powershell
bundle install
```

**CMD / bash:**
```bash
bundle install
```

---

### Шаг 2 — Установка JavaScript-зависимостей

**PowerShell:**
```powershell
yarn install --ignore-scripts
```

**CMD / bash:**
```bash
yarn install --ignore-scripts
```

---

### Шаг 3 — Компиляция JavaScript

**PowerShell:**
```powershell
$env:NODE_OPTIONS="--openssl-legacy-provider"; bundle exec rake webpacker:compile
```

**CMD:**
```cmd
set NODE_OPTIONS=--openssl-legacy-provider && bundle exec rake webpacker:compile
```

**bash (Git Bash / WSL):**
```bash
NODE_OPTIONS=--openssl-legacy-provider bundle exec rake webpacker:compile
```

---

### Шаг 4 — Создание базы данных и загрузка тестовых данных

**PowerShell / CMD / bash:**
```
bundle exec rake db:create db:migrate db:seed
```

Эта команда создаёт БД, применяет миграции и загружает тестового пользователя + 4 продукта.

---

### Шаг 5 — Запуск сервера

**PowerShell:**
```powershell
$env:NODE_OPTIONS="--openssl-legacy-provider"; bundle exec rails server
```

**CMD:**
```cmd
set NODE_OPTIONS=--openssl-legacy-provider && bundle exec rails server
```

**bash (Git Bash / WSL):**
```bash
NODE_OPTIONS=--openssl-legacy-provider bundle exec rails server
```

Открыть в браузере: **http://localhost:3000**

---

## Запуск (если проект уже настроен)

Для последующих запусков нужна только одна команда:

**PowerShell:**
```powershell
$env:NODE_OPTIONS="--openssl-legacy-provider"; bundle exec rails server
```

**CMD:**
```cmd
set NODE_OPTIONS=--openssl-legacy-provider && bundle exec rails server
```

**bash (Git Bash / WSL):**
```bash
NODE_OPTIONS=--openssl-legacy-provider bundle exec rails server
```

---

## Тестовые данные

После выполнения `db:seed` в базе есть готовый аккаунт:

| | |
|---|---|
| Email | `user@example.com` |
| Пароль | `password` |

---

## Возможные ошибки

### `A server is already running`

Сервер уже запущен (остался с прошлого раза). Нужно удалить PID-файл и запустить заново:

**PowerShell:**
```powershell
Remove-Item tmp\pids\server.pid; $env:NODE_OPTIONS="--openssl-legacy-provider"; bundle exec rails server
```

**CMD:**
```cmd
del tmp\pids\server.pid && set NODE_OPTIONS=--openssl-legacy-provider && bundle exec rails server
```

**bash:**
```bash
rm tmp/pids/server.pid && NODE_OPTIONS=--openssl-legacy-provider bundle exec rails server
```

---

### `Yarn not installed`

```
npm install -g yarn
```

---

### `error:0308010C:digital envelope routines::unsupported`

Webpack 4 не совместим с OpenSSL от Node.js 17+. Необходимо использовать `$env:NODE_OPTIONS="--openssl-legacy-provider"` перед командами webpacker и rails server — так, как показано в шагах выше.

---

### `Permission denied` при `db:reset` или `db:drop`

Файл БД заблокирован. Необходимо остановить сервер, затем выполнить:

**PowerShell:**
```powershell
Remove-Item db\development.sqlite3; bundle exec rake db:create db:migrate db:seed
```

**bash:**
```bash
rm db/development.sqlite3 && bundle exec rake db:create db:migrate db:seed
```

---

### `Failed to manipulate with MiniMagick`

ImageMagick не установлен — приложение работает без него. Для включения ресайза изображений:

1. Установить [ImageMagick](https://imagemagick.org/script/download.php#windows)
2. Раскомментировать в `app/uploaders/image_uploader.rb`:
   ```ruby
   include CarrierWave::MiniMagick

   version :thumb do
     process resize_to_fit: [400, 300]
   end

   version :default do
     process resize_to_fit: [800, 600]
   end
   ```

---

## Функциональность

- **Регистрация и вход** — через Devise (имя, email, пароль)
- **Создание объявлений** — кнопка «Sell», только для авторизованных
- **Редактирование / удаление** — только автор своего объявления
- **Корзина** — добавление, удаление по одному, полная очистка
- **Итоговая сумма** — обновляется автоматически
- **Иконка корзины** — показывает количество товаров в навбаре
- **Гостевая корзина** — сохраняется при входе в аккаунт
- **Flash-сообщения** — исчезают через 3 секунды

---

## Технологии

| | |
|---|---|
| Ruby on Rails | 6.1.7 |
| База данных | SQLite3 |
| Аутентификация | Devise |
| CSS-фреймворк | Bulma |
| Загрузка файлов | CarrierWave |
| JavaScript bundler | Webpacker 5 |
| Формы | simple_form |
