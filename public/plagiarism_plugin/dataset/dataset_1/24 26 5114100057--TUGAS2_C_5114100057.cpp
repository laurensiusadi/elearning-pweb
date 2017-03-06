#include <iostream>
#include <string>
#include <cstdio>
#include <cstdlib>

#define clear system("cls");
#define pause {cout<<endl; system("pause");}

using namespace std;
class Pet
{

public:
	//attributes
	string name;
	int energy = 20;
	int healthiness = 20;
	int happiness = 20;
	int hygiene = 20;

	//constructor
	Pet()
	{

	}

	//behaviour
	void command()
	{
		int wot;
		while (1)
		{
			status();
			cout << endl << "What to do to add my status?";
			cout << endl << "Choose what to do!" << endl
				<< "\t1. Play\n\t2. Eat\n\t3. Bath\n\t4. Sleep\n\t5. Quit Game\n" << endl;

			if (energy < 20 && healthiness < 20 && happiness < 20 && hygiene < 20)
			{
				clear;
				cout << "Sorry, your pet already dead :(" << endl << endl;
				cout << "GAME OVER" << endl << endl << endl;

				break;
			}
			else
			{
				cin >> wot;

				if (wot == 1)
				{
					clear;
					cout << "Ahhh, I'm so happy ^^" << endl;
					energy -= 30; healthiness += 5; happiness += 25; hygiene -= 25;
				}
				else if (wot == 2)
				{
					clear;
					cout << "Nyam nyam, yummy!!" << endl;
					energy += 30; healthiness += 15; happiness += 5; hygiene -= 25;
				}
				else if (wot == 3)
				{
					clear;
					cout << "Its so fresh!!!!" << endl;
					energy -= 15; happiness -= 35; healthiness -= 40; hygiene += 25;
				}
				else if (wot == 4)
				{
					cout << "Zzzz... `" << endl;
					energy += 20; healthiness += 5; happiness -= 25; hygiene -= 35;
				}
				else
				{
					clear;
					cout << endl << "Thankyou for playing. See you :)" << endl << endl;
					break;
				}
			}
		}
	}

	void status()
	{
		clear;
		cout << "Heloo I'm " << name << ". My current status is" << endl;
		cout << "\tEnergy\t\t: " << energy << endl;
		cout << "\tHealthiness\t: " << healthiness << endl;
		cout << "\tHappiness\t: " << happiness << endl;
		cout << "\tHygiene\t\t: " << hygiene << endl;
	}
};

int main()
{
	cout << endl << endl << "\t\t<3 ~~~~~~~ <3 Hello, welcome to Tamagochi ~~~~~~~ <3" << endl << endl;
	pause;
	//instansi kelas PET menjadi object cat
	Pet cat;
	cat.name = "Cutie";
	cat.status();
	cat.command();

	return 0;
}

