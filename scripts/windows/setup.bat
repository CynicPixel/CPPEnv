@echo off

REM Setup workspace for new problem (Windows)
REM Usage: setup.bat [problem_name]

chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

set "PROBLEM_NAME=%1"
set "CODE_DIR=code"

if "%PROBLEM_NAME%"=="" (
    echo 🔄 Setting up workspace for new problem...
) else (
    echo 🔄 Setting up workspace for: %PROBLEM_NAME%
)

REM Create code directory if it doesn't exist
if not exist "%CODE_DIR%" (
    mkdir "%CODE_DIR%"
)

REM Check if there's existing work
if exist "%CODE_DIR%\code.cpp" (
    for %%A in (%CODE_DIR%\code.cpp) do if %%~zA gtr 50 (
        echo ⚠️ Warning: Existing code.cpp found with content!
        set /p "OVERWRITE=Do you want to overwrite it? (y/N): "
        if /i not "!OVERWRITE!"=="y" (
            echo ❌ Setup cancelled
            exit /b 1
        )
    )
)

REM Create template code.cpp
echo 🔧 Creating template code.cpp...
(
echo #include ^<iostream^>
echo #include ^<vector^>
echo #include ^<algorithm^>
echo #include ^<string^>
echo #include ^<map^>
echo #include ^<set^>
echo #include ^<queue^>
echo #include ^<stack^>
echo #include ^<cmath^>
echo #include ^<climits^>
echo.
echo using namespace std;
echo.
if not "%PROBLEM_NAME%"=="" (
    echo // Problem: %PROBLEM_NAME%
    echo.
)
echo int main^(^) {
echo.
echo     // Your solution here
echo.
echo     return 0;
echo }
) > "%CODE_DIR%\code.cpp"

REM Create sample input.txt
echo 🔧 Creating sample input.txt...
echo 1 > "%CODE_DIR%\input.txt"

REM Clean up any existing output
if exist "%CODE_DIR%\output.txt" (
    del "%CODE_DIR%\output.txt"
)
if exist "%CODE_DIR%\solution.exe" (
    del "%CODE_DIR%\solution.exe"
)

echo ✅ Workspace setup complete!
echo 📁 Files created:
echo   - %CODE_DIR%\code.cpp (template)
echo   - %CODE_DIR%\input.txt (sample input)
echo.
echo 💡 Next steps:
echo   1. Edit %CODE_DIR%\code.cpp with your solution
echo   2. Update %CODE_DIR%\input.txt with test data
echo   3. Run with: cp.bat run
