#ifndef CARRY_LOOKAHEAD_ADDER_H
#define CARRY_LOOKAHEAD_ADDER_H

#include <ap_int.h>

#define NUM_BITS 16

bool carry_lookahead_adder(bool a[NUM_BITS], bool b[NUM_BITS], bool sum[NUM_BITS]);

#endif // CARRY_LOOKAHEAD_ADDER_H
