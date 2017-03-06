#include<iostream>
#include<string>

using namespace std;

class AccountBank
{
	public:
		AccountBank(int input)
		{
			if(input>=0)
			{
				setAccountBalance(input);	
			}
				
			else
			{
				balance=0;
				cout << " The Initial Balance has invalid\n";
			}
		}
		void setAccountBalance(int input)
		{
			balance = input;
		}
		int getAccountBalance()
		{
			return balance;
		}
		void credit(int input)
		{
			if(input>=0)
			{
				balance+=input;
			}
			else
			{
				balance=balance;
			}
			
		}
		void debit(int input)
		{
			if(input<=balance)
			{
				balance-=input;
			}
			else
			cout << "Debit amount exceeded account balance\n";
		}
	private:
		int balance;
	
};

int main()
{

}
