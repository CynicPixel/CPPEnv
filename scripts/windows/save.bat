@echo off
REM Save current solution to a named folder (Windows)
REM Usage: save.bat problem_name [optional description]

setlocal enabledelayedexpansion

if "%~1"=="" (
    echo ❌ Error: Please provide a problem name
    echo Usage: save.bat problem_name [optional description]
    exit /b 1
)

set "PROBLEM_NAME=%~1"
set "DESCRIPTION=%*"
set "DESCRIPTION=!DESCRIPTION:%~1 =!"
set "SOLUTIONS_DIR=solutions"
set "PROBLEM_DIR=%SOLUTIONS_DIR%\%PROBLEM_NAME%"

REM Create solutions directory if it doesn't exist
if not exist "%SOLUTIONS_DIR%" mkdir "%SOLUTIONS_DIR%"

REM Check if problem directory already exists
if exist "%PROBLEM_DIR%" (
    echo ⚠️  Warning: Solution '%PROBLEM_NAME%' already exists!
    set /p "REPLY=Do you want to overwrite it? (y/N): "
    if /i not "!REPLY!"=="y" (
        echo ❌ Operation cancelled
        exit /b 1
    )
    rmdir /s /q "%PROBLEM_DIR%"
)

REM Create problem directory
mkdir "%PROBLEM_DIR%"

REM Copy current solution files
copy code\code.cpp "%PROBLEM_DIR%\" >nul
copy code\input.txt "%PROBLEM_DIR%\" >nul
if exist code\output.txt copy code\output.txt "%PROBLEM_DIR%\" >nul

REM Generate README template
(
echo # %PROBLEM_NAME%
echo.
echo ## Problem Description
echo !DESCRIPTION!
echo.
echo ## Solution Approach
echo ^<!-- Describe your algorithm and approach here --^>
echo.
echo ## Key Insights
echo ^<!-- List the key insights that led to the solution --^>
echo.
echo ## Time Complexity
echo ^<!-- O(?) --^>
echo.
echo ## Space Complexity
echo ^<!-- O(?) --^>
echo.
echo ## Implementation Notes
echo ^<!-- Any important implementation details --^>
echo.
echo ## Test Cases
echo ```
type input.txt
echo ```
echo.
echo ## Expected Output
echo ```
if exist output.txt (
    type output.txt
) else (
    echo Run the solution to generate output
)
echo ```
echo.
echo ## Date Solved
echo %date% %time%
echo.
echo ## Tags
echo ^<!-- Add relevant tags: dp, greedy, graph, etc. --^>
) > "%PROBLEM_DIR%\README.md"

echo ✅ Solution '%PROBLEM_NAME%' saved successfully!
echo 📁 Location: %PROBLEM_DIR%
echo 📝 Don't forget to update the README.md with your solution details!

echo.
echo 📚 All saved solutions:
for /d %%i in ("%SOLUTIONS_DIR%\*") do echo   - %%~ni
