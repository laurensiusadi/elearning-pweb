#include<iostream>

using namespace std;

class Account {
	public:
		Account (int saldo) {
			if (saldo >= 0) {
				balance = saldo;
			}	
			else {
				balance = 0;
				cout << "Error! Uang Anda sedikit" << endl;
			}
		}
		
		void credit (int duit) {
			balance = balance + duit;
		}
		
		void debit (int duit) {
			if (duit <= balance) {
				balance = balance - duit;
			}
			else cout << "Uang Anda tidak mencukupi" << endl;
		}
		
		int getBalance() {
			return balance;
		}
	private: //biar ga bisa diubah seenaknya
		int balance;		
};

int main(){
}
