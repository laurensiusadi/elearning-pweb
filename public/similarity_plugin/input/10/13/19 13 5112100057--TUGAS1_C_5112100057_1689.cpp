#include<iostream>
#include<stdlib.h>
using namespace std;
class invoice
{
	public:
	string nomer;
	string deskripsi;
	int jumlah;
	int harga;
	
invoice (string nilainomer,string nilaideskripsi,int nilaijumlah,int nilaiharga)
{
	nomer = nilainomer;
	deskripsi = nilaideskripsi;
	jumlah = nilaijumlah;
	harga = nilaiharga;
}

void set ()
{
	string setnomer;
	string setdeskripsi;
	int setjumlah;
	int setharga;
	
	cout << "masukkan nomer barang: " << endl;
	cin >> setnomer;
	nomer = setnomer;
	
	cout << "masukkan deskripsi barang: " << endl;
	cin >> setdeskripsi;
	deskripsi = setdeskripsi;
	
	cout << "masukkan jumlah barang: " << endl;
	cin >> setjumlah;
	jumlah = setjumlah;
	
	cout << "masukkan harga barang: " << endl;
	cin >> setharga;
	harga = setharga;
}

string getnomer ()
{
    return nomer;
}

string getdeskripsi ()
{
	return deskripsi;
}

int getjumlah ()
{
	return jumlah;
}

int getharga ()
{
	return harga;
}

int getinvoiceamount ()
{
	return jumlah*harga;
}

};

int main()
{
    
	return 0;
}
