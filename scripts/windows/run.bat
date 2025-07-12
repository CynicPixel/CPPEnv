@echo off

REM C++ Competitive Programming Runner (Windows)
REM Usage: run.bat [solution_name]
REM If solution_name is provided, runs that saved solution
REM Otherwise, runs the current code.cpp

chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

set "SOLUTION_NAME=%*"
set "SOLUTIONS_DIR=solutions"

REM Initialize compiler environment
call :init_compiler
if !errorlevel! neq 0 exit /b 1

if not "%SOLUTION_NAME%"=="" (
    REM Running a saved solution
    set "SOLUTION_PATH=%SOLUTIONS_DIR%\%SOLUTION_NAME%"
    
    if not exist "!SOLUTION_PATH!" (
        echo ❌ Error: Solution '%SOLUTION_NAME%' not found!
        echo 💡 Available solutions:
        if exist "%SOLUTIONS_DIR%" (
            for /d %%i in ("%SOLUTIONS_DIR%\*") do echo  - %%~ni
        ) else (
            echo  No solutions saved yet
        )
        exit /b 1
    )
    
    echo 🔄 Running saved solution: %SOLUTION_NAME%
    echo 📁 Location: !SOLUTION_PATH!
    
    REM Temporarily copy saved solution files
    copy "!SOLUTION_PATH!\code.cpp" "temp_code.cpp" >nul
    if exist "!SOLUTION_PATH!\input.txt" (
        copy "!SOLUTION_PATH!\input.txt" "temp_input.txt" >nul
    ) else (
        echo 1 > "temp_input.txt"
    )
    
    echo 🚀 Compiling saved solution...
    
    if "%COMPILER%"=="cl" (
        cl /std:c++17 /O2 /EHsc /Fe:temp_solution.exe temp_code.cpp 2>&1
        set "COMPILE_RESULT=!errorlevel!"
    ) else (
        g++ -std=c++17 -O2 -Wall -Wextra -g -o temp_solution.exe temp_code.cpp 2>&1
        set "COMPILE_RESULT=!errorlevel!"
    )
    
    if !COMPILE_RESULT! equ 0 (
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
        echo ❌ Compilation failed with exit code !COMPILE_RESULT!
        echo 💡 Please check the error messages above and fix your code
    )
    
    REM Cleanup temp files
    if exist temp_code.cpp del temp_code.cpp
    if exist temp_input.txt del temp_input.txt
    if exist temp_solution.exe del temp_solution.exe
    if exist temp_output.txt del temp_output.txt
    
) else (
    REM Running current code
    echo 🚀 Compiling current code...
    
    if not exist "code\code.cpp" (
        echo ⚠️ Warning: code\code.cpp not found
        echo 💡 Please implement your solution in code\code.cpp first
        exit /b 1
    )
    
    REM Check if file has actual implementation
    findstr /C:"main(" code\code.cpp >nul 2>&1
    if !errorlevel! neq 0 (
        echo ⚠️ Warning: code\code.cpp appears to be missing main^(^) function
        echo 💡 Please implement your solution in code\code.cpp first
        exit /b 1
    )
    
    REM Check if file is empty
    for %%A in (code\code.cpp) do if %%~zA lss 50 (
        echo ⚠️ Warning: code\code.cpp appears to be empty or too small
        echo 💡 Please implement your solution in code\code.cpp first
        exit /b 1
    )
    
    if "%COMPILER%"=="cl" (
        cl /std:c++17 /O2 /EHsc /Fe:code\solution.exe code\code.cpp 2>&1
        set "COMPILE_RESULT=!errorlevel!"
    ) else (
        g++ -std=c++17 -O2 -Wall -Wextra -g -o code\solution.exe code\code.cpp 2>&1
        set "COMPILE_RESULT=!errorlevel!"
    )
    
    if !COMPILE_RESULT! equ 0 (
        echo ✅ Compilation successful!
        echo 🏃 Running current solution...
        
        cd code
        solution.exe < input.txt > output.txt
        cd ..
        
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
        echo ❌ Compilation failed with exit code !COMPILE_RESULT!
        echo 💡 Please check the error messages above and fix your code
        exit /b !COMPILE_RESULT!
    )
)

