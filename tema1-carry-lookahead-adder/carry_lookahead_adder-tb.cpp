/*
 * Alexandru LICURICEANU
 * 332CD
 */


#include "carry_lookahead_adder-tb.h"
#include "carry_lookahead_adder.h"
#include <iostream>
#include <cmath>

#define MAX 65536

using namespace std;

// Little endian!

int to_decimal_16(bool binary[16]) {
    int decimal = 0;

    for (int i = 0; i < 16; i++) {
    	if (binary[i]) {
    		decimal += pow(2, i);
    	}
    }

    return decimal;
}

void to_binary_16(int decimal, bool binary[16]) {
    for (int i = 0; i < 16; i++) {
    	binary[i] = decimal % 2;
    	decimal /= 2;
    }
}

void print_bits_16(bool binary[16], int endianess) {
	if (endianess) {
		for (int i = 0; i < 16; i++) {
			cout << binary[i];
		}
	}
	else {
		for (int i = 15; i >= 0; i--) {
			cout << binary[i];
		}
	}
}


int main () {
	int status = 0;

	for (int i = 0; i < 10; i++) {

		// Pick any two numbers to add.
		int a_decimal = 65000;
		int b_decimal = i * 123;


		// Convert to little endian binary.
		bool a_binary[16] = {0};
		bool b_binary[16] = {0};
		to_binary_16(a_decimal, a_binary);
		to_binary_16(b_decimal, b_binary);


		// Compute the sum.
		bool sum_binary[16] = {0};
		bool carry_out = cla_16bit(a_binary, b_binary, sum_binary, 0);
		int sum_decimal = to_decimal_16(sum_binary);


		// Print results.
		print_bits_16(a_binary, 0);
		cout << " (" << a_decimal << ") + ";

		print_bits_16(b_binary, 0);
		cout << " (" << b_decimal << ") = ";

		print_bits_16(sum_binary, 0);
		cout << " (" <<  sum_decimal << ") ";
		cout << "carry: " << carry_out;


		// Check if the output is correct.
		bool correct = false;

		if (carry_out == 0) {
			int expected = a_decimal + b_decimal;

			if (sum_decimal == expected) {
				correct = true;
			}
		}
		else {
			int expected = a_decimal + b_decimal - MAX;

			if (sum_decimal == expected) {
				correct = true;
			}
		}

		if (correct) {
			cout << " (CORRECT)" << endl;
		}
		else {
			cout << " (INCORRECT)" << endl;
			status = 1;
			break;
		}
	}

	if (status == 0) {
		cout << "Tests passed." << endl;
	}
	else {
		cout << "Tests failed." << endl;
	}

	return status;
}
