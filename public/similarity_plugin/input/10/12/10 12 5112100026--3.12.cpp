#include<iostream>

using namespace std;

class Account
{
	public:
		Account(int money)
		{
			if(money >= 0)
			{
				balance = money;
			}
			else
			{
				balance = 0;
				cout << "Error!" << endl;
			}
		}
		
		void credit(int money)
		{
			balance = balance + money;
		}
		
		void debit(int money)
		{
			if(money <= balance)
			{
				balance = balance - money;
			}
			else
			{
				cout << "Debit amount exceeded account balance." << endl;
			}
		}
		
		int getBalance()
		{
			return balance;
		}
		
	private:
		int balance;		
};

int main()
{
	
	return 0;
}
