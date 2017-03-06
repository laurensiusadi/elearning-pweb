#include <iostream>

using namespace std;

class AccountBank
{
public:
	int initBalance;
	
	AccountBank(int init)
	{
		initBalance = init;
		if (init < 0)
		{
			initBalance = 0;
			cout << "error!the initial balance was invalid\n" ;
		}
	}
		
	void credit (int cr)
	{
		initBalance = initBalance + cr;
	}

	void debet(int db) 
	{
		
		if (db > initBalance)
		{
			cout << "Debit amount exceeded account balance\n" ;
		}
		else
			initBalance = initBalance - db;
	}

	int getBalance()
	{
		return initBalance;
	}

};


int main()
{
	
}
