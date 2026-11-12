@echo off

echo ==========================
echo Starting Jenkins Build
echo ==========================

echo.
echo Checking required project files...

if not exist "index.html" (
    echo ERROR: index.html is missing!
    exit /b 1
)

if not exist "README.md" (
    echo ERROR: README.md is missing!
    exit /b 1
)

echo.
echo All required files are present.

echo.
echo Reading README...
type README.md

echo.
echo Build completed successfully!

exit /b 0
