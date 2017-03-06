#include<iostream>
#include<string>

using namespace std;

class accountBalance
{
public :
       accountBalance(int aBalance)
       {
       		if(aBalance < 0) aBalance = 0;
       		balance = aBalance;
       }
       void displayMessage()
	   {
		    cout << "Welcome to Account Balance\n";
	   }
	   
	   void setAccountBalance()
	   {
            cout << "Masukkan Account Balance : ";
            cin >> aBalance;
            if(aBalance <= 0)
            {
                        aBalance = 0;
                        cout << "Wrong Account Balance\n";
            }
            balance = aBalance;
       }
       int getAccountBalance()
       {
            return balance;
       }
	   
       void setAccountCredit()
       {
            cin >> aCredit;
            balance += aCredit;
	   }
       
       void setAccountDebit()
       {
            cin >> aDebit;
            if(aDebit > balance)
            {
                      cout << "Debit amountexceeded account balance.\n";
            }
            else balance -= aDebit;
	   }
       
private :
	int balance, aBalance, aCredit, aDebit;
};

int main()
{
    
	return 0;
}
