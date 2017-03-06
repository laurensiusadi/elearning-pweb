#include <iostream>
#include <string>
#define clear system ("cls");

using namespace std;

class Jenis
{
public:
	string nama;
	int bahagia;
	int lapar;
	int energi;
	int seger;

	Jenis()
	{
	}

	void status()
	{
		int ngap;
		int lagi = 0;

		clear;
		cout << "\nBahagia : " << bahagia << endl;
		cout << "Lapar : " << lapar << endl;
		cout << "Energi : " << energi << endl;
		cout << "Seger : " << seger << endl;

		cout << "\nGimana? mau lanjut lagi? kalau iya klik 1\n\n";

		cin >> lagi;
		if (lagi == 1)
		{
			milih();
			cekk();
		}
		else
		{
			cout << "\nYah salah mencet\n\nGAME OVER";
			getchar();
		}
	}

	void makan() {
		bahagia += 20;
		lapar -= 20;
		energi += 20;
		seger += 10;
	}
	void mandi() {
		bahagia += 10;
		lapar -= 5;
		energi += 15;
		seger += 30;

	}
	void main() {
		bahagia += 20;
		lapar += 10;
		energi -= 20;
		seger -= 10;
	}

	void milih()
	{
		int ngap;

		clear;
		cout << "\nYuk main main sama aku\nHayoo sekarang mau ngapain???\n\n";
		cout << "Kalau mau MAIN pencet 1\n";
		cout << "Kalau mau MAKAN pencet 2\n";
		cout << "Kalau mau MANDI pencet 3\n\n";

		cin >> ngap;

		if (ngap == 1)
		{
			bahagia += 20;
			lapar += 10;
			energi -= 20;
			seger -= 10;
		}
		else if (ngap == 2)
		{
			bahagia += 20;
			lapar -= 20;
			energi += 20;
			seger += 10;
		}
		else if (ngap == 3)
		{
			bahagia += 10;
			lapar -= 5;
			energi += 15;
			seger += 30;
		}
		else
		{
			cout << "Hayoo salah mencet ya... pilih 1, 2 atau 3, jangan yang lain\n";
		}
	}

	void cekk()
	{
		int cek;
		int ngap;

		cout << "\nMau tau keadaanku sekarang? klik 1 buat liat atau 2 buat lanjut\n\n";
		scanf("%d", &cek);

		if (cek == 1)
		{
			status();
		}
		else if (cek == 2)
		{
			milih();
			cekk();
		}
	}
};

int main()
{
	int n;
	int lagi;
	char nama[100];

	cout << "Hello Tamagotchi!!!" << endl;

	cout << "----------------------------\n";
	cout << "INI MAINAN MIRIP TAMAGOTCHI\n";
	cout << "      TAPI TIDAK SAMA\n";
	cout << "----------------------------\n";

	cout << "Yuk pilih jenis kartun dulu...\nGak pake nama nama an\n\n";
	cout << "<1> Popeye\n";
	cout << "<2> Dora\n";
	cout << "<3> Bob\n";
	cout << "<4> Sinchan\n\n";

	cin >> n;

	if (n == 1)
	{
		Jenis pop;
		pop.nama = "Popeye";
		pop.bahagia = 30;
		pop.lapar = 10;
		pop.energi = 40;
		pop.seger = 20;
		pop.milih();
		pop.status();
	}
	else if (n == 2)
	{
		Jenis bobb;
		bobb.nama = "Bob";
		bobb.bahagia = 70;
		bobb.lapar = 20;
		bobb.energi = 50;
		bobb.seger = 20;
		bobb.milih();
		bobb.status();
	}
	else if (n == 3)
	{
		Jenis dor;
		dor.nama = "Dora";
		dor.bahagia = 60;
		dor.lapar = 20;
		dor.energi = 30;
		dor.seger = 20;
		dor.milih();
		dor.status();
	}
	else if (n == 4)
	{
		Jenis sin;
		sin.nama = "Sinchan";
		sin.bahagia = 90;
		sin.lapar = 10;
		sin.energi = 40;
		sin.seger = 20;
		sin.milih();
		sin.status();
	}

	cin.get();
	return 0;
}