goto :eof

:init_compiler
REM Check for g++ first (preferred)
where g++ >nul 2>&1
if !errorlevel! equ 0 (
    echo "🔧 Using g++ compiler"
    set "COMPILER=g++"
    exit /b 0
)

REM Check if MSVC is already available
where cl >nul 2>&1
if !errorlevel! equ 0 (
    echo "🔧 Using MSVC compiler (already activated)"
    set "COMPILER=cl"
    exit /b 0
)

REM Auto-discover and activate MSVC
echo "🔍 Discovering MSVC installation..."

REM Common Visual Studio installation paths
set "VS_PATHS="
set "VS_PATHS=!VS_PATHS! "%ProgramFiles%\Microsoft Visual Studio\2022\Community""
set "VS_PATHS=!VS_PATHS! "%ProgramFiles%\Microsoft Visual Studio\2022\Professional""
set "VS_PATHS=!VS_PATHS! "%ProgramFiles%\Microsoft Visual Studio\2022\Enterprise""
set "VS_PATHS=!VS_PATHS! "%ProgramFiles%\Microsoft Visual Studio\2019\Community""
set "VS_PATHS=!VS_PATHS! "%ProgramFiles%\Microsoft Visual Studio\2019\Professional""
set "VS_PATHS=!VS_PATHS! "%ProgramFiles%\Microsoft Visual Studio\2019\Enterprise""
set "VS_PATHS=!VS_PATHS! "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Community""
set "VS_PATHS=!VS_PATHS! "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Professional""
set "VS_PATHS=!VS_PATHS! "%ProgramFiles(x86)%\Microsoft Visual Studio\2019\Enterprise""

for %%p in (!VS_PATHS!) do (
    set "VCVARS_PATH=%%~p\VC\Auxiliary\Build\vcvars64.bat"
    if exist "!VCVARS_PATH!" (
        echo "🔧 Found Visual Studio at %%~p"
        echo "🚀 Activating MSVC environment..."
        call "!VCVARS_PATH!" >nul 2>&1
        
        REM Verify activation worked
        where cl >nul 2>&1
        if !errorlevel! equ 0 (
            echo "✅ MSVC compiler activated successfully"
            set "COMPILER=cl"
            exit /b 0
        )
    )
)

REM Try vswhere.exe for more robust discovery
where vswhere >nul 2>&1
if !errorlevel! equ 0 (
    echo "🔍 Using vswhere for Visual Studio discovery..."
    for /f "usebackq tokens=*" %%i in (`vswhere -latest -products * -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 -property installationPath`) do (
        set "VS_INSTALL_PATH=%%i"
        set "VCVARS_PATH=!VS_INSTALL_PATH!\VC\Auxiliary\Build\vcvars64.bat"
        if exist "!VCVARS_PATH!" (
            echo "🔧 Found Visual Studio at !VS_INSTALL_PATH!"
            echo "🚀 Activating MSVC environment..."
            call "!VCVARS_PATH!" >nul 2>&1
            
            where cl >nul 2>&1
            if !errorlevel! equ 0 (
                echo "✅ MSVC compiler activated successfully"
                set "COMPILER=cl"
                exit /b 0
            )
        )
    )
)

REM No compiler found
echo ❌ Error: No supported C++ compiler found or activated!
echo.
echo 💡 To fix this:
echo   • For MSVC: Run this script from "Developer Command Prompt"
echo   • Or install MinGW-w64 for g++ support
echo   • Or ensure Visual Studio Build Tools are properly installed
echo.
echo 🔗 Download links:
echo   MinGW-w64: https://www.mingw-w64.org/downloads/
echo   VS Build Tools: https://visualstudio.microsoft.com/downloads/
exit /b 1
