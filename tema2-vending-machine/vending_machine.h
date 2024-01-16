#pragma once

enum State {
	w0,
	w5,
	w10,
	w15,
	w20,
	w25,
	w30,
	w35,
	w40,
	w45,
	wthanks
};

void vending_machine(bool in_5, bool in_10, bool in_25,	bool in_thanks,	bool &out_drink, bool &out_5, bool &out1_10, bool &out2_10);
void insert_money(bool in_5, bool in_10, bool in_25);
void press_thanks();

