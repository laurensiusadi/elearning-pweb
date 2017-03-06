// PBO-Tugas2.cpp : Defines the entry point for the console application.
//TSW

#include "stdafx.h"
#include <iostream>
using namespace std;

class TEP
{
public:
	int energi, kebersihan, lapar;
	char nama[20];

	void playing()
	{
		energi -= 2;
		lapar += 1;
		kebersihan -= 1;
	}

	void eat()
	{
		energi -= 1;
		lapar -= 2;
	}

	void bath()
	{
		kebersihan += 3;
		energi -= 1;
	}

	void rest()
	{
		energi += 3;
		lapar -= 1;
	}

	void status_pet()
	{
		cout << "Energi = " << energi << "\n";
		cout << "Kebersihan = " << kebersihan << "\n";
		cout << "Tingkat Kelaparan = " << lapar << "\n";
	}

	void reset()
	{
		if (kebersihan < 0) kebersihan = 0;
		if (lapar < 0) lapar = 0;
	}
};

int menu(char name[])
{
	int choice;
	cout << "Yuk kita ajak main si " << name << ". Apa yang harus kita lakukan bersama?\n";
	cout << "1. Main\n2. Makan\n3. Istirahat\n4. Mandi\n5. Status\n";
	cin >> choice;
	return choice;
}

int main()
{
	TEP pet;
	cout << "Haloo selamat datang di permainan tamagotchi. Masukan nama pet kalian : ";
	cin >> pet.nama;
	pet.energi = pet.kebersihan = 10;
	pet.lapar = 0;
	while (pet.energi > 0)
	{
		switch (menu(pet.nama))
		{
		case 1:
			pet.playing();
			pet.reset();
			break;
		case 2:
			pet.eat();
			pet.reset();
			break;
		case 3:
			pet.rest();
			pet.reset();
			break;
		case 4:
			pet.bath();
			pet.reset();
			break;
		case 5:
			pet.status_pet();
			pet.reset();
			break;
		}
	}

	cout << pet.nama << " terlalu lelah untuk bermain bersama kalian, datang lagi esok hari ya :)\n";
	system("pause");
	return 0;
}