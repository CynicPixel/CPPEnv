#!/bin/bash

# C++ Competitive Programming Runner
# Usage: ./run.sh [solution_name]
# If solution_name is provided, runs that saved solution
# Otherwise, runs the current code.cpp

SOLUTION_NAME="$*"
SOLUTIONS_DIR="solutions"

if [ ! -z "$SOLUTION_NAME" ]; then
    # Running a saved solution
    SOLUTION_PATH="$SOLUTIONS_DIR/$SOLUTION_NAME"
    
    if [ ! -d "$SOLUTION_PATH" ]; then
        echo "❌ Error: Solution '$SOLUTION_NAME' not found!"
        echo "💡 Available solutions:"
        if [ -d "$SOLUTIONS_DIR" ]; then
            ls -1 "$SOLUTIONS_DIR" | sed 's/^/  - /'
        else
            echo "  No solutions saved yet"
        fi
        exit 1
    fi
    
    echo "🔄 Running saved solution: $SOLUTION_NAME"
    echo "📁 Location: $SOLUTION_PATH"
    
    # Temporarily copy saved solution files
    cp "$SOLUTION_PATH/code.cpp" "temp_code.cpp"
    if [ -f "$SOLUTION_PATH/input.txt" ]; then
        cp "$SOLUTION_PATH/input.txt" "temp_input.txt"
    else
        echo "1" > "temp_input.txt"
    fi
    
    # Create temporary main.cpp that uses temp files
    cat > temp_main.cpp << 'EOF'
// Temporary main for running saved solutions
#include "temp_code.cpp"
EOF
    
    echo "🚀 Compiling saved solution..."
    g++ -std=c++17 -O2 -Wall -Wextra -g -o temp_solution temp_code.cpp
    
    if [ $? -eq 0 ]; then
        echo "✅ Compilation successful!"
        echo "🏃 Running saved solution..."
        
        # Run the solution with I/O redirection
        ./temp_solution < temp_input.txt > temp_output.txt
        
        if [ $? -eq 0 ]; then
            echo "✅ Execution completed!"
            echo "📋 Output:"
            echo "----------------------------------------"
            cat temp_output.txt
            echo "----------------------------------------"
        else
            echo "❌ Runtime error occurred!"
        fi
    else
        echo "❌ Compilation failed!"
    fi
    
    # Cleanup temp files
    rm -f temp_code.cpp temp_input.txt temp_main.cpp temp_solution temp_output.txt
    
else
    # Running current code
    echo "🚀 Compiling current code..."
    
    # Check if code.cpp has actual implementation
    if [ ! -s "code/code.cpp" ] || ! grep -q "main()" code/code.cpp; then
        echo "⚠️  Warning: code/code.cpp appears to be empty or missing main() function"
        echo "💡 Please implement your solution in code/code.cpp first"
        exit 1
    fi
    
    # Compile with LOCAL flag for file I/O redirection during testing
    g++ -std=c++17 -O2 -Wall -Wextra -g -o code/solution code/code.cpp
    
    # Check if compilation was successful
    if [ $? -eq 0 ]; then
        echo "✅ Compilation successful!"
        echo "🏃 Running current solution..."
        
        # Run the solution with I/O redirection
        cd code && ./solution < input.txt > output.txt && cd ..
        
        if [ $? -eq 0 ]; then
            echo "✅ Execution completed!"
            echo "📋 Output:"
            echo "----------------------------------------"
            cat code/output.txt
            echo "----------------------------------------"
        else
            echo "❌ Runtime error occurred!"
        fi
    else
        echo "❌ Compilation failed!"
        exit 1
    fi
fi
