# Supabase Database Connection Troubleshooting Guide

## Error Analysis
Your deployment is failing with:
```
Error: P1001: Can't reach database server at `db.pgdefejeluwiyxljnfxf.supabase.co:5432`
```

## Step-by-Step Verification Process

### 1. Check Supabase Project Status
1. Go to [supabase.com](https://supabase.com)
2. Sign in to your account
3. Check your project dashboard
4. Verify project status is **ACTIVE** (green indicator)

### 2. Get Correct Connection String
1. In your Supabase project dashboard:
   - Click **Settings** (gear icon in sidebar)
   - Click **Database**
   - Scroll to **Connection string** section
   - Select **URI** tab
   - Copy the connection string

### 3. Expected Connection String Format
Your connection string should look like:
```
postgresql://postgres.[PROJECT-REF]:[YOUR-PASSWORD]@db.[PROJECT-REF].supabase.co:5432/postgres
```

**Example:**
```
postgresql://postgres.abcdefghijklmnop:mypassword123@db.abcdefghijklmnop.supabase.co:5432/postgres
```

### 4. Common Issues and Solutions

#### Issue A: Wrong Host Format
❌ **Wrong:** `db.pgdefejeluwiyxljnfxf.supabase.co`
✅ **Correct:** Should include full connection string with credentials

#### Issue B: Missing Password
- The connection string MUST include your database password
- If you forgot your password, you can reset it in Supabase Settings > Database

#### Issue C: Project Paused/Inactive
- Free Supabase projects pause after inactivity
- Check if your project needs to be resumed

#### Issue D: IP Restrictions
- Supabase might have IP restrictions
- Check Settings > Database > Connection pooling settings

### 5. Testing Connection String
You can test your connection string locally:

1. Create a test file `test-db-connection.js`:
```javascript
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient({
  datasources: {
    db: {
      url: 'YOUR_CONNECTION_STRING_HERE'
    }
  }
});

async function testConnection() {
  try {
    await prisma.$connect();
    console.log('✅ Database connection successful!');
    await prisma.$disconnect();
  } catch (error) {
    console.error('❌ Database connection failed:', error.message);
  }
}

testConnection();
```

### 6. What to Check in Your Setup
- [ ] Supabase project is active (not paused)
- [ ] Database password is set and correct
- [ ] Connection string includes full credentials
- [ ] No typos in the connection string
- [ ] Environment variable is set correctly in Render

### 7. Next Steps
Once you have the correct connection string:
1. Update your Render environment variables
2. Redeploy your application
3. Check if the database tables are created

---

## Quick Action Items:
1. **Copy your exact Supabase connection string**
2. **Verify it matches the expected format above**
3. **Update Render environment variables**
4. **Test the connection if possible**