@echo off
REM Setup script for new competitive programming problems (Windows)
REM Usage: setup.bat [problem_name]

set "PROBLEM_NAME=%*"

echo 🛠️  Setting up new competitive programming problem...

REM Clear or create fresh files
echo 🧹 Cleaning workspace...

REM Reset code/code.cpp with blank template
(
echo #include ^<iostream^>
echo using namespace std;
echo.
echo int main^(^) {
echo     ios_base::sync_with_stdio^(false^);
echo     cin.tie^(NULL^);
echo.
echo     // Your solution here
echo.
echo     return 0;
echo }
) > code\code.cpp

REM Clear code/input.txt
echo 1 > code\input.txt

REM Clear code/output.txt if it exists
if exist code\output.txt del code\output.txt

echo ✅ Workspace reset!
echo 📝 Edit code\code.cpp to implement your solution
echo 📝 Edit code\input.txt to add your test cases
echo 🏃 Run cp.bat run to test your solution

if not "%PROBLEM_NAME%"=="" (
    echo 💡 When done, save with: cp.bat save %PROBLEM_NAME%
)
