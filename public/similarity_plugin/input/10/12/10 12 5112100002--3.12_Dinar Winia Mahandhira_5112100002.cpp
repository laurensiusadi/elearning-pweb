#include <iostream>
#include <stdlib.h>

using namespace std;

class Account
{
public:
	
	Account(int bal)
	{
		if (bal >= 0)
			balance = bal;
		else
		{
			balance=0;
			cout << "The initial balance was invalid!" << endl;
		}			
	}
	
	void credit(int bal)
	{
		balance+=bal;
	}

	void debit(int bal)
	{
		if(bal <= balance)
			balance-=bal;
		else
			cout << "Debit amount exceeded account balance!" << endl;
	}
	
	int getBalance()
	{
		return balance;
	}

private:
	int balance;
};

int main(){
	return 0;
}
