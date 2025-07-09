// Competitive Programming Wrapper
// This file handles I/O redirection for local testing
// Your code.cpp should contain pure cin/cout without any freopen()

#include <cstdio>

int main() {
    // Redirect stdin/stdout to files for local testing
    freopen("input.txt", "r", stdin);
    freopen("output.txt", "w", stdout);
    
    // Include and run your solution
    #include "code.cpp"
    
    return 0;
}
