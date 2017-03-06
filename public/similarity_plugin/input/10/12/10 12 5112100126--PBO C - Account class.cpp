#include<iostream>
#include<string>
using namespace std;

class Account
{
	int balance;
	public:
		Account(int money) // constructor
		{
			if(money < 0)
			{
				balance = 0;
				cout<<"Error message\n";
			}
			else balance = money;
		}
		
		void creditBalance(int money)
		{
			balance += money;
		}
		
		void debitBalance(int money)
		{
			if(money>balance)
			{
				cout<<"Debit amount exceeded\n";
			}
			else balance -= money;
		}
		
		int getBalance()
		{
			return balance;
		}
		
};

int main()
{
}
