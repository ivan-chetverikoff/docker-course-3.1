#  Express App CI/CD Pipeline

Автоматизированный конвейер развертывания для Node.js/Express приложения.

##  Live Demo
https://docker-course-3-1.onrender.com

##  Структура
- `src/index.js`  Express приложение
- `Dockerfile`  инструкция сборки образа
- `.github/workflows/release.yml`  GitHub Actions CI/CD (Docker Hub)
- `docker-compose.yml`  локальный запуск + Watchtower

##  Как это работает
1. Push в ветку `main` запускает GitHub Actions.
2. Actions собирает образ и пушит в Docker Hub.
3. Render автоматически подтягивает изменения из GitHub и пересобирает контейнер.
