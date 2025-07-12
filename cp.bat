@echo off

REM CP Lab - Single Entry Point Script (Windows)
REM Usage: cp.bat {run|save|setup|list|status} [args]

chcp 65001 >nul 2>&1
setlocal enabledelayedexpansion

if "%1"=="run" (
    call scripts\windows\run.bat %2 %3 %4 %5 %6 %7 %8 %9
) else if "%1"=="save" (
    call scripts\windows\save.bat %2 %3 %4 %5 %6 %7 %8 %9
) else if "%1"=="setup" (
    call scripts\windows\setup.bat %2 %3 %4 %5 %6 %7 %8 %9
) else if "%1"=="list" (
    call scripts\windows\list.bat %2 %3 %4 %5 %6 %7 %8 %9
) else if "%1"=="status" (
    call scripts\windows\status.bat %2 %3 %4 %5 %6 %7 %8 %9
) else if "%1"=="help" (
    goto :help
) else if "%1"=="--help" (
    goto :help
) else if "%1"=="-h" (
    goto :help
) else if "%1"=="" (
    goto :help
) else (
    echo ❌ Error: Unknown command '%1'
    echo 💡 Use: cp.bat help for usage information
    echo.
    echo Available commands: run, save, setup, list, status, help
    exit /b 1
)

goto :eof

:help
echo 🏆 CP Lab - Competitive Programming Environment
echo ═══════════════════════════════════════════════
echo.
echo Usage: cp.bat ^<command^> [arguments]
echo.
echo Commands:
echo   run [solution_name] - Compile and run code (current or saved)
echo   save ^<name^> [desc]  - Save current solution with name
echo   setup [problem_name] - Reset workspace for new problem
echo   list [solution_name] - List all solutions or view specific one
echo   status              - Show current workspace status
echo   help                - Show this help message
echo.
echo Examples:
echo   cp.bat run                    # Run current solution
echo   cp.bat run binary_search      # Run saved solution
echo   cp.bat save two_sum "Two sum problem"  # Save current solution
echo   cp.bat setup binary_search    # Start new problem
echo   cp.bat list                   # List all solutions
echo   cp.bat status                 # Show workspace status
echo.
goto :eof
