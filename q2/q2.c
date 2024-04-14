#include <stdio.h>

extern long long int nCr(long long int n, long long int r);

int main(){
    long long int n, r;
    scanf("%lld %lld", &n, &r);

    long long int result = nCr(n, r);
    printf("%lld\n", result);

    return 0;
}