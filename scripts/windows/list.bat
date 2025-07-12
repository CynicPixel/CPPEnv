@echo off

REM List all saved solutions (Windows)
REM Usage: list.bat [solution_name]

chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

set "SOLUTION_NAME=%1"
set "SOLUTIONS_DIR=solutions"

if not "%SOLUTION_NAME%"=="" (
    REM Show specific solution details
    set "SOLUTION_PATH=%SOLUTIONS_DIR%\%SOLUTION_NAME%"
    
    if not exist "!SOLUTION_PATH!" (
        echo ❌ Error: Solution '%SOLUTION_NAME%' not found!
        echo 💡 Use: cp.bat list to see available solutions
        exit /b 1
    )
    
    echo 📋 Solution Details: %SOLUTION_NAME%
    echo ═══════════════════════════════════════
    echo 📁 Location: !SOLUTION_PATH!
    echo.
    
    if exist "!SOLUTION_PATH!\README.md" (
        echo 📄 Information:
        
        REM Parse and display README.md content nicely
        for /f "usebackq tokens=1* delims= " %%a in (`findstr /C:"**Description:**" "!SOLUTION_PATH!\README.md" 2^>nul`) do (
            set "DESC_LINE=%%b"
            if defined DESC_LINE (
                echo   📖 Description: !DESC_LINE!
            )
        )
        
        for /f "usebackq tokens=1* delims= " %%a in (`findstr /C:"**Saved:**" "!SOLUTION_PATH!\README.md" 2^>nul`) do (
            set "SAVE_LINE=%%b"
            if defined SAVE_LINE (
                echo   📅 Saved: !SAVE_LINE!
            )
        )
        
        echo   📂 Files:
        for %%f in ("!SOLUTION_PATH!\*") do (
            if /i not "%%~nxf"=="README.md" (
                echo     - %%~nxf
            )
        )
        echo.
    ) else (
        echo 📂 Files:
        for %%f in ("!SOLUTION_PATH!\*") do (
            echo   - %%~nxf
        )
        echo.
    )
    echo 💡 Run with: cp.bat run %SOLUTION_NAME%
    
) else (
    REM List all solutions
    if not exist "%SOLUTIONS_DIR%" (
        echo 📁 No solutions directory found
        echo 💡 Use: cp.bat save ^<name^> to create your first solution
        exit /b 0
    )
    
    echo 📋 Saved Solutions:
    echo ═══════════════════
    
    set "SOLUTION_COUNT=0"
    for /d %%i in ("%SOLUTIONS_DIR%\*") do (
        set /a SOLUTION_COUNT+=1
        echo 📁 %%~ni
        
        REM Show description if available
        if exist "%%i\README.md" (
            for /f "usebackq tokens=1* delims= " %%a in (`findstr /C:"**Description:**" "%%i\README.md" 2^>nul`) do (
                set "DESC_LINE=%%b"
                if defined DESC_LINE (
                    echo    !DESC_LINE!
                )
            )
        )
    )
    
    if !SOLUTION_COUNT! equ 0 (
        echo 📁 No solutions saved yet
        echo 💡 Use: cp.bat save ^<name^> to create your first solution
    ) else (
        echo.
        echo 💡 View details: cp.bat list ^<solution_name^>
        echo 💡 Run solution: cp.bat run ^<solution_name^>
    )
)
