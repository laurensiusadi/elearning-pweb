#include<cstdio>
#include <cstdlib>
#include <iostream>
 
using namespace std;
 
//membuat Account class
class Account
{
	public:
		Account(int initialBalance)
   		{
      		if (initialBalance<0)
  			{
     			balance=0;
     			cout << "Account balance is invalid" << endl;
   			} else setBalance(initialBalance);
		}
		
		void setBalance(int initialBalance)
  		{
 			 balance=initialBalance;
		}
  		
		int debit(int debitAmount)
  		{
  			if (debitAmount>balance) cout<<"Your balance is not enough.."<<endl; 
			  else balance-=debitAmount;
		}
  		
		int credit(int creditAmount)
  		{
  			balance+=creditAmount;
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
