# Shop — e-Commerce приложение на Ruby on Rails

**Репозиторий:** https://github.com/dbsnen393-cmyk/shop

**Живой сайт:** https://shop-7kka.onrender.com

Интернет-магазин с аутентификацией пользователей, объявлениями о продаже и корзиной покупок.

---


## Установка на Windows

### 1. Ruby

Скачать и установить: https://rubyinstaller.org/downloads/

Версия, используемая в проекте: **Ruby 3.3.11+Devkit (x64)**. Нужна именно версия с Devkit — она включает компилятор для сборки нативных гемов.

Проверка:
```
ruby --version
```

---

### 2. Node.js

Скачать: https://nodejs.org/ — выбирать версию **LTS**. Версии 14–22 совместимы. Node.js 23+ не поддерживается Webpack 4.

Проверка:
```
node --version
```

---

### 3. Yarn

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

### 4. Bundler

```
gem install bundler
```

Проверка:
```
bundler --version
```

---

## Установка на macOS

### 1. Ruby

macOS поставляется со старой версией Ruby. Нужно установить актуальную через Homebrew.

Установить Homebrew (если не установлен):
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Установить rbenv и Ruby 3.3.x:
```bash
brew install rbenv
rbenv install 3.3.4
rbenv global 3.3.4
```

Проверка:
```bash
ruby --version
```

---

### 2. Node.js

```bash
brew install node@20
```

Или скачать вручную: https://nodejs.org/

Проверка:
```bash
node --version
```

---

### 3. Yarn

```bash
npm install -g yarn
```

Проверка:
```bash
yarn --version
```

---

### 4. Bundler

```bash
gem install bundler
```

---

## Первый запуск (выполняется один раз)

Открыть терминал в папке проекта и выполнить команды по порядку.

### Шаг 1 — Установка Ruby-зависимостей

```bash
bundle install
```

---

### Шаг 2 — Установка JavaScript-зависимостей

```bash
yarn install --ignore-scripts
```

> Флаг `--ignore-scripts` нужен, чтобы пропустить сборку `node-sass`, который не работает на Node.js 17+.

---

### Шаг 3 — Компиляция JavaScript

**macOS / Linux / Git Bash:**
```bash
NODE_OPTIONS=--openssl-legacy-provider bundle exec rake webpacker:compile
```

**PowerShell (Windows):**
```powershell
$env:NODE_OPTIONS="--openssl-legacy-provider"; bundle exec rake webpacker:compile
```

**CMD (Windows):**
```cmd
set NODE_OPTIONS=--openssl-legacy-provider && bundle exec rake webpacker:compile
```

---

### Шаг 4 — Создание базы данных и загрузка тестовых данных

```bash
bundle exec rake db:create db:migrate db:seed
```

Создаёт БД, применяет миграции и загружает тестового пользователя + 4 продукта с изображениями.

---

### Шаг 5 — Запуск сервера

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

## Запуск (если проект уже настроен)

Для последующих запусков нужна только одна команда:

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

## Тестовые данные

После выполнения `db:seed` в базе есть готовый аккаунт:

| | |
|---|---|
| Email | `user@example.com` |
| Пароль | `password` |

---

## Возможные ошибки

### `A server is already running`

Нужно удалить PID-файл и запустить заново:

**macOS / Git Bash:**
```bash
rm tmp/pids/server.pid && NODE_OPTIONS=--openssl-legacy-provider bundle exec rails server
```

**PowerShell:**
```powershell
Remove-Item tmp\pids\server.pid; $env:NODE_OPTIONS="--openssl-legacy-provider"; bundle exec rails server
```

**CMD:**
```cmd
del tmp\pids\server.pid && set NODE_OPTIONS=--openssl-legacy-provider && bundle exec rails server
```

---

### `Yarn not installed`

```bash
npm install -g yarn
```

---

### `error:0308010C:digital envelope routines::unsupported`

Webpack 4 не совместим с OpenSSL от Node.js 17+. Необходимо использовать `NODE_OPTIONS=--openssl-legacy-provider` перед командами — так, как показано в шагах выше.

---

### `Permission denied` при `db:reset` или `db:drop`

Файл БД заблокирован. Необходимо остановить сервер, затем выполнить:

**macOS / Git Bash:**
```bash
rm db/development.sqlite3 && bundle exec rake db:create db:migrate db:seed
```

**PowerShell:**
```powershell
Remove-Item db\development.sqlite3; bundle exec rake db:create db:migrate db:seed
```

---

### `Failed to manipulate with MiniMagick`

ImageMagick не установлен — приложение работает без него. Для включения ресайза изображений:

1. Установить [ImageMagick](https://imagemagick.org/script/download.php) (на macOS: `brew install imagemagick`)
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
