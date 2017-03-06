#include <iostream>
using namespace std;

class BankAcc {
	int balance;
	public :
		BankAcc (int init) {
			if (init < 0) {
				balance = 0;
				cout << "The initial balance was invalid\n";
			} 
			else 
				balance = init;
		}
		void credit (int add) {
			balance += add;
		}
		void debit (int minus) {
			if (minus > balance) 
				cout << "Debit amount exceeded account balance.\n";
			else 
				balance-=minus;
		}
		int getBalance () {
			return balance;
		}		
};

int main () {

	return 0;
}
