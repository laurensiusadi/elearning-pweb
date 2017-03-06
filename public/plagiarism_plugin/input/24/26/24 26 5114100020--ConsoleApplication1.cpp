// ConsoleApplication1.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include <iostream>
#include <ctime>
#include <stdlib.h>
#define MAX 100

using namespace std;

class waktu
{
public:
	int jam;
	int menit;
	int detik;
};

class tamagochi
{
public :
	int sehat;
	int lapar;
	int senang;
	int ngantuk;
	char nama[100];

	void view()
	{
		if (sehat == 0)
		{
			cout << "Heman peliharaanmu mati, game over" << endl;
		}
		else
		{
			cout << "Nama Peliharaan : " << nama << endl;
			cout << "-------------------------------------------" << endl;
			cout << "Sehat           : " << sehat << endl;
			cout << "Senang          : " << senang << endl;
			cout << "Lapar           : " << lapar << endl;
			cout << "Ngantuk         : " << ngantuk << endl;
		}
	}

	void instalasi()
	{
		cout << "Masukkan nama peliharaanmu > ";
		cin >> nama;
		senang = 60;
		sehat = 50;
		lapar = 0;
		ngantuk = 0;
	}

	void suntik()
	{
		if (sehat + 20>MAX) sehat = MAX;
		else sehat += 20;
		cout << "Peliharaanmu sudah minum obat" << endl;
	}
	
	void tidur()
	{
		waktu waktu_tidur,waktu_ngantuk;
		int total_waktu, total_waktu_tidur;
		time_t now = time(0);
		tm *ltm = localtime(&now);
		waktu_ngantuk.jam = ltm->tm_hour;
		waktu_ngantuk.menit = ltm->tm_min;
		waktu_ngantuk.detik = ltm->tm_sec;
		total_waktu = (waktu_ngantuk.jam * 3600) + (waktu_ngantuk.menit * 60) + waktu_ngantuk.detik+300;
		cout << "Peliharaanmu sedang tidur, tunggu 5 menit" << endl;
		while (1)
		{
			time_t now = time(0);
			tm *ltm = localtime(&now);
			waktu_tidur.jam = ltm->tm_hour;
			waktu_tidur.menit = ltm->tm_min;
			waktu_tidur.detik = ltm->tm_sec;
			total_waktu_tidur = (waktu_tidur.jam * 3600) + (waktu_tidur.menit * 60) + waktu_tidur.detik;
			if (total_waktu <= total_waktu_tidur)
			{
				ngantuk = 0;
				if (senang + 5>100) senang = 100;
				else senang += 5;
				break;
			}
		}

	}

	void makan()
	{
			lapar = 0;
			if (senang + 5 > MAX) senang = MAX;
			else senang += 5;
			if (sehat + 5 > MAX) sehat = MAX;
			else sehat += 5;
			cout << "Peliharaanmu sudah makan" << endl;
	}

	void bermain()
	{
		if (senang + 5>MAX) senang = MAX;
		else senang += 5;
		if (lapar + 5>MAX) ngantuk = MAX;
		else lapar += 5;
		if (ngantuk + 2>MAX) ngantuk = MAX;
		else ngantuk += 2;
	}

	
};


int main()
{
	tamagochi pet;
	int menu;
	pet.instalasi();
	while (1)
	{
		system("cls");
		cout << "1. Makan" << endl;
		cout << "2. Main" << endl;
		cout << "3. Tidur" << endl;
		cout << "4. Suntik" << endl;
		cout << "5. Lihat peliharaan" << endl;
		cout << "0. Exit" << endl;
		cout << "-------------------------" << endl;
		cout << "Silahkan pilih menu dengan nomor > ";
		cin >> menu;
		if (menu == 1)
		{
			system("cls");
			pet.makan();
		}
		else if (menu == 2)
		{
			system("cls");
			pet.bermain();
		}
		else if (menu == 3)
		{
			system("cls");
			pet.tidur();
		}
		else if (menu == 4)
		{
			system("cls");
			pet.suntik();
		}
		else if (menu == 5)
		{
			system("cls");
			pet.view();
		}
		else if (menu == 0)
		{
			break;
		}
		else cout << "Salah input" << endl;
		system("pause");

	}
    return 0;
}



