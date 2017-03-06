/*	author : Akbar Anugerah S 5112100138
	program: Account Class
*/

#include<iostream>
using namespace std;
class Account
{
	public:
		Account(int input)
		{
				setAccountBalance(input);
		}
		
		void setAccountBalance(int input)
		{
			if(input >= 0)
				{
					balance = input; // jika saldo awal > 0, maka set balance sesuai nilai input
				}
				else
				{
					balance =0;		//jika saldo awal negatif, maka set 'balance' menjadi 0 dan tampilkan pesan error 
					displayError();
				}
		}
		
		void displayError()
		{
			cout << "The initial balance was invalid!\n";
		}
		
		void credit(int a)	//fungsi untuk setoran
		{
			if(a >= 0)
			{
				balance = balance + a;	//tambah saldo dengan setoran jika jumlah setoran >= 0
			}
		}
		
		void debit(int b)	//fungsi untuk tarikan 
		{
			if(b <= balance)
			{
				balance = balance - b;	//kurangi saldo dengan tarikan jika jumlah tarikan < saldo
			}
			else
			{
				displayError2();	//message jika tarikan > saldo
			}
		}
		
		int getBalance()	//memberikan nilai di dalam 'balance' / saldo
		{
			return balance;
		}
		
		void displayError2() //cetak message jika jumlah penarikan > saldo
		{
			cout <<"Debit amount exceeded account balance!\n";
		}
		
	private:
		int balance; //data member berupa saldo(balance)
};

int main()
{
	return 0;
}
