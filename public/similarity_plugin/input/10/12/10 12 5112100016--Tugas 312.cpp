#include <iostream>
using namespace std;
class Account {
	int balance;
	
	public:
		//inisialisasi saldo
		Account(int m) {
			if(m < 0){									//jika nilai inisialisasi saldo kurang dari 0
				balance = 0;							//set saldo = 0
				cout<<"the initial balance invalid\n"; 	//cetak pesan eror
			}
			else 
				balance = m;
		}
		
		//menambah uang ke saldo
		void credit(int m) {
			balance = balance + m;
		}
		
		//mengambil uang dari saldo
		void debit(int m) {
			if(balance - m < 0) 									//jika yang diambil melebihi saldo
				cout<<"Debit ammount exceeded account balance\n";
			else 
				balance = balance - m;
		}
		
		//menampilkan saldo saat ini
		int getBalance() {
			return balance;
		} 
};
int main(){
}
