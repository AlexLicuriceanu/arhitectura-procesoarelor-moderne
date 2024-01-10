#include "carry_lookahead_adder-tb.h"
#include "carry_lookahead_adder.h"
#include <iostream>

using namespace std;

// Little endian.

int to_decimal(bool binary[NUM_BITS]) {
    int decimal = 0;

    for (int i = 0; i < NUM_BITS; i++) {
    	if (binary[i]) {
    		decimal += pow(2, i);
    	}
    }

    return decimal;
}

void to_binary(int decimal, bool binary[NUM_BITS]) {
    for (int i = 0; i < NUM_BITS; i++) {
    	binary[i] = decimal % 2;
    	decimal /= 2;
    }
}

int main () {
	int status = 0;

	int A = 4000;
	int B = 12000;

	bool a[NUM_BITS], b[NUM_BITS];

	to_binary(A, a);
	to_binary(B, b);

	for (int i = NUM_BITS-1; i >= 0; i--) {
		cout << a[i];
	}

	cout << " (" << A << ") + ";

	for (int i = NUM_BITS-1; i >= 0; i--) {
		cout << b[i];
	}

	cout << " (" << B << ") = ";

	bool sum[NUM_BITS] = {0};
	bool carry = carry_lookahead_adder(a, b, sum);

	for(int i = NUM_BITS-1; i >= 0; i--) {
	    cout << sum[i];
	}

	cout << " (" << to_decimal(sum) << ") carry = " << carry << endl;

	return status;
}
