@echo off
REM C++ Competitive Programming Runner for Windows
REM Usage: run.bat [solution_name]

setlocal enabledelayedexpansion

set "SOLUTION_NAME=%*"
set "SOLUTIONS_DIR=solutions"

if not "%SOLUTION_NAME%"=="" (
    REM Running a saved solution
    set "SOLUTION_PATH=%SOLUTIONS_DIR%\%SOLUTION_NAME%"
    
    if not exist "!SOLUTION_PATH!" (
        echo ❌ Error: Solution '%SOLUTION_NAME%' not found!
        echo 💡 Available solutions:
        if exist "%SOLUTIONS_DIR%" (
            for /d %%i in ("%SOLUTIONS_DIR%\*") do echo   - %%~ni
        ) else (
            echo   No solutions saved yet
        )
        exit /b 1
    )
    
    echo 🔄 Running saved solution: %SOLUTION_NAME%
    echo 📁 Location: !SOLUTION_PATH!
    
    REM Copy saved solution files
    copy "!SOLUTION_PATH!\code.cpp" "temp_code.cpp" >nul
    if exist "!SOLUTION_PATH!\input.txt" (
        copy "!SOLUTION_PATH!\input.txt" "temp_input.txt" >nul
    ) else (
        echo 1 > temp_input.txt
    )
    
    echo 🚀 Compiling saved solution...
    g++ -std=c++17 -O2 -Wall -Wextra -g -o temp_solution.exe temp_code.cpp
    
    if !errorlevel! equ 0 (
        echo ✅ Compilation successful!
        echo 🏃 Running saved solution...
        
        temp_solution.exe < temp_input.txt > temp_output.txt
        
        if !errorlevel! equ 0 (
            echo ✅ Execution completed!
            echo 📋 Output:
            echo ----------------------------------------
            type temp_output.txt
            echo ----------------------------------------
        ) else (
            echo ❌ Runtime error occurred!
        )
    ) else (
        echo ❌ Compilation failed!
    )
    
    REM Cleanup
    del temp_code.cpp temp_input.txt temp_solution.exe temp_output.txt 2>nul
    
) else (
    REM Running current code
    echo 🚀 Compiling current code...
    
    REM Check if code/code.cpp exists and has main function
    if not exist "code\code.cpp" (
        echo ⚠️  Warning: code\code.cpp not found!
        echo 💡 Please create your solution in code\code.cpp first
        exit /b 1
    )
    
    findstr /C:"main(" code\code.cpp >nul
    if !errorlevel! neq 0 (
        echo ⚠️  Warning: code\code.cpp appears to be missing main() function
        echo 💡 Please implement your solution in code\code.cpp first
        exit /b 1
    )
    
    g++ -std=c++17 -O2 -Wall -Wextra -g -o code\solution.exe code\code.cpp
    
    if !errorlevel! equ 0 (
        echo ✅ Compilation successful!
        echo 🏃 Running current solution...
        
        code\solution.exe < code\input.txt > code\output.txt
        
        if !errorlevel! equ 0 (
            echo ✅ Execution completed!
            echo 📋 Output:
            echo ----------------------------------------
            type code\output.txt
            echo ----------------------------------------
        ) else (
            echo ❌ Runtime error occurred!
        )
    ) else (
        echo ❌ Compilation failed!
        exit /b 1
    )
)
