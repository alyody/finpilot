# 🚀 FinPilot Free Deployment Guide

This guide will help you deploy FinPilot (expense management application) completely **FREE** with full functionality.

## 📋 Prerequisites

- GitHub account
- Node.js v18+ installed locally
- Basic command line knowledge

## 🎯 Recommended Free Hosting Stack

**Backend**: Render (Free Web Service)  
**Database**: Supabase (Free PostgreSQL 500MB)  
**Frontend**: Netlify or Vercel (Free Static Hosting)

---

## 🗄️ Step 1: Set Up Free Database (Supabase)

### 1.1 Create Supabase Account
1. Go to [supabase.com](https://supabase.com)
2. Sign up with GitHub
3. Click "New Project"
4. Choose organization and enter:
   - **Project Name**: `finpilot-db`
   - **Database Password**: (generate strong password)
   - **Region**: Choose closest to you

### 1.2 Get Database URL
1. Go to **Settings** → **Database**
2. Find **Connection string** → **URI**
3. Copy the connection string (looks like):
   ```
   postgresql://postgres:[YOUR-PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
   ```
4. **Save this URL** - you'll need it for deployment!

---

## 🖥️ Step 2: Deploy Backend (Render)

### 2.1 Prepare Repository
1. **Fork or clone** the FinPilot repository to your GitHub
2. **Push** any local changes to GitHub

### 2.2 Create Render Account
1. Go to [render.com](https://render.com)
2. Sign up with GitHub
3. Connect your GitHub account

### 2.3 Deploy Backend Service
1. Click **"New"** → **"Web Service"**
2. Connect your FinPilot repository
3. Configure settings:
   - **Name**: `finpilot-api`
   - **Region**: Choose closest to you
   - **Branch**: `main`
   - **Root Directory**: `server`
   - **Runtime**: `Node`
   - **Build Command**: `npm install && npx prisma generate`
   - **Start Command**: `npm start`

### 2.4 Set Environment Variables
In Render dashboard, add these environment variables:

```env
DATABASE_URL=postgresql://postgres:[YOUR-PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
JWT_SECRET=your-super-secret-jwt-key-here-minimum-32-characters-long
NODE_ENV=production
PORT=5000
CORS_ORIGIN=*
```

### 2.5 Deploy and Get Backend URL
1. Click **"Create Web Service"**
2. Wait for deployment (5-10 minutes)
3. Your backend URL will be: `https://finpilot-api.onrender.com`
4. **Save this URL** - you'll need it for frontend!

---

## 🌐 Step 3: Deploy Frontend

### Option A: Netlify (Recommended)

#### 3.1 Create Netlify Account
1. Go to [netlify.com](https://netlify.com)
2. Sign up with GitHub

#### 3.2 Deploy Frontend
1. Click **"Add new site"** → **"Import an existing project"**
2. Choose **GitHub** and select your FinPilot repository
3. Configure build settings:
   - **Base directory**: `client`
   - **Build command**: `npm install && npm run build`
   - **Publish directory**: `client/dist`

#### 3.3 Set Environment Variables
In Netlify dashboard → **Site settings** → **Environment variables**:

```env
VITE_API_URL=https://finpilot-api.onrender.com/api
VITE_API_BASE_URL=https://finpilot-api.onrender.com
```

#### 3.4 Deploy
1. Click **"Deploy site"**
2. Your frontend URL will be: `https://[random-name].netlify.app`

### Option B: Vercel

#### 3.1 Create Vercel Account
1. Go to [vercel.com](https://vercel.com)
2. Sign up with GitHub

#### 3.2 Deploy Frontend
1. Click **"Add New Project"**
2. Import your FinPilot repository
3. Configure settings:
   - **Framework Preset**: Vite
   - **Root Directory**: `client`
   - **Build Command**: `npm run build`
   - **Output Directory**: `dist`

#### 3.3 Set Environment Variables
```env
VITE_API_URL=https://finpilot-api.onrender.com/api
VITE_API_BASE_URL=https://finpilot-api.onrender.com
```

---

## 🔧 Step 4: Initialize Database

### 4.1 Run Database Migrations
1. **Clone** your repository locally
2. **Navigate** to server directory:
   ```bash
   cd server
   ```
3. **Install** dependencies:
   ```bash
   npm install
   ```
4. **Create** `.env` file:
   ```env
   DATABASE_URL=postgresql://postgres:[YOUR-PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
   ```
5. **Run** Prisma migrations:
   ```bash
   npx prisma migrate dev
   npx prisma generate
   npx prisma db seed
   ```

---

## 🎉 Step 5: Test Your Deployment

### 5.1 Access Your Application
1. **Frontend**: `https://[your-app].netlify.app`
2. **Backend API**: `https://finpilot-api.onrender.com/api`

### 5.2 Test Functionality
1. **Register** a new account
2. **Login** with credentials
3. **Create** expense claims
4. **Upload** receipts
5. **Submit** for approval

---

## 💰 Cost Breakdown (100% FREE!)

| Service | Free Tier Limits | Cost |
|---------|------------------|------|
| **Supabase** | 500MB PostgreSQL, 50MB storage | $0 |
| **Render** | 750 hours/month web service | $0 |
| **Netlify** | 100GB bandwidth, 300 build minutes | $0 |
| **Total Monthly Cost** | | **$0** |

---

## 🔧 Alternative Free Hosting Options

### Option 2: Railway
- **Database + Backend**: Railway (free $5 credit monthly)
- **Frontend**: Vercel or Netlify
- **Setup**: Connect GitHub → Deploy both services

### Option 3: Heroku Alternative
- **Database**: Neon (free 512MB PostgreSQL)
- **Backend**: Railway or Render
- **Frontend**: Vercel or Netlify

---

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Check DATABASE_URL in environment variables
   - Ensure Supabase project is active

2. **CORS Error**
   - Add frontend URL to CORS_ORIGIN in backend
   - Check API URL in frontend environment variables

3. **Build Fails**
   - Check Node.js version compatibility
   - Verify all dependencies are installed

4. **API Not Responding**
   - Check Render service logs
   - Verify environment variables are set

### Getting Help
1. Check deployment logs in hosting dashboard
2. Verify all environment variables
3. Test API endpoints directly
4. Check network tab in browser devtools

---

## 🚀 Production Optimization (Optional)

### Performance Improvements
1. **Enable Gzip** compression in hosting settings
2. **Set up CDN** through Netlify/Vercel
3. **Configure caching** headers
4. **Optimize images** and assets

### Security Enhancements
1. **Add rate limiting** to API
2. **Set up monitoring** with Sentry (free tier)
3. **Enable HTTPS** (automatic with hosting providers)
4. **Configure proper CORS** settings

---

## 📝 Maintenance

### Regular Tasks
1. **Monitor** free tier usage limits
2. **Backup** database regularly (Supabase automatic)
3. **Update** dependencies monthly
4. **Review** application logs

### Scaling Up
When you outgrow free tiers:
1. **Upgrade** to paid hosting plans
2. **Add** monitoring and analytics
3. **Implement** CI/CD pipelines
4. **Set up** staging environments

---

**🎯 Result**: You now have a fully functional expense management application running completely free with professional hosting infrastructure!

**📧 Need Help?** 
- Check hosting provider documentation
- Review application logs for errors
- Verify environment variables configuration