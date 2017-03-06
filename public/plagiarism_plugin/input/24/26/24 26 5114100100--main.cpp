#include <iostream>
#include <string>
#include <cstdlib>
using namespace std;

class Pet
{
public:
	string name, owner, pet;
	int health,
		hunger,
		stamina,
		cleanliness;

	Pet()
	{

	}

	void Medicine()
	{
		health = health + 5;
		hunger = hunger - 5;
		if (health > 100)
		{
			health = 100;
		}
		if (hunger < 0)
		{
			hunger = 0;
		}
		cout << name << " eat some medicine...\n\n";
	}

	void Sleep()
	{
		stamina = stamina + 5;
		health = health - 5;
		if (stamina > 100)
		{
			stamina = 100;
		}
		if (health < 0)
		{
			health = 0;
		}
		cout << name << " sleep for a bit...\n\n";
	}

	void Eat()
	{
		hunger = hunger + 5;
		cleanliness = cleanliness - 5;
		if (hunger > 100)
		{
			hunger = 100;
		}
		if (cleanliness < 0)
		{
			cleanliness = 0;
		}
		cout << name << " eat Hamburger...\n\n";
	}

	void Shower()
	{
		cleanliness = cleanliness + 5;
		stamina = stamina - 5;
		if (cleanliness > 100)
		{
			cleanliness = 100;
		}
		if (stamina < 0)
		{
			stamina = 0;
		}
		cout << name << " take a shower...\n\n";
	}
};

int main()
{
	cout << "Hello there! Welcome to the world of Tamagochi!\n";

	int choice;
	Pet tamagochi;
	
	cout << "Enter your name : ";
	getline(cin, tamagochi.owner);
	cout << "Enter your pet's name : ";
	getline(cin, tamagochi.name);
	
	tamagochi.health = rand() % 70 + 30;
	tamagochi.hunger = rand() % 70 + 30;
	tamagochi.stamina = rand() % 70 + 30;
	tamagochi.cleanliness = rand() % 70 + 30;

	cout << "\n";

	cout << "Hi " << tamagochi.owner << "! Now, I will tell you ";

	while (true)
	{
		cout << "" << tamagochi.name << "'s current status :\n";
		cout << "(*) Health	: " << tamagochi.health << "%\n";
		cout << "(*) Stamina	: " << tamagochi.stamina << "%\n";
		cout << "(*) Hunger	: " << tamagochi.hunger << "%\n";
		cout << "(*) Cleanliness	: " << tamagochi.cleanliness << "%\n";

		cout << "\n";
		cout << "What would you like to do ?\n";
		cout << "1. Give " << tamagochi.name << " some medicine\n";
		cout << "2. Make " << tamagochi.name << " sleep\n";
		cout << "3. Give " << tamagochi.name << " some food\n";
		cout << "4. Give " << tamagochi.name << " a bath\n";
		cout << "5. Exit Game\n";
		cout << "Enter your choice : ";
		cin >> choice;
		system("CLS");

		if (choice == 1)
		{
			tamagochi.Medicine();
		}
		else if (choice == 2)
		{
			tamagochi.Sleep();
		}
		else if (choice == 3)
		{
			tamagochi.Eat();
		}
		else if (choice == 4)
		{
			tamagochi.Shower();
		}
		else if (choice == 5)
		{
			break;
		}
		else
		{
			cout << "Invalid input!\n\n";
		}
	}

	getchar();
	return 0;
}