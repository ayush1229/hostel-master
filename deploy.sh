#!/bin/bash

echo "🚀 Starting Local Server Deployment..."

# 1. Pull the latest code and update submodules
echo "📦 Fetching latest updates from GitHub..."
git pull origin main
git submodule update --init --recursive

# 2. Safety Check: Ensure environment variables exist
if [ ! -f ".env" ] || [ ! -f "hostel-backend/.env" ]; then
    echo "❌ ERROR: Missing .env files!"
    echo "Ensure both the root .env and hostel-backend/.env exist before running."
    exit 1
fi

# 3. Rebuild and restart the Docker stack
echo "🐳 Stopping old containers and building new ones..."
docker compose down
docker compose up --build -d

# 4. Wait for the backend and database to boot up
echo "⏳ Waiting 10 seconds for the database to fully initialize..."
sleep 10

# 5. Run the database setup script automatically
# The -T flag is required when running docker exec from a bash script
echo "🗄️ Executing database setup script..."
docker compose exec -T hostel-backend node scripts/setup-db.js

echo "✅ Deployment Complete! All services are live."