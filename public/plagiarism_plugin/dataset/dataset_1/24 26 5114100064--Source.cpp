#include<iostream>
#include<string>
#include<Windows.h>

using namespace std;

class Pet
{
public:
	string nama_pet;
	int lapar;
	int energi;
	int kebersihan;
	int senang;

	Pet()
	{

	}

	void Makan()
	{
		lapar = lapar + 5;
		if (lapar > 100) lapar = 100;
		energi = energi + 2;
		if (energi > 100) energi = 100;
		kebersihan = kebersihan - 2;
		if (kebersihan < 0) kebersihan = 0;
		senang = senang + 2;
		if (senang > 2) senang = 100;
	}

	void Energi()
	{
		lapar = lapar - 3;
		if (lapar < 0) lapar = 0;
		energi = energi + 5;
		if (energi > 100) energi = 100;
		kebersihan = kebersihan - 3;
		if (kebersihan < 0) kebersihan = 0;
		senang = senang - 3;
		if (senang < 0) senang = 0;
	}

	void Mandi()
	{
		lapar = lapar - 3;
		if (lapar < 0) lapar = 0;
		energi = energi - 3;
		if (energi < 0) energi = 0;
		kebersihan = kebersihan + 5;
		if (kebersihan > 100) kebersihan = 100;
		senang = senang + 3;
		if (senang > 100) senang = 100;
	}

	void Main()
	{
		lapar = lapar - 3;
		if (lapar < 0) lapar = 0;
		energi = energi - 3;
		if (energi < 0) energi = 0;
		kebersihan = kebersihan - 3;
		if (kebersihan < 0) kebersihan = 0;
		senang = senang + 5;
		if (senang > 100) senang = 100;
	}

	void Stat()
	{
		system("cls");
		cout << "Status dari " << nama_pet << " adalah: ";
		cout << "lapar : " << lapar << "\n";
		cout << "energi : " << energi << "\n";
		cout << "kebersihan : " << kebersihan << "\n";
		cout << "senang : " << senang << "\n";
	}

	void Cek()
	{
		if (lapar == 0)
		{
			cout << "Pet anda mati\n";
		}
		if (energi == 0)  cout << "Pet anda perlu istirahat\n";
		if (kebersihan == 0) cout << "Pet anda perlu dibersihkan\n";
		if (senang == 0) cout << "Pet anda sedang stress\n";
	}
};
int main()
{
	Pet cat;
	cat.energi = 100;
	cat.lapar = 100;
	cat.kebersihan = 100;
	cat.senang = 100;
	int mode = 1;

	cout << "Masukkan nama pet anda : ";
	getline(cin, cat.nama_pet);


	while (mode != 0)
	{

		cout << "Masukkan apa yang anda inginkan terhadap pet anda\n 1.Memberi makan\n 2.Tidur\n 3.Mandi\n 4.Bermain\n 0.Keluar\n";
		cin >> mode;
		if (mode == 1)
		{
			cat.Makan();
			cat.Stat();
			cat.Cek();
		}
		else if (mode == 2)
		{
			cat.Energi();
			cat.Stat();
			cat.Cek();
		}
		else if (mode == 3)
		{
			cat.Mandi();
			cat.Stat();
			cat.Cek();
		}
		else if (mode == 4)
		{
			cat.Main();
			cat.Stat();
			cat.Cek();
		}
	}
}