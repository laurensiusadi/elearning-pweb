#include <iostream>
#include <string>

using namespace std;

class Pet
{
public:
	string name;
	int health;
	int hunger;
	int hygiene;
	int happiness;

	Pet()
	{
	}

	void Stat()
	{
		cout << "Name: " << name << "\nHunger\t\t: " << hunger << "\nHealth\t\t: " << health << "\nHappiness\t: " << happiness << "\nHygiene\t\t: " << hygiene << "\n";
	}

	void Eat()
	{
		hunger += 10;
		health -= 7;
		happiness++;
		hygiene--;
	}

	void Sleep()
	{
		health += 10;
		hunger -= 7;
		happiness++;
		hygiene--;

	}

	void Play()
	{
		happiness += 10;
		hunger -= 7;
		health -= 7;
		hygiene--;
	}

	void Shower()
	{
		hygiene += 10;
		hunger -= 7;
		health -= 7;
		happiness++;
	}
};

int main()
{
	int choice = 0;

	Pet hewan;
	cout << "Welcome to Tamagochi\n";
	cout << "What is your pet name? ";
	cin >> hewan.name;

	hewan.happiness = rand() % 100;
	hewan.hunger = rand() % 100;
	hewan.health = rand() % 100;
	hewan.hygiene = rand() % 100;

	while (choice != 6)
	{
		cout << "\nWhat do you want to do with your pet?\n";
		cout << "1. Eat\n";
		cout << "2. Sleep\n";
		cout << "3. Play\n";
		cout << "4. Shower\n";
		cout << "5. Status\n";
		cout << "6. End the game\n";
		cout << "Your step : ";
		cin >> choice;

		if (choice == 1)
		{
			hewan.Eat();
		}
		else if (choice == 2)
		{
			hewan.Sleep();
		}
		else if (choice == 3)
		{
			hewan.Play();
		}
		else if (choice == 4)
		{
			hewan.Shower();
		}
		else if (choice == 5)
		{
			hewan.Stat();
		}
	}
	
	cin.get();
}