#!/bin/bash

# Save current solution to a named folder
# Usage: ./save.sh problem_name [optional description]

if [ $# -eq 0 ]; then
    echo "❌ Error: Please provide a problem name"
    echo "Usage: ./save.sh problem_name [optional description]"
    exit 1
fi

# Join all arguments except handle multi-word names and descriptions
PROBLEM_NAME="$1"
shift
DESCRIPTION="$*"
SOLUTIONS_DIR="solutions"
PROBLEM_DIR="$SOLUTIONS_DIR/$PROBLEM_NAME"

# Create solutions directory if it doesn't exist
mkdir -p "$SOLUTIONS_DIR"

# Check if problem directory already exists
if [ -d "$PROBLEM_DIR" ]; then
    echo "⚠️  Warning: Solution '$PROBLEM_NAME' already exists!"
    read -p "Do you want to overwrite it? (y/N): " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo "❌ Operation cancelled"
        exit 1
    fi
    rm -rf "$PROBLEM_DIR"
fi

# Create problem directory
mkdir -p "$PROBLEM_DIR"

# Copy current solution files
cp code/code.cpp "$PROBLEM_DIR/"
cp code/input.txt "$PROBLEM_DIR/"
if [ -f "code/output.txt" ]; then
    cp code/output.txt "$PROBLEM_DIR/"
fi

# Generate README template
cat > "$PROBLEM_DIR/README.md" << EOF
# $PROBLEM_NAME

## Problem Description
$DESCRIPTION

## Solution Approach
<!-- Describe your algorithm and approach here -->

## Key Insights
<!-- List the key insights that led to the solution -->

## Time Complexity
<!-- O(?) -->

## Space Complexity
<!-- O(?) -->

## Implementation Notes
<!-- Any important implementation details -->

## Test Cases
\`\`\`
$(cat code/input.txt)
\`\`\`

## Expected Output
\`\`\`
$(if [ -f "code/output.txt" ]; then cat code/output.txt; else echo "Run the solution to generate output"; fi)
\`\`\`

## Date Solved
$(date "+%Y-%m-%d %H:%M:%S")

## Tags
<!-- Add relevant tags: dp, greedy, graph, etc. -->
EOF

echo "✅ Solution '$PROBLEM_NAME' saved successfully!"
echo "📁 Location: $PROBLEM_DIR"
echo "📝 Don't forget to update the README.md with your solution details!"

# List all saved solutions
echo ""
echo "📚 All saved solutions:"
ls -la "$SOLUTIONS_DIR" | grep "^d" | awk '{print "  - " $9}' | grep -v "^\s*-\s*\.$" | grep -v "^\s*-\s*\.\.$"
