#include <cstdio>
#include <cstdlib>
#include <iostream>
using namespace std;

class Account {
public:
	Account (int money)
	{
		if (money >= 0)
			balance = money;
		
		if (money < 0)
		{
			balance = 0;
			cout << "The initial balance was invalid" << endl;
		}
	}
	
	int debit (int money)
	{
		balance = balance - money;
	}
	
	int credit (int money)
	{
		balance = balance + money;
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
}
