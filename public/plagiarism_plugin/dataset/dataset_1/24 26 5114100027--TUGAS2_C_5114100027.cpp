#include <iostream>
#include <string>
#define clear system ("cls");
using namespace std;

class Pet
{
public:
	//buat atributnya
	string name;
	string type;
	int healthy = 50;
	int mood = 50;
	int hygiene = 50;
	int hunger = 0;
	int energi = 50;

	//constructor
	Pet()
	{

	}
	void Eating()
	{
		hunger += 10;
		hygiene -= 10;
		mood += 10;
	}

	void Sleeping()
	{
		hunger -= 10;
		healthy += 10;
		mood += 10;
	}

	void Playing()
	{
		hunger -= 10;
		mood += 10;
		hygiene -= 10;
	}

	void TakeABath()
	{
		healthy += 10;
		mood += 10;
		hygiene += 10;
	}

	void Stat()
	{
		cout << "Name:" << name << "\nHealthiness:" << healthy << "\nHappiness:" << mood << "\nHygiene:" << hygiene << "\nEnergy:" << energi << "\nHunger:" << hunger << endl;
	}

	void commands()
	{
		int command;
		while (1)
		{

			clear;
			Stat();
			cout << "\nWhat do you want to do?\n";
			cout << "1. Eating\n";
			cout << "2. Sleeping\n";
			cout << "3. Playing\n";
			cout << "4. Take a bath\n";
			cout << "5. Quit\n";
			cin >> command;
			if (hygiene == 0 && energi == 0 && mood == 0 && healthy == 0)
			{
				cout << "GAME OVER\n";
				break;
			}
			if (hygiene < 0 && energi < 0 && mood < 0 && healthy < 0)
			{
				cout << "GAME OVER\n";
				break;
			}

			if (command == 1)
			{
				cout << "Nyam-Nyam" << endl;
				Eating();
				if (hygiene == 0 && energi == 0 && mood == 0 && healthy == 0)
				{
					cout << "GAME OVER\n";
					break;
				}
				if (hygiene < 0 && energi < 0 && mood < 0 && healthy < 0)
				{
					cout << "GAME OVER\n";
					break;
				}
			}
			else if (command == 2)
			{
				Sleeping();
				cout << "ZZZZzzzzz" << endl;
				if (hygiene == 0 && energi == 0 && mood == 0 && healthy == 0)
				{
					cout << "GAME OVER\n";
					break;
				}
				if (hygiene < 0 && energi < 0 && mood < 0 && healthy < 0)
				{
					cout << "GAME OVER\n";
					break;
				}
			}

			else if (command == 3)
			{
				Playing();
				cout << "Yeayyy, I'm playing" << endl;
				if (hygiene == 0 && energi == 0 && mood == 0 && healthy == 0)
				{
					cout << "GAME OVER\n";
					break;
				}
				if (hygiene < 0 && energi < 0 && mood < 0 && healthy < 0)
				{
					cout << "GAME OVER\n";
					break;
				}
			}
			else if (command == 4)
			{
				TakeABath();
				cout << "jebar-jebur" << endl;
				if (hygiene == 0 && energi == 0 && mood == 0 && healthy == 0)
				{
					cout << "GAME OVER\n";
					break;
				}
				if (hygiene < 0 && energi < 0 && mood < 0 && healthy < 0)
				{
					cout << "GAME OVER\n";
					break;
				}
			}
			else if (command == 5)
			{
				cout << "You quit the game";
				break;
			}
			else
			{
				break;
			}
		}
	}


};

int main()
{
	int choice, command;
	cout << "==================WELCOME===================\n\n";
	cout << "                     to                     \n\n";
	cout << "============================================\n\n\n";
	cout << "*****************TAMAGOCHI******************\n\n\n";
	cout << "============================================\n\n";
	cout << "choose your pet\n";
	cout << "1. Hamster\n2. Cat\n3. Dog\n";
	cin >> choice;
	Pet peliharaan;
	if (choice == 1)
	{
		cout << "Hello, I'm a hamster\n";
		cout << "Please give me a name :";
		cin >> peliharaan.name;
		peliharaan.type = "Hamster";
		peliharaan.commands();
	}

	else if (choice == 2)
	{
		cout << "Hello, I'm a cat\n";
		cout << "Please give me a name :";
		cin >> peliharaan.name;
		peliharaan.type = "Cat";
		peliharaan.commands();
	}
	else if (choice == 3)
	{
		cout << "Hello, I'm a dog\n";
		cout << "Please give me a name :";
		cin >> peliharaan.name;
		peliharaan.type = "Dog";
		peliharaan.commands();
	}
	else
	{
		cout << "Your choice isn't available\n";
		peliharaan.commands();
	}
	peliharaan.Stat();
	cin.get();

	return 0;
}