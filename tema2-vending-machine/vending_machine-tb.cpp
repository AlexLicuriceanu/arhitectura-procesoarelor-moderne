#include "vending_machine-tb.h"
#include <iostream>

using namespace std;

int main() {

	int status = 0;

	cout << "Test 1: " << endl;
	insert_money(0, 1, 0); 	// 10
	insert_money(0, 1, 0); 	// 10
	insert_money(0, 0, 1); 	// 25
	insert_money(0, 0, 0);	// Dispense drink and change.
	press_thanks();			// Press thank you button.

	cout << endl << "Test 2: " << endl;
	insert_money(0, 1, 0); 	// 10
	insert_money(1, 0, 0); 	// 5
	insert_money(0, 1, 0); 	// 10
	insert_money(0, 0, 0);	// Dispense drink and change.
	press_thanks();			// Press thank you button.

	return status;
}
