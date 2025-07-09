@echo off
REM List and manage saved solutions (Windows)
REM Usage: list.bat [solution_name]

setlocal enabledelayedexpansion

set "SOLUTIONS_DIR=solutions"

echo 📚 Competitive Programming Solutions
echo ═══════════════════════════════════

if not exist "%SOLUTIONS_DIR%" (
    echo 📂 No solutions directory found.
    echo 💡 Save your first solution with: save.bat "problem_name"
    exit /b 0
)

if "%~1"=="" (
    REM List all solutions
    echo Saved solutions:
    for /d %%i in ("%SOLUTIONS_DIR%\*") do (
        echo   📁 %%~ni
        
        REM Show brief description if available
        if exist "%%i\README.md" (
            for /f "skip=3 delims=" %%j in (%%i\README.md) do (
                if not "%%j"=="" (
                    echo      └─ %%j
                    goto :next
                )
            )
            :next
        )
    )
    echo.
    echo 💡 Use: cp.bat list solution_name for details
) else (
    REM Show specific solution
    set "solution_name=%~1"
    set "solution_path=%SOLUTIONS_DIR%\!solution_name!"
    
    if not exist "!solution_path!" (
        echo ❌ Solution '!solution_name!' not found!
        exit /b 1
    )
    
    echo 📁 Solution: !solution_name!
    echo 📍 Path: !solution_path!
    echo.
    
    if exist "!solution_path!\README.md" (
        echo 📋 README Preview:
        for /f "delims=" %%i in ('more +0 "!solution_path!\README.md" ^| head -n 10') do echo %%i
        echo ...
    )
    
    echo.
    echo 📄 Files:
    dir "!solution_path!" /b
)
