/*
*Imaduddin Al Fikri
*5112100092
*PBO C
*account class
*/
#include<iostream>
#include<string>

using namespace std;

class BankAccount
{
public:
	//bank account
	BankAccount(string acc)
	{
		setAcc(acc);
	}
	void setAcc(string acc)
	{
		customerAccount = acc;
	}
	string getAcc()
	{
		return customerAccount;
	}
	//account balance
	BankAccount(int cash)
	{
		if(cash<0)
		{
			cout << "Initial balance was not valid!!\nBalance set back to 0\n\n";
			cash=0;
		}
		setBalance(cash);
	}
	void setBalance(int cash)
	{
		accountBalance = cash;
	}
	//debit&credit
	BankAccount(int ct, int dt)
	{
		setTrans(ct,dt);
	}
	void setTrans(int ct, int dt)
	{
		credit = ct;
		debit = dt;
	}
	int getCredit()
	{
		return credit;
	}
	int getDebit()
	{
		return debit;
	}
	//fungsi getBalance
	int getBalance()
	{
		if(accountBalance<0)
			cout << "Error! Jumlah account balance tidak valid! Account balance aka diset ke 0!\n";
		return accountBalance;
	}
	int kridit(int bal, int ct)
	{
		return bal+ct;
	}
	int deb(int bal, int dt)
	{
		if(bal>dt)
			return bal-dt;
	}
	
private:
	string customerAccount;	//customer's bank account
	int accountBalance,credit,debit;		//customer's bank account balance
};

int main()
{
	
	return 0;
}
