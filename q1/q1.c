#include <stdio.h>
#include <stdlib.h>

extern long long int solve(long long int n, long long int l, long long int r, long long int *arr, long long int *prefixSum);

int main(){
    long long int n, l, r;
    scanf("%lld %lld %lld", &n, &l, &r);

    long long int arr[n];

    for (long long int i = 0; i < n; i++) {
        scanf("%lld", &arr[i]);
    }

    long long int* prefixSum = (long long int*)calloc((n+1), sizeof(long long int));

    long long int result = solve(n, l, r, arr, prefixSum);
    printf("%lld", result);

    return 0;
}