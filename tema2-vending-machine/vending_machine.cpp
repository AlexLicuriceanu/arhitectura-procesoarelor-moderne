#include "vending_machine.h"

void vending_machine(bool in_5, bool in_10, bool in_25,	bool in_thanks,	bool &out_drink, bool &out_5, bool &out1_10, bool &out2_10) {

#pragma HLS INTERFACE ap_none port=in_5
#pragma HLS INTERFACE ap_none port=in_10
#pragma HLS INTERFACE ap_none port=in_25
#pragma HLS INTERFACE ap_none port=in_thanks
#pragma HLS INTERFACE ap_none port=out_drink
#pragma HLS INTERFACE ap_none port=out_5
#pragma HLS INTERFACE ap_none port=out1_10
#pragma HLS INTERFACE ap_none port=out2_10
#pragma HLS INTERFACE ap_ctrl_none port=return

	static State current_state;
	State next_state = current_state;

	bool out_drink_temp;
	bool out_5_temp, out1_10_temp, out2_10_temp;


	switch(current_state) {

	case w0:
		out_drink_temp = 0;
		out_5_temp = 0; out1_10_temp = 0; out2_10_temp = 0;

		if (in_5)
			next_state = w5;
		else if (in_10)
			next_state = w10;
		else if (in_25)
			next_state = w25;
		else
			next_state = w0;
		break;

	case w5:
		out_drink_temp = 0;
		out_5_temp = 0; out1_10_temp = 0; out2_10_temp = 0;

		if (in_5)
			next_state = w10;
		else if (in_10)
			next_state = w15;
		else if (in_25)
			next_state = w30;
		else
			next_state = w5;
		break;

	case w10:
		out_drink_temp = 0;
		out_5_temp = 0; out1_10_temp = 0; out2_10_temp = 0;

		if (in_5)
			next_state = w15;
		else if(in_10)
			next_state = w20;
		else if (in_25)
			next_state = w35;
		else
			next_state = w10;
		break;

	case w15:
		out_drink_temp = 0;
		out_5_temp = 0; out1_10_temp = 0; out2_10_temp = 0;

		if (in_5)
			next_state = w20;
		else if (in_10)
			next_state = w25;
		else if (in_25)
			next_state = w40;
		else
			next_state = w15;
		break;

	case w20:
		out_drink_temp = 0;
		out_5_temp = 0; out1_10_temp = 0; out2_10_temp = 0;

		if (in_5)
			next_state = w25;
		else if (in_10)
			next_state = w30;
		else if (in_25)
			next_state = w45;
		else
			next_state = w20;
		break;

	case w25:
		out_drink_temp = 1;
		out_5_temp = 0; out1_10_temp = 0; out2_10_temp = 0;

		next_state = wthanks;
		break;

	case w30:

		out_drink_temp = 1;
		out_5_temp = 1; out1_10_temp = 0; out2_10_temp = 0;

		next_state = wthanks;
		break;

	case w35:

		out_drink_temp = 1;
		out_5_temp = 0; out1_10_temp = 1; out2_10_temp = 0;

		next_state = wthanks;
		break;

	case w40:

		out_drink_temp = 1;
		out_5_temp = 1; out1_10_temp = 1; out2_10_temp = 0;

		next_state = wthanks;
		break;

	case w45:

		out_drink_temp = 1;
		out_5_temp = 0; out1_10_temp = 1; out2_10_temp = 1;

		next_state = wthanks;
		break;

	case wthanks:

		out_drink_temp = 0;
		out_5_temp = 0; out1_10_temp = 0; out2_10_temp = 0;

		if (in_thanks == 1)
			next_state = w0;
		else
			next_state = wthanks;
		break;

	default:
		return;
	}

	current_state = next_state;

	out_drink = out_drink_temp;
	out_5 = out_5_temp;
	out1_10 = out1_10_temp;
	out2_10 = out2_10_temp;

}
