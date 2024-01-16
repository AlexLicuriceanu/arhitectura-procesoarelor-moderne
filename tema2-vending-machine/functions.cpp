#include <iostream>
#include "vending_machine.h"

using namespace std;

void insert_money(bool in_5, bool in_10, bool in_25) {

	bool out_drink, in_thanks, out_5, out1_10, out2_10;

	vending_machine(in_5, in_10, in_25, in_thanks, out_drink, out_5, out1_10, out2_10);

	cout << "in_5 = " << in_5 << " in_10 = " << in_10 << " in_25 = " << in_25 << " in_thanks = " << in_thanks << endl;
	cout << "out_drink = " << out_drink << " out_5 = " << out_5 << " out1_10 = " << out1_10 << " out2_10 = " << out2_10 << endl;
	cout << endl;
}

void press_thanks() {

	bool out_drink, in_thanks = 1, out_5, out1_10, out2_10;

	vending_machine(0, 0, 0, in_thanks, out_drink, out_5, out1_10, out2_10);

	cout << "in_5 = 0 in_10 = 0 in_25 = 0 in_thanks = " << in_thanks << endl;
	cout << "out_drink = " << out_drink << " out_5 = " << out_5 << " out1_10 = " << out1_10 << " out2_10 = " << out2_10 << endl;
	cout << endl;
}
