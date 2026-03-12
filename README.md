# 🐳 Dockerized Flask App with CI/CD

A Python Flask app containerized with Docker multi-stage builds, automatically pushed to Docker Hub via GitHub Actions on every commit.

---

## 🛠️ Tech Stack
`Python` `Flask` `Docker` `Distroless` `GitHub Actions` `Docker Hub`

---

## 🚀 Run Locally

```bash
git clone https://github.com/uttamtripathi-p/docker-cicd-flask.git
cd docker-cicd-flask
docker build -t flask-app .
docker run -p 8080:80 flask-app
# Visit http://localhost:8080
```

---

## ⚙️ CI/CD Pipeline

Push to `main` → GitHub Actions builds image → pushes to Docker Hub automatically.

Requires two GitHub Secrets:
| Secret | Value |
|---|---|
| `DOCKER_USERNAME` | Docker Hub username |
| `DOCKER_TOKEN` | Docker Hub access token |

---

## 📦 Pull from Docker Hub

```bash
docker pull uttamtripathi/flask-app:latest
```

---

## 📚 What I Learned
- Multi-stage Dockerfiles to minimize image size (~75MB vs ~900MB)
- Docker layer caching and instruction ordering
- Distroless images for security
- GitHub Actions CI/CD automation
- Managing secrets securely

---

## ✅ Status
| Step | Status |
|---|---|
| Flask app + Dockerfile | ✅ |
| Local build & run | ✅ |
| Pushed to GitHub | ✅ |
| GitHub Actions pipeline | ⏳ |
| Docker Hub push working | ⏳ |

---

**Uttam Tripathi** — [GitHub](https://github.com/uttamtripathi-p) • uttamtripathi2020@gmail.com
