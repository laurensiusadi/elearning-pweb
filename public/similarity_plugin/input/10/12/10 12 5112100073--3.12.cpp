#include <iostream>
#include <string>

using namespace std;

class BankAccount
{
	public :
		BankAccount(int val)
		{
			setBalanceValue(val);
		}
		
		void setBalanceValue(int val)
		{
			if(val>=0)
			{
				balanceValue=val;
			}
			else
			{
				balanceValue=0;
			}
		}
		
		int getBalanceValue()
		{
			return balanceValue;
		} 
		
		void credit (int val)
		{
			balanceValue+=val;	
		}
		
		void debit (int val)
		{
			if(val>balanceValue)
			{
				cout << "Debit amount exceeded account balance\n";
			}
			else
			{
				balanceValue-=val;
			}
		}
		
	private :
		int balanceValue;
};

int main()
{
	
}
