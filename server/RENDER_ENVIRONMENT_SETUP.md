# Render Environment Variables Configuration Guide

## Current Issue
Your Render deployment is failing because Prisma can't connect to the Supabase database during build time.

## Step-by-Step Environment Variable Setup

### 1. Access Render Environment Settings
1. Go to [render.com](https://render.com)
2. Sign in to your account  
3. Click on your **"finpilot-api"** service
4. Click on **"Environment"** tab in the left sidebar

### 2. Required Environment Variables

You need to set these environment variables in Render:

#### Essential Variables:
```
DATABASE_URL=postgresql://postgres.[PROJECT-REF]:[PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
JWT_SECRET=your-super-secret-jwt-key-here-minimum-32-characters
NODE_ENV=production
PORT=10000
```

#### Additional Recommended Variables:
```
JWT_EXPIRES_IN=7d
BCRYPT_ROUNDS=12
CORS_ORIGIN=*
```

### 3. How to Add Environment Variables in Render

1. In the Environment tab, you'll see an **"Add Environment Variable"** button
2. Click it to add each variable:

**Variable 1: DATABASE_URL**
- Key: `DATABASE_URL`
- Value: `[Your complete Supabase connection string]`

**Variable 2: JWT_SECRET**
- Key: `JWT_SECRET` 
- Value: `your-super-secret-jwt-key-here-minimum-32-characters-or-longer`

**Variable 3: NODE_ENV**
- Key: `NODE_ENV`
- Value: `production`

**Variable 4: PORT**
- Key: `PORT`
- Value: `10000` (Render's default port)

### 4. Database URL Format Check

Your DATABASE_URL should follow this exact format:
```
postgresql://postgres.[PROJECT-ID]:[DB-PASSWORD]@db.[PROJECT-ID].supabase.co:5432/postgres
```

**Example:**
```
postgresql://postgres.abcdefghijklmnop:MySecurePassword123@db.abcdefghijklmnop.supabase.co:5432/postgres
```

### 5. Common Mistakes to Avoid

❌ **Wrong URL format:**
```
db.pgdefejeluwiyxljnfxf.supabase.co:5432
```

✅ **Correct URL format:**
```
postgresql://postgres.pgdefejeluwiyxljnfxf:password123@db.pgdefejeluwiyxljnfxf.supabase.co:5432/postgres
```

❌ **Missing credentials:**
```
postgresql://db.project.supabase.co:5432/postgres
```

✅ **With credentials:**
```
postgresql://postgres.project:password@db.project.supabase.co:5432/postgres
```

### 6. Verification Checklist

After setting environment variables:
- [ ] DATABASE_URL is complete with username, password, host, port, and database name
- [ ] JWT_SECRET is at least 32 characters long
- [ ] NODE_ENV is set to "production"
- [ ] PORT is set to 10000 (or leave empty for Render default)
- [ ] No extra spaces or quotes around values
- [ ] All variables are saved

### 7. How to Update Build and Start Commands

In Render Settings tab:

**Build Command:**
```
npm install && npx prisma generate
```

**Start Command:**
```
npm start
```

**OR if you want to use the advanced setup script:**

**Build Command:**
```
npm install && npx prisma generate  
```

**Start Command:**
```
npm run deploy
```

### 8. Testing Environment Variables

You can verify your environment variables are working by checking the Render logs:

1. Go to your service dashboard
2. Click on **"Logs"** tab
3. Look for any environment variable related errors

### 9. Troubleshooting Tips

**If deployment still fails:**
1. Double-check your Supabase connection string
2. Ensure your Supabase project is not paused
3. Try deploying with just `npm install && npx prisma generate` first
4. Set up database tables manually after successful deployment

**If you see "Environment variable not found" errors:**
1. Refresh the Render page
2. Wait a few minutes for variables to propagate
3. Try redeploying the service

### 10. Next Steps After Setup

1. Save all environment variables
2. Redeploy your service (it should trigger automatically)
3. Check deployment logs for success
4. Test your API endpoints
5. Verify database connection is working

---

## Quick Action Items:
1. **Go to Render Environment tab**
2. **Add all required environment variables**
3. **Update build/start commands if needed**
4. **Redeploy and check logs**