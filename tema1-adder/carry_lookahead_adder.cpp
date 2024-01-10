#include "carry_lookahead_adder.h"

bool carry_lookahead_adder(bool a[NUM_BITS], bool b[NUM_BITS], bool sum[NUM_BITS]) {

#pragma HLS INTERFACE mode=ap_ctrl_none port=return
#pragma HLS INTERFACE mode=ap_none port=a
#pragma HLS INTERFACE mode=ap_none port=b
#pragma HLS INTERFACE mode=ap_none port=sum

	bool s[NUM_BITS] = {0};
	bool g[NUM_BITS] = {0};
	bool p[NUM_BITS] = {0};
	bool carry = 0;

    for (int i = 0; i < NUM_BITS; i++){
        s[i] = (a[i] ^ b[i]) ^ carry;
        g[i] = a[i] & b[i];
        p[i] = a[i] ^ b[i];
        carry = g[i] | (p[i] & carry);

        sum[i] = s[i];
    }

	return carry;
}
