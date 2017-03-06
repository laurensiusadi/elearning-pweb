#include<iostream>
using namespace std;

class Account{
	public :
		Account (int money){
			if(money >= 0)
				balance = money;
			else {
				balance = 0;
				cout << "Error !" << endl;
			}
		}
		void credit(int money)
		{
			balance += money;
		}
		void debit(int money)
		{
			if (money <= balance)
				balance -= money;
			else 
				cout << "Error ! uangmu ga cukup" << endl;
		}
		int getBalance(){
			return balance;
		}
	private :
		int balance;
};

int main ()
{
}
