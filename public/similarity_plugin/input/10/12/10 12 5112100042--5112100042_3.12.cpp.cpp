#include <iostream>
#include <string>
using namespace std;

class Account
{ int cek;

	public :
		Account (int uangawal)
		{
			if (uangawal<0) cout <<"Transaksi tidak dapat dilakukan"<< endl;
			cek=uangawal;	
		}
		
		void debit (int uangdebit)
		{
			if (uangdebit>cek) cout<<"Saldo Anda tidak mencukupi"<< endl;
			else
			cek=cek-uangdebit;
		}
		
		void kredit (int uangkredit)
		{
			cek=cek+uangkredit;	
		}	
		
		void cetaksaldo ()
		{
			if (cek<0)
			cout<<"Transaksi tidak dapat dilakukan"<<endl;
			else
			cout<<"Saldo Anda adalah : " <<cek<<endl;	
		}
		
	private :
		int balance;
};

int main ()
{
return 0;
}
