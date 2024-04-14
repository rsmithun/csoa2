#include <stdio.h>

extern long long int solve(char *string, long long int length);

int main(){
    long long int n;
    scanf("%lld", &n);

    char str [n];
    scanf("%s", str);

    long long int result = solve(str, n);
    printf("%lld\n", result);

    return 0;
}