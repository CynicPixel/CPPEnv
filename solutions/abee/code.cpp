#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int main() {
    ios_base::sync_with_stdio(false);
    cin.tie(NULL);
    
    int n;
    cin >> n;
    
    vector<int> arr(n);
    for (int i = 0; i < n; i++) {
        cin >> arr[i];
    }
    
    // Find sum of all elements
    long long sum = 0;
    for (int i = 0; i < n; i++) {
        sum += arr[i];
    }
    
    cout << sum << endl;
    
    return 0;
}
