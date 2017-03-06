#include <iostream>
#include <string>
#include <time.h>
#include <stdlib.h>
using namespace std;

class Petstat
{
public:
	string nama;
	int mandi;
	int makan;
	int main;
	int obat;
	int tidur;
	int koin;

	Petstat() {
	}

	void Menupet(Petstat pets)
	{
		cout << pets.nama << "'s status:\nCleanness : " << pets.mandi << "\nHunger : " << pets.makan << "\nHappiness : " << pets.main << "\nHealthy : " << pets.obat << "\nSleepy : " << pets.tidur << "\n\nYour coin: " << pets.koin << "\n\n";
	}

	void Stat()
	{
		if (pets.mandi <= 3)
		{
			cout << pets.nama << " is smell! Please clean it now!\n";
		}
		if (pets.makan <= 2)
		{
			cout << pets.nama << " is hungry. Feed it.\n";
		}
		if (pets.main <= 4)
		{
			cout << pets.nama << " feels lonely :(. Play with him/her now.\n";
		}
		if (pets.obat <= 3)
		{
			cout << pets.nama << " is sick! Give him/her medicine now!\n";
		}
		if (pets.tidur <= 2)
		{
			cout << pets.nama << " is sleepy. Let him/her sleep.\n";
		}
	}

	void Petmandi()
	{
		if (pets.mandi + 2 <= 10)
		{
			pets.mandi += 2;
		}
		if (pets.makan - 2 >= 0)
		{
			pets.makan -= 2;
		}
		if (pets.main + 4 <= 10)
		{
			pets.main += 2;
		}
		if (pets.obat - 1 >= 0)
		{
			pets.obat--;
		}
		if (pets.tidur + 2 <= 10)
		{
			pets.tidur += 2;
		}
		if (pets.koin + 1 <= 10)
		{
			pets.koin++;
		}
		/*cout << "\nYou got a coin!!!\n";*/
		cout << "Your pet is clean now.\n\n";
	}

	void Petmakan()
	{
		if (pets.mandi + 3 <= 10)
		{
			pets.mandi += 3;
		}
		if (pets.makan + 4 <= 10)
		{
			pets.makan += 4;
		}
		if (pets.obat + 1 <= 10)
		{
			pets.obat++;
		}
		if (pets.main - 2 >= 0)
		{
			pets.main -= 2;
		}
		if (pets.tidur - 2 >= 0)
		{
			pets.tidur -= 2;
		}
		if (pets.koin - 2 >= 0)
		{
			pets.koin -= 2;
		}
		cout << "You eat with your pet, your pet is full now.\n\n";
	}

	void Petmain()
	{
		if (pets.mandi - 2 >= 0)
		{
			pets.mandi -= 2;
		}
		if (pets.makan - 4 >= 0)
		{
			pets.makan -= 4;
		}
		if (pets.obat - 1 >= 0)
		{
			pets.obat--;
		}
		if (pets.main + 3 <= 10)
		{
			pets.main += 3;
		}
		if (pets.tidur - 3 >= 0)
		{
			pets.tidur -= 3;
		}
		if (pets.koin + 5 <= 10)
		{
			pets.koin += 5;
		}
		/*cout << "\nYeay! You got more coins!!!\n\n";*/
		cout << "You play with your pet, your pet feels happy.\n\n";
	}

	void Petobat()
	{
		if (pets.mandi - 3 >= 0)
		{
			pets.mandi -= 3;
		}
		if (pets.makan + 1 <= 10)
		{
			pets.makan++;
		}
		if (pets.obat + 4 <= 10)
		{
			pets.obat += 4;
		}
		if (pets.main - 2 >= 0)
		{
			pets.main -= 2;
		}
		if (pets.tidur - 3 >= 0)
		{
			pets.tidur -= 3;
		}
		if (pets.koin - 3 >= 0)
		{
			pets.koin -= 3;
		}
		cout << "Your pet is healthy.\n\n";
	}

	void Petidur()
	{
		if (pets.mandi - 3 >= 0)
		{
			pets.mandi -= 3;
		}
		if (pets.makan - 3 >= 0)
		{
			pets.makan -= 3;
		}
		if (pets.obat + 1 <= 10)
		{
			pets.obat++;
		}
		if (pets.main - 2 >= 0)
		{
			pets.main -= 2;
		}
		if (pets.tidur + 5 <= 10)
		{
			pets.tidur += 5;
		}
		if (pets.koin + 2 <= 10)
		{
			pets.koin += 2;
		}
		/*cout << "\nYeay! You got more coins!!!\n\n";*/
		cout << "Your pet is sleep now. Don't be noisy.\n\n";
	}
};

int main()
{
	Petstat pet;
	int nilai = 1, menu;
	cout << "*************** WELCOME ***************\n";
	cout << "Insert your pet's name: ";
	cin >> pet.nama;
	
	srand(time(NULL));
	pet.Petmandi = rand() % 11;
	pet.Petmakan = rand() % 11;
	pet.Petmain = rand() % 11;
	pet.Petobat = rand() % 11;
	pet.Petidur = rand() % 11;
	pet.koin = 0;
	
	cout << "Your pet's name is " << pet.nama << "\n\n";
	pet.Menupet(pet);

	while (nilai == 1)
	{
		cout << "\nWhat do you want to do with your pet?\n";
		cout << "1. Clean your pet\n";
		cout << "2. Feed your pet\n";
		cout << "3. Play with your pet\n";
		cout << "4. Give medicine to your pet\n";
		cout << "5. Let it sleep\n";
		cout << "6. Exit\n";
		cout << "\nInsert your option : ";

		cin >> menu;
		if (menu == 1)
		{
			pet.Petmandi();
		}
		else if (menu == 2)
		{
			pet.Petmakan();
		}
		else if (menu == 3)
		{
			pet.Petmain();
		}
		else if (menu == 4)
		{
			pet.Petobat();
		}
		else if (menu == 5)
		{
			pet.Petidur();
		}
		else if (menu == 6)
		{
			nilai = 0;
			cout << "\n*************** YOU LEAVE " << Pet.nama << "***************\n" << endl;
		}
	}
	cout << "\n*************** GAME OVER ***************\n";

	cin.get();
}