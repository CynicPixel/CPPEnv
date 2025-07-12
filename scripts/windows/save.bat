@echo off

REM Save current solution with a name (Windows)
REM Usage: save.bat <solution_name> [description]

chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

set "SOLUTION_NAME=%1"
set "DESCRIPTION=%~2"
if not "%~3"=="" set "DESCRIPTION=%DESCRIPTION% %~3"
if not "%~4"=="" set "DESCRIPTION=%DESCRIPTION% %~4"
if not "%~5"=="" set "DESCRIPTION=%DESCRIPTION% %~5"
if not "%~6"=="" set "DESCRIPTION=%DESCRIPTION% %~6"
if not "%~7"=="" set "DESCRIPTION=%DESCRIPTION% %~7"
if not "%~8"=="" set "DESCRIPTION=%DESCRIPTION% %~8"
if not "%~9"=="" set "DESCRIPTION=%DESCRIPTION% %~9"
set "SOLUTIONS_DIR=solutions"

if "%SOLUTION_NAME%"=="" (
    echo ❌ Error: Solution name is required!
    echo 💡 Usage: cp.bat save ^<solution_name^> [description]
    echo.
    echo Examples:
    echo   cp.bat save two_sum "Two sum problem"
    echo   cp.bat save binary_search
    exit /b 1
)

REM Check if current solution exists
if not exist "code\code.cpp" (
    echo ❌ Error: No current solution found!
    echo 💡 Please implement your solution in code\code.cpp first
    exit /b 1
)

REM Check if solution has content
for %%A in (code\code.cpp) do if %%~zA lss 10 (
    echo ❌ Error: code\code.cpp appears to be empty!
    echo 💡 Please implement your solution first
    exit /b 1
)

REM Create solutions directory if it doesn't exist
if not exist "%SOLUTIONS_DIR%" (
    mkdir "%SOLUTIONS_DIR%"
)

set "SOLUTION_PATH=%SOLUTIONS_DIR%\%SOLUTION_NAME%"

REM Check if solution already exists
if exist "%SOLUTION_PATH%" (
    echo ⚠️ Warning: Solution '%SOLUTION_NAME%' already exists!
    set /p "OVERWRITE=Do you want to overwrite it? (y/N): "
    if /i not "!OVERWRITE!"=="y" (
        echo ❌ Save cancelled
        exit /b 1
    )
    echo 🗑️ Removing existing solution...
    rmdir /s /q "%SOLUTION_PATH%"
)

REM Create solution directory
mkdir "%SOLUTION_PATH%"

REM Copy current solution files
echo 💾 Saving solution: %SOLUTION_NAME%
copy "code\code.cpp" "%SOLUTION_PATH%\code.cpp" >nul
if exist "code\input.txt" (
    copy "code\input.txt" "%SOLUTION_PATH%\input.txt" >nul
)
if exist "code\output.txt" (
    copy "code\output.txt" "%SOLUTION_PATH%\output.txt" >nul
)

REM Create metadata file
echo # Solution: %SOLUTION_NAME% > "%SOLUTION_PATH%\README.md"
echo. >> "%SOLUTION_PATH%\README.md"
if not "%DESCRIPTION%"=="" (
    echo **Description:** %DESCRIPTION% >> "%SOLUTION_PATH%\README.md"
    echo. >> "%SOLUTION_PATH%\README.md"
)
echo **Saved:** %date% %time% >> "%SOLUTION_PATH%\README.md"
echo. >> "%SOLUTION_PATH%\README.md"
echo **Files:** >> "%SOLUTION_PATH%\README.md"
echo - code.cpp >> "%SOLUTION_PATH%\README.md"
if exist "%SOLUTION_PATH%\input.txt" (
    echo - input.txt >> "%SOLUTION_PATH%\README.md"
)
if exist "%SOLUTION_PATH%\output.txt" (
    echo - output.txt >> "%SOLUTION_PATH%\README.md"
)

echo ✅ Solution saved successfully!
echo 📁 Location: %SOLUTION_PATH%
echo 💡 Run with: cp.bat run %SOLUTION_NAME%
