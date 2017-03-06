#include<iostream>

using namespace std;

class Account{
	public:
		Account(double amount) {
			if(amount < 0){
				balance = 0.0;
				cout << "input uang anda invalid!" << endl;
			}
			else
				balance = amount;
		}
		void credit(double amount) {
			if(amount < 0)
				cout << "jumlah uang yg anda masukkan invalid\n";
			else
				balance += amount;
		}
		void debit(double amount) {
			if(amount < 0)
				cout << "jumlah uang yg ingin anda ambil invalid\n";
			else{
				if(amount > balance)
					cout << "jumlah uang yang ingin anda ambil melebihi jumlah uang di rekening anda\n";
				else
					balance -= amount;
			}
		}
		double getBalance() {
			return balance;
		}
	private:
		double balance;
};
int main(){
	
	return 0;
}
