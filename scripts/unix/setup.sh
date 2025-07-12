#!/bin/bash

# Setup script for necho "✅ Workspace reset!"
echo "📝 Edit code/code.cpp to implement your solution"
echo "📝 Edit code/input.txt to add your test cases"
echo "🏃 Run ./cp.sh run to test your solution"

if [ -n "$PROBLEM_NAME" ]; then
    echo "💡 When done, save with: ./cp.sh save $PROBLEM_NAME"
fititive programming problems
# Usage: ./setup.sh [problem_name]

PROBLEM_NAME="$*"

echo "🛠️  Setting up new competitive programming problem..."

# Clear or create fresh files
echo "🧹 Cleaning workspace..."

# Reset code.cpp with blank template
cat > code/code.cpp << 'EOF'
#include <iostream>
using namespace std;

int main() {
    // Your solution here
    
    return 0;
}
EOF

# Clear input.txt
echo "1" > code/input.txt

# Clear output.txt if it exists
> code/output.txt

echo "✅ Workspace reset!"
echo "📝 Edit code/code.cpp to implement your solution"
echo "📝 Edit code/input.txt to add your test cases"
echo "🏃 Run scripts/unix/run.sh to test your solution"

if [ ! -z "$PROBLEM_NAME" ]; then
    echo "💡 When done, save with: scripts/unix/save.sh $PROBLEM_NAME"
fi
