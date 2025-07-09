#!/bin/bash

# List and manage saved solutions
# Usage: ./list.sh [solution_name]

SOLUTIONS_DIR="solutions"

echo "📚 Competitive Programming Solutions"
echo "═══════════════════════════════════"

if [ ! -d "$SOLUTIONS_DIR" ]; then
    echo "📂 No solutions directory found."
    echo "💡 Save your first solution with: ./save.sh \"problem_name\""
    exit 0
fi

if [ $# -eq 0 ]; then
    # List all solutions
    echo "Saved solutions:"
    for solution in "$SOLUTIONS_DIR"/*; do
        if [ -d "$solution" ]; then
            basename_solution=$(basename "$solution")
            echo "  📁 $basename_solution"
            
            # Show brief description if available
            if [ -f "$solution/README.md" ]; then
                desc=$(grep -A 1 "## Problem Description" "$solution/README.md" | tail -n 1)
                if [ ! -z "$desc" ] && [ "$desc" != "## Problem Description" ]; then
                    echo "     └─ $desc"
                fi
            fi
        fi
    done
    echo ""
    echo "💡 Use: ./cp.sh list solution_name for details"
else
    # Show specific solution
    solution_name=$1
    solution_path="$SOLUTIONS_DIR/$solution_name"
    
    if [ ! -d "$solution_path" ]; then
        echo "❌ Solution '$solution_name' not found!"
        exit 1
    fi
    
    echo "📁 Solution: $solution_name"
    echo "📍 Path: $solution_path"
    echo ""
    
    if [ -f "$solution_path/README.md" ]; then
        echo "📋 README Preview:"
        head -n 10 "$solution_path/README.md"
        echo "..."
    fi
    
    echo ""
    echo "📄 Files:"
    ls -la "$solution_path"
fi
