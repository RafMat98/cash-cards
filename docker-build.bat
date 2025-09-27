@echo off
echo Building Docker image...
docker build -t cashcard-app .

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Build successful! 
    echo.
    echo To run the application:
    echo docker run -p 8080:8080 cashcard-app
    echo.
    echo To run in background:
    echo docker run -d -p 8080:8080 --name cashcard-container cashcard-app
    echo.
    echo To check logs:
    echo docker logs cashcard-container
) else (
    echo Build failed!
)