//============================================================================
//
// Name        : fib.c
// Description : asuFibonacci
// Copyright (c) 2019 W. Craig Scratchley  --  wcs (at) sfu (dot) ca
//============================================================================

#include <stddef.h>
//#include <stdlib.h>
#define MIN(x, y) (((x) < (y)) ? (x) : (y))
#define MAX_SIZE_TEST 4000

typedef unsigned int bigNumTest[1 + MAX_SIZE_TEST];
typedef unsigned int bigNumN[];

int asuAdd(bigNumN bigN0P, const bigNumN bigN1P, unsigned int maxN0Size);

int asuFibonacci(int n, int maxSize, bigNumN **bNP) {

	static bigNumTest bNa;
	static bigNumTest bNb;

	bNa[0] = 0;

	bNb[1] = 1;
	bNb[0] = 1;

	if ((n == 1) && (maxSize > 0)) {
		*bNP = &bNb;
		return 1;
	}
	if ((n <= 1) || (maxSize == 0)) {
		*bNP = &bNa;
		return 0;
	}
	else {
		int overflow = 0;
		int i = 2;

		while(1)
		{
			// a = a + b;
			overflow = asuAdd(bNa, bNb, maxSize);
			if (overflow) {
				*bNP = &bNb;
				return --i;
			}
			if (i == n) {
				*bNP = &bNa;
				return i;
			}
			//b = b + a;
			overflow = asuAdd(bNb, bNa, maxSize);
			if (overflow) {
				*bNP = &bNa;
				return i;
			}
			i += 2;
			if (i > n) {
				*bNP = &bNb;
				return n;
			}
		}
	}
}

int fib_main(int max_size) {
	max_size = MIN(max_size, MAX_SIZE_TEST);
	bigNumN *fibResP = NULL;
	int i = asuFibonacci(1000000, max_size, &fibResP);
	unsigned j = *((*fibResP)+1);
	return i;
}
