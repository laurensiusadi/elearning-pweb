/*
 * Nama : Karsten Ari Agathon
 * NRP 	: 5112100110
 * Kelas: PBO C
 * Tugas PBO 1
 */
#include <iostream>
using namespace std;
class Account {
public:
	Account(int initial){
		if(initial>=0) balance = initial;
		else{
			balance=0;
			cout << "The initial balance was invalid\n";
		}
	}
	void credit(int money){
		balance+=money;
	}
	void debit(int money){
		if(balance>=money){
			balance-=money;
		}
		else cout << "Debit amount exceeded account balance.\n";
	}
	int getBalance(){
		return balance;
	}
private:
	int balance;
};
int main(){

	return 0;
}
