#!/bin/bash

# FinPilot Local Development Setup Script
# Run this script to set up your local development environment

echo "🚀 FinPilot Development Setup"
echo "================================"

# Check if Node.js is installed
if ! command -v node &> /dev/null; then
    echo "❌ Node.js is not installed. Please install Node.js v18+ first."
    exit 1
fi

echo "✅ Node.js version: $(node --version)"

# Check if PostgreSQL is running
if ! command -v psql &> /dev/null; then
    echo "⚠️  PostgreSQL not found. You can use a cloud database instead."
fi

# Install root dependencies
echo "📦 Installing root dependencies..."
npm install

# Install client dependencies
echo "📦 Installing client dependencies..."
cd client
npm install
cd ..

# Install server dependencies
echo "📦 Installing server dependencies..."
cd server
npm install
cd ..

# Create environment files
echo "📝 Creating environment files..."

# Client .env
if [ ! -f "client/.env" ]; then
    cp client/.env.example client/.env
    echo "✅ Created client/.env from template"
else
    echo "⚠️  client/.env already exists, skipping..."
fi

# Server .env
if [ ! -f "server/.env" ]; then
    cp server/.env.example server/.env
    echo "✅ Created server/.env from template"
    echo ""
    echo "🔧 IMPORTANT: Please update server/.env with your database URL"
    echo "   DATABASE_URL=\"postgresql://username:password@localhost:5432/finpilot\""
    echo ""
else
    echo "⚠️  server/.env already exists, skipping..."
fi

echo "🗄️  Database setup..."
cd server

# Check if DATABASE_URL is set
if grep -q "postgresql://username:password@localhost:5432/finpilot" .env; then
    echo "⚠️  Please update DATABASE_URL in server/.env before running database migrations"
    echo ""
    echo "💡 Free cloud database options:"
    echo "   • Supabase: https://supabase.com (500MB free)"
    echo "   • Neon: https://neon.tech (512MB free)"
    echo "   • PlanetScale: https://planetscale.com (5GB free)"
    echo ""
    echo "📖 See DEPLOYMENT_GUIDE.md for detailed setup instructions"
else
    echo "🔄 Running Prisma setup..."
    npx prisma generate
    echo "✅ Prisma client generated"
    
    echo ""
    echo "🚨 NEXT STEPS:"
    echo "1. Set up your database (see DEPLOYMENT_GUIDE.md)"
    echo "2. Run: cd server && npx prisma migrate dev"
    echo "3. Run: cd server && npx prisma db seed"
fi

cd ..

echo ""
echo "🎉 Setup complete!"
echo ""
echo "🚀 To start development:"
echo "   Terminal 1: cd server && npm run dev     (Backend - http://localhost:5000)"
echo "   Terminal 2: cd client && npm run dev     (Frontend - http://localhost:5173)"
echo ""
echo "📖 For deployment instructions, see DEPLOYMENT_GUIDE.md"
echo "🆓 Deploy for FREE using Render + Supabase + Netlify!"