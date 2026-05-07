@echo off
REM CloudCompare AI - Interactive GitHub Push with Credentials
REM This script guides you through entering your GitHub credentials

setlocal enabledelayedexpansion

echo.
echo ==========================================
echo CloudCompare AI - GitHub Push
echo ==========================================
echo.
echo This script will push your project to GitHub.
echo You will need your GitHub Personal Access Token.
echo.
echo IMPORTANT: You need a PERSONAL ACCESS TOKEN, not your password!
echo Get one here: https://github.com/settings/tokens
echo.

:GetToken
set /p GITHUB_TOKEN="Enter your GitHub Personal Access Token: "

if "!GITHUB_TOKEN!"=="" (
    echo Error: Token cannot be empty
    goto GetToken
)

echo.
echo ==========================================
echo Starting GitHub Push...
echo ==========================================
echo.

cd /d "c:\Users\goder\OneDrive\Desktop - Copy\CloudCampare-Ai-main"

REM Use the token in the URL for authentication
git push https://Godesivaramakrishna:!GITHUB_TOKEN!@github.com/Godesivaramakrishna/Cloud-Compare-AI.git main

if errorlevel 1 (
    echo.
    echo ==========================================
    echo ERROR: Push failed
    echo ==========================================
    echo.
    echo Possible causes:
    echo 1. Invalid or expired Personal Access Token
    echo 2. Token does not have 'repo' scope
    echo 3. Repository does not exist at GitHub
    echo 4. Branch 'main' does not exist locally
    echo.
    echo To fix:
    echo 1. Create/regenerate token at: https://github.com/settings/tokens
    echo 2. Ensure token has 'repo' scope selected
    echo 3. Make sure repository exists: https://github.com/Godesivaramakrishna/Cloud-Compare-AI
    echo.
    pause
    exit /b 1
) else (
    echo.
    echo ==========================================
    echo SUCCESS! Project pushed to GitHub
    echo ==========================================
    echo.
    echo Your repository is now live!
    echo View it at: https://github.com/Godesivaramakrishna/Cloud-Compare-AI
    echo.
    echo Next steps:
    echo 1. Visit your GitHub repository
    echo 2. Verify all files are there
    echo 3. Check the README renders properly
    echo 4. Enable Issues, Discussions, etc.
    echo.
    pause
    exit /b 0
)
