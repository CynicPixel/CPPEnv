@echo off

REM Show current workspace status (Windows)
REM Usage: status.bat

chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

echo 📊 CP Lab Workspace Status
echo ═══════════════════════════════════════

REM Check current code status
echo.
echo 🔧 Current Code:
if exist "code\code.cpp" (
    for %%A in (code\code.cpp) do (
        echo   ✅ code.cpp exists (%%~zA bytes)
        
        REM Check if it has main function
        findstr /C:"main(" code\code.cpp >nul 2>&1
        if !errorlevel! equ 0 (
            echo   ✅ Contains main^(^) function
        ) else (
            echo   ⚠️ Missing main^(^) function
        )
        
        REM Check for common includes
        findstr /C:"#include" code\code.cpp >nul 2>&1
        if !errorlevel! equ 0 (
            echo   ✅ Has include statements
        )
    )
) else (
    echo   ❌ code.cpp not found
    echo   💡 Use: cp.bat setup to create template
)

REM Check input file
echo.
echo 📥 Input:
if exist "code\input.txt" (
    for %%A in (code\input.txt) do (
        echo   ✅ input.txt exists (%%~zA bytes)
        if %%~zA gtr 0 (
            echo   📄 First line: 
            for /f "delims=" %%i in (code\input.txt) do (
                echo      %%i
                goto :first_line_done
            )
            :first_line_done
        )
    )
) else (
    echo   ❌ input.txt not found
    echo   💡 Create input.txt with test data
)

REM Check output file
echo.
echo 📤 Output:
if exist "code\output.txt" (
    for %%A in (code\output.txt) do (
        echo   ✅ output.txt exists (%%~zA bytes)
        if %%~zA gtr 0 (
            echo   📄 Last run output available
        ) else (
            echo   ⚠️ output.txt is empty
        )
    )
) else (
    echo   ❌ No output.txt (not run yet)
    echo   💡 Use: cp.bat run to execute code
)

REM Check compiled executable
echo.
echo ⚙️ Compilation:
if exist "code\solution.exe" (
    echo   ✅ solution.exe exists (compiled)
) else (
    echo   ❌ No compiled executable
    echo   💡 Use: cp.bat run to compile and run
)

REM Check saved solutions
echo.
echo 💾 Saved Solutions:
if exist "solutions" (
    set "SOLUTION_COUNT=0"
    for /d %%i in ("solutions\*") do (
        set /a SOLUTION_COUNT+=1
    )
    
    if !SOLUTION_COUNT! gtr 0 (
        echo   ✅ !SOLUTION_COUNT! solution(s) saved
        echo   📁 Recent solutions:
        for /f "tokens=*" %%i in ('dir "solutions" /b /ad /o-d 2^>nul') do (
            echo      - %%i
        )
    ) else (
        echo   📁 Solutions directory exists but empty
    )
) else (
    echo   ❌ No solutions saved yet
    echo   💡 Use: cp.bat save ^<name^> to save current solution
)

REM Check compiler availability
echo.
echo 🔧 Compiler Status:
where g++ >nul 2>&1
if !errorlevel! equ 0 (
    echo   ✅ g++ compiler available
    for /f "tokens=*" %%i in ('g++ --version 2^>nul ^| findstr /C:"g++"') do (
        echo      %%i
    )
) else (
    where cl >nul 2>&1
    if !errorlevel! equ 0 (
        echo   ✅ MSVC compiler available
        for /f "tokens=*" %%i in ('cl 2^>^&1 ^| findstr /C:"Version"') do (
            echo      %%i
        )
    ) else (
        echo   ❌ No compiler found
        echo   💡 Install MinGW-w64 or use Developer Command Prompt
    )
)

echo.
echo 💡 Quick Actions:
echo   cp.bat setup     - Reset workspace for new problem
echo   cp.bat run       - Compile and run current solution
echo   cp.bat save ^<name^> - Save current solution
echo   cp.bat list      - Show saved solutions
