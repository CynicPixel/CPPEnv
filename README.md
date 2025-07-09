# C++ Competitive Programming Lab

A streamlined setup for competitive programming in C++ with automatic I/O handling and solution archiving.

## 🚀 Quick Start

1. **Write your solution** in `code/code.cpp` (implement your complete solution)
2. **Add test cases** in `code/input.txt`
3. **Run and test** with `./cp.sh run`
4. **Save your solution** with `./cp.sh save problem_name`

## 📁 File Structure

```
CP/
├── cp.sh              # Unix convenience script
├── cp.bat             # Windows convenience script
├── code/
│   ├── code.cpp       # Your working solution (edit this!)
│   ├── input.txt      # Test case inputs
│   └── output.txt     # Program outputs
├── scripts/
│   ├── unix/          # Unix shell scripts
│   │   ├── run.sh, save.sh, setup.sh, list.sh, status.sh
│   └── windows/       # Windows batch scripts
│       └── run.bat, save.bat, setup.bat, list.bat, status.bat
└── solutions/         # Archived solutions
    ├── problem1/
    │   ├── code.cpp
    │   ├── README.md
    │   └── input.txt
    └── problem2/
        ├── code.cpp
        ├── README.md
        └── input.txt
```

## 🔧 Usage

### Convenience Commands (Recommended)
```bash
# Unix/macOS
./cp.sh run              # Test current solution
./cp.sh run binary_search # Test saved solution
./cp.sh save two_sum     # Save current solution
./cp.sh setup new_problem # Reset workspace
./cp.sh list             # List all solutions
./cp.sh status           # Show workspace status
./cp.sh help             # Show all commands

# Windows (Command Prompt or PowerShell)
cp.bat run               # Test current solution
cp.bat run binary_search # Test saved solution  
cp.bat save two_sum      # Save current solution
cp.bat setup new_problem # Reset workspace
cp.bat list              # List all solutions
cp.bat status            # Show workspace status
cp.bat help              # Show all commands
```

### Direct Script Access
```bash
# Unix/macOS
./scripts/unix/run.sh
./scripts/unix/save.sh problem_name
./scripts/unix/setup.sh

# Windows
scripts\windows\run.bat
scripts\windows\save.bat problem_name
```

### Writing Solutions
```bash
# Your complete solution goes in code/code.cpp
# No freopen() or file handling needed - pure standard I/O
```

### Testing Solutions
```bash
# Test your current solution
./cp.sh run

# Test a saved solution by name
./cp.sh run binary_search_implementation
./cp.sh run two_sum
```

### Managing Solutions
```bash
# Save current solution
./cp.sh save two_sum "Find two numbers that add up to target"

# List all saved solutions
./cp.sh list

# View specific solution details
./cp.sh list two_sum

# Navigate to a solution
cd solutions/two_sum
```

### Starting Fresh
```bash
# Reset workspace for new problem
./cp.sh setup binary_search_problem
```

## 📝 Code Template

Your `code/code.cpp` uses pure competitive programming style - **no file I/O code needed**:

```cpp
#include <iostream>
#include <vector>
// ... your includes

using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    
    // Your solution uses standard I/O
    int n;
    cin >> n;  // Reads from input.txt automatically
    
    // Your algorithm here
    
    cout << result << endl;  // Writes to code/output.txt automatically
    
    return 0;
}
```

**Key Benefits:**
- ✅ Pure standard I/O (`cin`, `cout`, `printf`, `scanf`)
- ✅ No `freopen()` or file handling in your code
- ✅ Copy-paste ready for online judges
- ✅ Local testing with automatic file I/O redirection

## 🎯 Features

- **Pure CP code**: Write standard `cin`/`cout` without any file handling
- **Automatic I/O**: System handles file redirection transparently  
- **Judge-ready**: Copy your `code/code.cpp` directly to online judges
- **Fast compilation**: Optimized C++17 with useful flags
- **Solution archiving**: Save and organize solutions by problem name
- **README generation**: Auto-generated documentation templates
- **Clean workflow**: Focus entirely on algorithms

## 💡 Tips

1. **Use pure standard I/O** - `cin`, `cout`, `printf`, `scanf` only
2. **No file handling needed** - system redirects I/O automatically
3. **Copy-paste to judges** - your code works directly on Codeforces, etc.
4. **Test thoroughly** - use multiple test cases in `code/input.txt`
5. **Run saved solutions** - use `./cp.sh run solution_name` to test old solutions
6. **Document solutions** - update the README.md in saved solutions

## 🏆 Example Workflow

```bash
# 1. Start new problem
./cp.sh setup binary_search

# 2. Implement solution in code/code.cpp
# (Edit code/code.cpp with your complete solution)

# 3. Test with examples
echo -e "5\n1 2 3 4 5" > code/input.txt
./cp.sh run

# 4. Save when complete
./cp.sh save binary_search "Classic binary search implementation"

# 5. Test saved solution later
./cp.sh run binary_search

# 6. List all solutions
./cp.sh list

# 7. Study later
cd solutions/binary_search
cat README.md
```

Happy coding! 🚀
