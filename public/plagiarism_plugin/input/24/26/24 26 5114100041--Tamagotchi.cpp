#include <iostream>
#include <string>

using namespace std;

class Pet
{
public:
	//atribut
	string name;
	string breed;
	int healthiness = 100,
		happiness = 100,
		hygiene = 100,
		food = 0;

	//constructor (record(?))
	void Eat(int amount)
	{
		food += amount;
		healthiness -= amount;
		happiness++;
		hygiene--;
	}

	void Play(int amount)
	{
		food -= amount;
		healthiness -= amount;
		happiness++;
		hygiene--;
	}

	void Bath(int amount)
	{
		food--;
		healthiness++;
		happiness++;
		hygiene += amount;
	}

	void Sleep(int amount)
	{
		food -= amount;
		healthiness += amount;
		happiness++;
		hygiene--;
	}

	void Stat()
	{
		cout << "\tName: " << name << endl << "\tHealthiness: " << healthiness << endl << "\tHappiness: " << happiness << endl << "\tHygiene: " << hygiene << endl;
	}
};

int main()
{
	int i,
		pilihan,
		menu,
		nomer,
		berat,
		jumlah = 0;

	Pet dog[100];

	cout << "Hello World of Dogs" << endl;
	cout << "1. New Game" << endl;
	cout << "0. Exit" << endl;
	cin >> pilihan;
	cin.get();
	if (pilihan == 1)
	{
		cout << endl << "Give a name for your pet ~ ";
		getline(cin, dog[jumlah].name);
		
		cout << "1. ";
		dog[jumlah].Stat();
		
		cout << endl << "1. Feed" << endl;
		cout << "2. Game" << endl;
		cout << "3. Take a Bath" << endl;
		cout << "4. Take a Sleep" << endl;
		cout << "5. New Pet" << endl;
		cout << "0. Exit" << endl;
		cout << "choose menu --> ";
		cin >> menu;
		cout << endl;

		while (menu != 0)
		{
			if (menu == 1)
			{
				cout << "Which pet do you want to give some food? Enter the number list pet... ";
				cin >> nomer;
				cout << endl << "Determine your amount of food --> ";
				cin >> berat;
				dog[nomer-1].Eat(berat);
			}
			if (menu == 2)
			{
				cout << "Which pet do you want to play... ";
				cin >> nomer;
				cout << endl << "Determine your amount of mood about the game --> ";
				cin >> berat;
				dog[nomer-1].Play(berat);
			}
			if (menu == 3)
			{
				cout << "Which pet do you want to take a bath... ";
				cin >> nomer;
				cout << endl << "Determine your amount of bathing --> ";
				cin >> berat;
				dog[nomer-1].Bath(berat);
			}
			if (menu == 4)
			{
				cout << "Which pet do you to take some sleep... ";
				cin >> nomer;
				cout << endl << "Determine your amount of sleeping --> ";
				cin >> berat;
				dog[nomer-1].Sleep(berat);
			}
			if (menu == 5)
			{
				for (i = 0; i <= jumlah; i++)
				{
					dog[i].Eat(10);
					dog[i].Sleep(10);
					dog[i].Play(10);
					dog[i].Bath(10);
				}
				jumlah++;
				cin.get();
				cout << endl << "Give a name for your pet ~ ";
				getline(cin, dog[jumlah].name);
			}

			cout << endl;
			for (i = 0; i <= jumlah; i++)
			{
				cout << i+1 << ". ";
				dog[i].Stat();
			}
			cout << endl << "Menu" << endl;
			cout << "1. Feed" << endl;
			cout << "2. Game" << endl;
			cout << "3. Take a Bath" << endl;
			cout << "4. Take a Sleep" << endl;
			cout << "5. New Pet" << endl;
			cout << "0. Exit" << endl;
			cout << "choose menu --> ";
			cin >> menu;
			cout << endl;
		}
	}

	system("pause");

	return 0;
}