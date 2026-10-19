@echo off
setlocal
cd /d "%~dp0"
title Insightly Setup and Server
if not exist ".env" (
  copy ".env.example" ".env" >nul
  echo Created your local .env configuration file.
) else (
  echo Existing .env file found. It will not be overwritten.
)
echo.
echo STEP 1: In Notepad, paste your existing working Gemini API key on the GEMINI_API_KEY line.
echo Keep the key private. Do not send it to anyone or upload the .env file.
echo Save the file and close Notepad to continue.
echo.
notepad ".env"
echo.
echo STEP 2: Installing dependencies. This may take a few minutes.
call npm install
if errorlevel 1 (
  echo.
  echo npm install failed. Copy the error text and ask for help; do not share your API key.
  pause
  exit /b 1
)
echo.
echo STEP 3: Starting Insightly. Keep this window open while using the website.
call npm start
pause
