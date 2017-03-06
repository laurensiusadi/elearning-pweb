#include<iostream>
#include<stdlib.h>
using namespace std;
class akun
{
public:
	int saldo;

void tambahsaldo ()
{
	int tambah;
	cout << "masukkan jumlah: " << endl;
	cin >> tambah;
	saldo = saldo+tambah;
}

void kurangsaldo ()
{
	int kurang;
	cout << "masukkan jumlah penarikan: " << endl;
	cin >> kurang;
	if (saldo > kurang) saldo = saldo-kurang;
	else if (saldo < kurang) cout << "maaf saldo anda tidak cukup";
}

int tampilsaldo ()
{
	return saldo;
}

akun (int mau)
{
	saldo = mau;
	if (saldo < 0)
	{
	saldo = 0;
	cout << "maaf saldo anda mines" << endl;
	}
}
};

int main ()
{

	return 0;
}
