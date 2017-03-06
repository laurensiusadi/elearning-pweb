/*	Tugas PBO dari buku C++ How to Program, 8th edition. Halaman 99 no. 3.12
 *
 *	Nama		: Fransiskus Gusti Ngurah Dwika Setiawan
 *	NRP			: 5112100013
 *	Kelas PBO	: C
 *
 */

#include <iostream>

using namespace std;

class Account {
private:
	int balance;
public:
	Account(int amount) {
		if(amount >= 0) 
			balance=amount;
		else {
			balance = 0;
			printf("Error: invalid initial balance\n");
		}
	}
	void credit(int amount) {
		balance+=amount;
	}
	void debit(int amount) {
		if(amount>balance) 
			printf("Debit amount exceeded account balance\n");
		else 
			balance -= amount;
	}
	int getBalance() {
		return balance;
	}
};

int main() {

	
	return 0;
}
