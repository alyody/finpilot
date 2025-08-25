@echo off
echo 🚀 FinPilot Development Setup
echo ================================

:: Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ❌ Node.js is not installed. Please install Node.js v18+ first.
    pause
    exit /b 1
)

echo ✅ Node.js version: 
node --version

:: Install root dependencies
echo 📦 Installing root dependencies...
call npm install

:: Install client dependencies
echo 📦 Installing client dependencies...
cd client
call npm install
cd ..

:: Install server dependencies
echo 📦 Installing server dependencies...
cd server
call npm install
cd ..

:: Create environment files
echo 📝 Creating environment files...

:: Client .env
if not exist "client\.env" (
    copy "client\.env.example" "client\.env"
    echo ✅ Created client/.env from template
) else (
    echo ⚠️  client/.env already exists, skipping...
)

:: Server .env
if not exist "server\.env" (
    copy "server\.env.example" "server\.env"
    echo ✅ Created server/.env from template
    echo.
    echo 🔧 IMPORTANT: Please update server/.env with your database URL
    echo    DATABASE_URL="postgresql://username:password@localhost:5432/finpilot"
    echo.
) else (
    echo ⚠️  server/.env already exists, skipping...
)

echo 🗄️  Database setup...
cd server

:: Check if DATABASE_URL is set to default
findstr /C:"postgresql://username:password@localhost:5432/finpilot" .env >nul
if not errorlevel 1 (
    echo ⚠️  Please update DATABASE_URL in server/.env before running database migrations
    echo.
    echo 💡 Free cloud database options:
    echo    • Supabase: https://supabase.com (500MB free^)
    echo    • Neon: https://neon.tech (512MB free^)
    echo    • PlanetScale: https://planetscale.com (5GB free^)
    echo.
    echo 📖 See DEPLOYMENT_GUIDE.md for detailed setup instructions
) else (
    echo 🔄 Running Prisma setup...
    call npx prisma generate
    echo ✅ Prisma client generated
    
    echo.
    echo 🚨 NEXT STEPS:
    echo 1. Set up your database (see DEPLOYMENT_GUIDE.md^)
    echo 2. Run: cd server ^&^& npx prisma migrate dev
    echo 3. Run: cd server ^&^& npx prisma db seed
)

cd ..

echo.
echo 🎉 Setup complete!
echo.
echo 🚀 To start development:
echo    Terminal 1: cd server ^&^& npm run dev     (Backend - http://localhost:5000^)
echo    Terminal 2: cd client ^&^& npm run dev     (Frontend - http://localhost:5173^)
echo.
echo 📖 For deployment instructions, see DEPLOYMENT_GUIDE.md
echo 🆓 Deploy for FREE using Render + Supabase + Netlify!

pause