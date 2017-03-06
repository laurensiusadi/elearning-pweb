#include <iostream>
#include <string>
#include <Windows.h>
using namespace std;
class Pet
{
public:
	string name;
	string breed;
	int exp;
	int maxExp;
	int level;
	int hunger;
	// constructor
	Pet()
	{

	}

	void Pilihan()
	{


		int input;
		cout << "[1]makan\n[2]latihan\n[3]main\n";
		cin >> input;
		if (input == 1)
		{
			Makan();
		}
		else if (input == 2)
		{
			Latihan();
		}
		else if (input == 3)
		{
			Bermain();
		}

	}
	void Makan()
	{
		system("cls");
		if (hunger < 100)
		{
			hunger = hunger + 10;
			cout << "Terima kasih tuan\n";

		}
		else
		{
			cout << "Huek aku kenyang";
			hunger = hunger - 5;

		}
		system("pause");
		Stat();
		Pilihan();
	}
	void Stat()
	{
		system("cls");
		cout << "NAME: " << name << "\n";
		cout << "Exp: " << exp << "/" << maxExp << "\n";
		cout << "Level: " << level << "\n";
		cout << "hunger: " << hunger << "\n";
	}
	void Levelup()
	{
		level = level + 1;
		maxExp = level * 100;
		if (hunger - 20<0)
		{
			hunger = 0;
		}
		else
		{

			hunger = hunger - 20;
		}
		cout << "selamaaat pet mu naik level\n";
		system("pause");
	}
	void Nama()
	{
		cout << "Masukkan nama petmu: ";
		getline(cin, name);
	}
	void Latihan()
	{
		system("cls");
		if (hunger - 10<0)
		{
			cout << "aku lapar tuan beri aku makan\n";
			system("pause");
		}
		else
		{


			if (exp + 10<maxExp)
			{
				exp = exp + 10;
				hunger = hunger - 10;
				cout << "horee\n";
				system("pause");
			}
			else
			{
				Levelup();
			}
		}
		Stat();
		Pilihan();
	}
	void Bermain()
	{
		system("cls");
		if (hunger - 5<0)
		{
			cout << "aku lapar tuan beri aku makan\n";
			system("pause");
		}
		else
		{


			if (exp + 5< maxExp)
			{
				exp = exp + 5;
				hunger = hunger - 5;
				cout << "horee\n";
				system("pause");
			}
			else
			{
				Levelup();
			}
		}

		Stat();
		Pilihan();
	}
	void Inisialisasi()
	{
		maxExp = 100;
		exp = 0;
		level = 1;
		hunger = 50;
	}
};
int main()
{
	Pet dog, dog2;
	cout << "SELAMAT DATANG!" << endl;
	dog.Nama();
	dog.Inisialisasi();
	dog.Stat();
	dog.Pilihan();



	return 0;

}
