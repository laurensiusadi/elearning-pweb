#include <iostream>
using namespace std;
class Account
{
	private :
		int accountBalance;
	public :
		Account(int aB)
		{
			if(aB>=0)
				accountBalance=aB;
			else
			{
				accountBalance=0;
				cout<<"Initial balance was invalid\n";
			}
		}
		void credit(int nominal)
		{
			accountBalance+=nominal;
		}
		void debit(int nilai)
		{
			if(nilai<=accountBalance)
				accountBalance-=nilai;
			else
				cout<<"Debit amount exceeded account balance\n";
		}
		int returnBalance()
		{
			return accountBalance;
		}
};
int main()
{

	return 0;
}
