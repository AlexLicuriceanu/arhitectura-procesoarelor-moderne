/*
 * Alexandru LICURICEANU
 * 332CD
 */

#include "carry_lookahead_adder.h"

bool cla_16bit(bool a[16], bool b[16], bool sum[16], bool carry_in) {

#pragma HLS INTERFACE mode=ap_none port=carry_in
#pragma HLS INTERFACE mode=ap_none port=return

	// Use 4x 4-bit CLAs.

	for (int i = 0; i < 4; i++) {


		// 4-bit CLA logic:

		bool a_4bit[4] = {0};		// Stores 4 bits from the original 16-bit number.
		bool b_4bit[4] = {0};		// Stores 4 bits from the original 16-bit number.

		bool sum_4bit[4] = {0};		// Stores the sum of the 4-bit CLA.
		bool g[4] = {0};
		bool p[4] = {0};

		for (int j = 0; j < 4; j++) {

			// Copy the required bits from a and b.
			a_4bit[j] = a[4*i+j];
			b_4bit[j] = b[4*i+j];


			// Compute sum, generate, propagate.
			sum_4bit[j] = (a_4bit[j] ^ b_4bit[j]) ^ carry_in;
			g[j] = a_4bit[j] & b_4bit[j];
			p[j] = a_4bit[j] ^ b_4bit[j];


			// Compute carry.
			carry_in = g[j] | (p[j] & carry_in);

			// Write the output of the 4-bit CLA for these two bits to the 16-bit sum.
			sum[4*i+j] = sum_4bit[j];
		}
	}

	// The last carry is the overall carry value.
	return carry_in;
}
