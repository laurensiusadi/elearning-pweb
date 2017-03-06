#include <iostream>
#include <string.h>

using namespace std;

class AkunBank
{
	public:
		AkunBank (int saldo){
			if (saldo >= 0){
				balance = saldo;
			}else{
				balance = 0;
				cout << "The initial balance was invalid\n";
			}
		}
		void setoran (int saldo){
			if (saldo >= 0){
				balance = balance + saldo;
			}
		}
		void ambil (int saldo){
			if (saldo <= balance){
				balance = balance - saldo;
			}else{
				cout << "Debit ammount exceeded account balance\n";
			}
		}
		int cek(){
			return balance;
		}
	private:
		int balance;	
};

int main ()
{
	return 0;
}
