#!/bin/bash

# Quick status check for competitive programming workspace
# Shows current problem state and recent solutions

echo "🏆 CP Lab Status"
echo "══════════════════"

# Check if we have a current problem
if [ -f "code/code.cpp" ] && [ -f "code/input.txt" ]; then
    echo "📝 Current Problem:"
    
    # Check if code.cpp has been modified from template
    if grep -q "Your algorithm implementation here" code/code.cpp; then
        echo "  Status: 🔧 Template (not started)"
    else
        echo "  Status: 💻 In Progress"
        
        # Show brief preview of the solution
        echo "  Code preview:"
        head -n 3 code/code.cpp | sed 's/^/    /'
    fi
    
    # Show input preview
    echo "  Input:"
    head -n 2 code/input.txt | sed 's/^/    /'
    
    # Check if solution has been run recently
    if [ -f "code/output.txt" ] && [ -s "code/output.txt" ]; then
        echo "  Last output:"
        head -n 1 code/output.txt | sed 's/^/    /'
    else
        echo "  💡 Run ./cp.sh run to test"
    fi
    
    echo ""
fi

# Show recent solutions
echo "📚 Recent Solutions:"
if [ -d "solutions" ]; then
    # Show last 3 solutions by modification time
    ls -lt solutions/ | head -n 4 | tail -n +2 | while read -r line; do
        solution_name=$(echo "$line" | awk '{print $NF}')
        echo "  📁 $solution_name"
    done
else
    echo "  No solutions saved yet"
fi

echo ""
echo "🚀 Quick Commands:"
echo "  ./cp.sh run           - Test current solution"
echo "  ./cp.sh save name     - Save current solution"
echo "  ./cp.sh list          - View all solutions"
echo "  ./cp.sh setup name    - Start new problem"
