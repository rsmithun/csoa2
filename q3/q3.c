#include <stdio.h>

extern long long int postFix(char *string, long long int length);

int main(){
    long long int n;
    scanf("%lld", &n);

    char str [n];
    scanf(" %[^\n]", str);

    long long int result = postFix(str, n);
    printf("%lld\n", result);

    return 0;
}