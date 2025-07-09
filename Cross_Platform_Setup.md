# Cross-Platform Setup Guide

## 📋 Platform Requirements

### **Windows**
```bash
# Install MinGW-w64 or use Visual Studio
# Option 1: Install via MSYS2
winget install MSYS2.MSYS2

# Option 2: Install via Chocolatey
choco install mingw

# Option 3: Use Visual Studio Build Tools
# Download from: https://visualstudio.microsoft.com/downloads/
```

### **macOS**
```bash
# Install Xcode Command Line Tools
xcode-select --install

# Or install via Homebrew
brew install gcc
```

### **Linux**
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install build-essential

# CentOS/RHEL/Fedora
sudo yum groupinstall "Development Tools"  # or dnf
```

## 🚀 **Usage by Platform**

### **Windows**
```cmd
REM Use .bat files
run.bat                          # Test current solution
run.bat binary_search           # Test saved solution
save.bat problem_name description
setup.bat
list.bat
status.bat                       # Check workspace status
```

### **Unix/Linux/macOS**
```bash
# Use .sh files
./run.sh                        # Test current solution
./run.sh binary_search          # Test saved solution
./save.sh problem_name description
./setup.sh
./list.sh
./status.sh                     # Check workspace status
```

## 🔧 **File Structure (Cross-Platform)**

```
CP/
├── code.cpp                    # Your solution (universal)
├── input.txt                   # Test input (universal)
├── output.txt                  # Program output (universal)
├── README.md                   # Documentation (universal)
├── .gitignore                  # Git ignore file (universal)
├── CROSS_PLATFORM_SETUP.md    # This file (universal)
│
├── Unix/Linux/macOS Scripts:
├── run.sh                      # Bash version
├── save.sh                     # Bash version
├── setup.sh                    # Bash version
├── list.sh                     # Bash version
├── status.sh                   # Bash version
└── main.cpp                    # Legacy (not used)
│
├── Windows Scripts:
├── run.bat                     # Windows batch version
├── save.bat                    # Windows batch version
├── setup.bat                   # Windows batch version
├── list.bat                    # Windows batch version
└── status.bat                  # Windows batch version
│
└── solutions/                  # Cross-platform archive
    ├── problem1/
    │   ├── code.cpp
    │   ├── README.md
    │   └── input.txt
    └── problem2/
        ├── code.cpp
        ├── README.md
        └── input.txt
```

## ✅ **Git Repository Compatibility**

### **What Works Across Platforms:**
- ✅ C++ source code (`code.cpp`)
- ✅ Text files (`input.txt`, `output.txt`, `README.md`)
- ✅ Solution archive structure (`solutions/`)
- ✅ Git repository and `.gitignore`

### **Platform-Specific Scripts:**
- 🐧 **Unix/Linux/macOS**: Use `.sh` files
- 🪟 **Windows**: Use `.bat` files
- Both sets included in repository

## 🎯 **Quick Start by Platform**

### **After Cloning on Windows:**
```cmd
git clone <your-repo-url>
cd CP
setup.bat my_first_problem
```

### **After Cloning on Unix/Linux/macOS:**
```bash
git clone <your-repo-url>
cd CP
chmod +x *.sh
./setup.sh my_first_problem
```

## 🔧 **Compiler Configuration**

### **Windows (MinGW)**
```cmd
g++ -std=c++17 -O2 -Wall -Wextra -g -o solution.exe code.cpp
solution.exe < input.txt > output.txt
```

### **Unix/Linux/macOS (GCC/Clang)**
```bash
g++ -std=c++17 -O2 -Wall -Wextra -g -o solution code.cpp
./solution < input.txt > output.txt
```

## 📝 **Notes**

1. **Executable Extensions**: Windows scripts add `.exe`, Unix scripts don't
2. **Path Separators**: Handled automatically by each platform's scripts  
3. **Shell Commands**: Each platform uses native commands
4. **Line Endings**: Git handles CRLF/LF conversion automatically
5. **Permissions**: Unix scripts need `chmod +x` after cloning

## 🚀 **Ready to Go!**

Your competitive programming lab now works on:
- ✅ Windows 10/11 (with MinGW or Visual Studio)
- ✅ macOS (with Xcode tools)
- ✅ Linux (Ubuntu, CentOS, Arch, etc.)
- ✅ Git repositories (cross-platform compatible)
