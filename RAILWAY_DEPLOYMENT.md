# Railway Deployment Guide

## Backend Configuration

### Environment Variables to set in Railway:

```env
# Database (auto-injected by Railway MySQL plugin)
MYSQLHOST=<provided by Railway>
MYSQLPORT=<provided by Railway>
MYSQLUSER=<provided by Railway>
MYSQLPASSWORD=<provided by Railway>
MYSQLDATABASE=railway

# Or use individual variables:
DB_HOST=<your-mysql-host>
DB_PORT=3306
DB_USER=<your-mysql-user>
DB_PASSWORD=<your-mysql-password>
DB_NAME=railway

# Server
PORT=5000
NODE_ENV=production

# JWT
JWT_SECRET=<generate-a-strong-secret>
JWT_EXPIRE=7d

# CORS - IMPORTANT!
CORS_ORIGIN=https://saintpaul.up.railway.app

# OpenAI (if using chatbot)
OPENAI_API_KEY=<your-openai-key>
```

## Frontend Configuration

### Environment Variables to set in Railway:

```env
VITE_API_URL=https://osp-backend-production.up.railway.app/api
VITE_API_TIMEOUT=30000
```

## Deployment Steps

1. **Backend:**
   - Connect Railway to GitHub repo
   - Set all environment variables above
   - Railway will auto-detect Node.js and run `npm start`
   - Verify CORS_ORIGIN includes frontend URL

2. **Frontend:**
   - Connect Railway to GitHub repo (or use separate service)
   - Set VITE_API_URL to backend URL
   - Railway will auto-detect Vite and run build command
   - Verify frontend can access backend API

3. **Test:**
   - Open `https://saintpaul.up.railway.app`
   - Check browser console for CORS errors
   - Test login and API calls
