/*
 * akunBank.cpp
 *
 *  Created on: 19 Sep 2013
 *      Author: Moh Iqbal Tanjung
 */

#include <iostream>
#include <string>

using namespace std;

//BankAccount class definition
class BankAccount
{
public:
	//konstruktor menginisialisasi balanceValue dengan integer sebagai sebuah argument
	/*BankAccount()
	{
		balanceValue=0;
	}*/
	BankAccount(int value)
	{
		// balanceValue = value;
		setBalanceValue(value);
	}// akhir dari konstruktor AccountBalance
	//
	void setBalanceValue(int value)
	{
		if(value>=0)
		{
			balanceValue = value;
		}
		else balanceValue=0;
	}
	int getBalanceValue()
	{
		return balanceValue;
	}
	void credit (int value)
	{
		balanceValue += value; //balanceValue=balanceValue+value
	}
	void debit (int value)
	{
		if(value>balanceValue)
		{
			cout << "Debit amount exceeded account balance \n";
		}
		else
		{
			balanceValue -= value;
		}
	}

private:
	int balanceValue;
};


int main()
{

}
