@echo off
REM Quick status check for competitive programming workspace (Windows)
REM Shows current problem state and recent solutions

setlocal enabledelayedexpansion

echo 🏆 CP Lab Status
echo ══════════════════

REM Check if we have a current problem
if exist "code\code.cpp" if exist "code\input.txt" (
    echo 📝 Current Problem:
    
    REM Check if code\code.cpp has been modified from template
    findstr /C:"Your solution here" code\code.cpp >nul 2>&1
    if !errorlevel! equ 0 (
        echo   Status: 🔧 Template ^(not started^)
    ) else (
        echo   Status: 💻 In Progress
        
        REM Show brief preview of the solution
        echo   Code preview:
        set /a count=0
        for /f "delims=" %%i in (code\code.cpp) do (
            if !count! lss 3 (
                echo     %%i
                set /a count+=1
            )
        )
    )
    
    REM Show input preview
    echo   Input:
    set /a count=0
    for /f "delims=" %%i in (code\input.txt) do (
        if !count! lss 2 (
            echo     %%i
            set /a count+=1
        )
    )
    
    REM Check if solution has been run recently
    if exist "code\output.txt" (
        for %%i in (code\output.txt) do if %%~zi gtr 0 (
            echo   Last output:
            set /a count=0
            for /f "delims=" %%j in (code\output.txt) do (
                if !count! lss 1 (
                    echo     %%j
                    set /a count+=1
                )
            )
        )
    ) else (
        echo   💡 Run cp.bat run to test
    )
    
    echo.
)

REM Show recent solutions
echo 📚 Recent Solutions:
if exist "solutions" (
    REM Show last 3 solutions by modification time
    for /f "delims=" %%i in ('dir solutions /b /ad /od') do (
        echo   📁 %%i
    )
) else (
    echo   No solutions saved yet
)

echo.
echo 🚀 Quick Commands:
echo   cp.bat run           - Test current solution
echo   cp.bat save name     - Save current solution
echo   cp.bat list          - View all solutions
echo   cp.bat setup name    - Start new problem
