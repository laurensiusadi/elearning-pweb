#include <string>
#include <iostream>
using namespace std;

class Invoice
{
	int jumlah,total;
	public :
		Invoice (int quantity)
		{
			jumlah=quantity;	
		}
		int getInvoiceAmount (string number, string description, int price)
		{
			if (jumlah<0) cout<<"Transaksi tidak dapat dlakukan\n"<<endl;
			else
			{
			total = jumlah*price;
			cout<<"Nomor barang    : "<<number<<endl;
			cout<<"Deskripsi barang: "<<description<<endl;
			cout<<"Total pembayaran: "<<total<<endl<<endl;
			}
			return 0;
		}
		
};

int main ()
{
	
	return 0;	
}
