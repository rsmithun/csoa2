#include <stdio.h>

extern long long int binarysearch(long long int *array, long long int x, long long int *iter);

int main(){

    long long int arr[32];

    for (long long int i = 0; i < 32; i++) {
        scanf("%lld", &arr[i]);
    }

    long long int x;
    scanf("%lld", &x);

    long long int iter;

    long long int result = binarysearch(arr, x, &iter);

    if (result == -1){
        printf("-1");
    }
    else{
        printf("%lld %lld", result, iter);
    }

    return 0;
}