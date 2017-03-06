/*
 * main.cpp
 *
 *  Created on: Sep 18, 2013
 *      Author: ericivander
 */


#include<iostream>
#include<algorithm>
#include<cstdio>
using namespace std;

class Account{
public:
	Account(double initial){
		if(initial>0) balance=initial;
		else{
			cout << "Initial balance invalid" << endl;
			cout << "Initial balance set to 0 ";
			getchar();getchar();
			system("clear");
			balance=0.0;
		}
	}
	void getBalance(){
			cout << "Balance : " << balance << endl;
		}
	void credit(){
		double money;
		cout << "Input credit : ";
		cin >> money;
		balance+=money;
		getBalance();
		getchar();getchar();
		system("clear");
	}
	void debit(){
		double money;
		getBalance();
		cout << "Input debit : ";
		cin >> money;
		if(money<=balance) balance-=money;
		else{
			cout << "Debit amount exceeded account balance ";
			getchar();getchar();
		}
		getBalance();
		getchar();getchar();
		system("clear");
	}
private:
	double balance;
};

Account eric(100),billy(100);

void AccessEric();
void AccessBilly();

int main(){
	
	return 0;
}

void AccessEric(){
	cout << "==================================" << endl;
	cout << "Acessing Eric Ivander Jeadi" << endl;
	cout << "==================================" << endl;
	cout << "Choose menu" << endl;
	cout << "==================================" << endl;
	cout << "1. getBalance" << endl;
	cout << "2. credit" << endl;
	cout << "3. debit" << endl;
	cout << "4. back to main" << endl;
	cout << "===================================" << endl;
	int pil;
	cin >> pil;
	system("clear");
	if(pil==4) main();
	else if(pil==1){
		eric.getBalance();
		getchar();getchar();
		system("clear");
	}
	else if(pil==2) eric.credit();
	else if(pil==3) eric.debit();
	else{
		cout << "Invalid selection ";
		getchar();getchar();
		system("clear");
	}
	return AccessEric();
}

void AccessBilly(){
	cout << "==================================" << endl;
	cout << "Acessing Billy Alexander Jeadi" << endl;
	cout << "==================================" << endl;
	cout << "Choose menu" << endl;
	cout << "==================================" << endl;
	cout << "1. getBalance" << endl;
	cout << "2. credit" << endl;
	cout << "3. debit" << endl;
	cout << "4. back to main" << endl;
	cout << "==================================" << endl;
	int pil;
	cin >> pil;
	system("clear");
	if(pil==4) main();
	else if(pil==1){
		billy.getBalance();
		getchar();getchar();
		system("clear");
	}
	else if(pil==2) billy.credit();
	else if(pil==3) billy.debit();
	else{
		cout << "Invalid selection ";
		getchar();getchar();
		system("clear");
	}
	return AccessBilly();
}
