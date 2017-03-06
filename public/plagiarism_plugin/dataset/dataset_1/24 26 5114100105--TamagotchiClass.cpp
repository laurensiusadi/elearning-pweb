#include <iostream>
#include <string>
#include <stdlib.h>
#include <time.h>
using namespace std;

class Pet
{
public:
	string petname;
	int happy;
	int health;
	int hunger;

	Pet()
	{
	}

	void eat()
	{
		happy += 1;
		hunger += 2;
		health -= 1;
	}

	void potion()
	{
		happy -= 1;
		health += 2;
		hunger += 1;
	}

	void play()
	{
		happy += 2;
		health += 1;
		hunger -= 1;
	}

	void stat()
	{
		cout << petname << "'s stats now is:\n";
		cout << "HAPPINESS \t :" << happy << endl;
		cout << "HEALTH \t\t :" << health << endl;
		cout << "HUNGER \t\t :" << hunger << endl;
	}
};

int main()
{
	Pet valdy;
	valdy.happy = valdy.health = valdy.hunger = 0;
	int task;
	cout << "Welcome to TAMAGOTCHI!!\n" << endl;

	cout << "First, please input your pet name >> ";
	cin >> valdy.petname;

	cout << "\nOkay, and these are " << valdy.petname << "'s stats \n";
	while (valdy.happy <= 5)
	{
		valdy.happy = rand() % 11;
		if (valdy.happy > 5)
			cout << "HAPPINESS \t : " << valdy.happy << endl;
	}
	while (valdy.health <= 5)
	{
		valdy.health = rand() % 11;
		if (valdy.health > 5)
			cout << "HEALTH \t\t : " << valdy.health << endl;
	}
	while (valdy.hunger <= 5)
	{
		valdy.hunger = rand() % 11;
		if (valdy.hunger > 5)
			cout << "HUNGER \t\t : " << valdy.hunger << endl;
	}
	cout << "\n Congratulation, " << valdy.petname << " is ready now!!\n\n\n";

	cout << "Command for your pet:\n";
	cout << "1. FEED \t (HUNGER+2, HAPPINESS+1, HEALTH-1)\n";
	cout << "2. POTION \t (HEALTH+2, HUNGER+1, HAPPINESS-1)\n";
	cout << "3. PLAY \t (HAPPINESS+2, HEALTH+1, HUNGER-1)\n";
	cout << "4. SHOW " << valdy.petname << "'s STATS" << endl;
	cout << "5. END GAME\n";

	while (1)
	{
		cout << "\nChoose what to do: \n";
		cout << ">>";
		cin >> task; cout << endl;

		if (task == 1)
		{
			valdy.eat();
		}
		else if (task == 2)
		{
			valdy.potion();
		}
		else if (task == 3)
		{
			valdy.play();
		}
		else if (task == 4)
		{
			valdy.stat();
		}
		else if (task == 5)
		{
			cout << valdy.petname << " is sleepy. Say goodbye now :)" << endl;
			break;
		}
		cout << endl;

		if (valdy.happy > 10) cout << valdy.petname << " is really happy with you :)" << endl;
		else if (valdy.happy < 5) cout << valdy.petname << " is not happy :( PLAY more with your pet" << endl;

		if (valdy.health > 10) cout << valdy.petname << " is really healthy :)" << endl;
		else if (valdy.health < 5) cout << valdy.petname << " is sick :( give your pet some POTION" << endl;

		if (valdy.hunger > 10) cout << valdy.petname << " stomach is really full :)" << endl;
		else if (valdy.hunger < 5) cout << valdy.petname << " is hungry :( FEED your pet" << endl;

		cout << "---------------------------------------------------" << endl;
	}
	cin.get();
	return 0;
}