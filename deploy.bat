@echo off
echo Starting Vercel deployment...
cd /d "%~dp0"

node -v >nul 2>&1
if errorlevel 1 (
  echo ERROR: Node.js not found. Please install from https://nodejs.org
  pause
  exit /b 1
)

vercel -v >nul 2>&1
if errorlevel 1 (
  echo Installing Vercel CLI...
  npm install -g vercel
)

echo Pushing to GitHub...
git add -A
git commit -m "deploy update" >nul 2>&1
git push origin master

echo Logging in to Vercel...
vercel whoami >nul 2>&1 || vercel login

echo Deploying...
vercel --prod --yes

pause
