#include <cstdio>
#include <cstdlib>
#include <iostream>

using namespace std;

class Account {
public:
	Account (int blc)
	{
		if (blc >= 0)
			balance = blc;
		
		if (blc < 0)
		{
			balance = 0;
			cout << "The initial balance was invalid" << endl;
		}
	}
	
	int debit (int blc)
	{
		balance = balance - blc;
	}
	
	int credit (int blc)
	{
		balance += blc;
	}
	
	int getBalance()
	{
		return balance;
	}
	
private:
	int balance;
};

int main() {
	return 0;
}
