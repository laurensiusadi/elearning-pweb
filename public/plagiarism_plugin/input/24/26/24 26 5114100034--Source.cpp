#include<iostream>
#include<string>
using namespace std;
class Pet
{
public:
	string name;
	int age;
	int health;
	int hunger;
	int happiness;
	int energy;

	Pet()
	{
	}

	void init()
	{
		energy = 50;
		happiness = 50;
		health = 50;
		hunger = 50;
	}

	void sleep()
	{
		energy += 3;
		happiness -= 2;
		health -= 2;
		hunger += 2;
		cout << endl << name << " is sleeping!\n\n";
	}

	void feed()
	{
		hunger -= 3;
		energy -= 2;
		happiness -= 2;
		health -= 2;
		cout << endl << name << " is enjoying the food!\n\n";
	}

	void play()
	{
		happiness += 3;
		energy -= 2;
		health -= 2;
		hunger += 2;
		cout << endl << name << " is playing!\n\n";
	}

	void exercise()
	{
		health += 3;
		energy -= 2;
		happiness -= 2;
		hunger += 2;
		cout << endl << name << " is now more healthy\n\n";
	}

	void stat()
	{
		cout << "\nEnergy\t\t: " << energy << "\n";
		cout << "Hunger\t\t: " << hunger << "\n";
		cout << "Happiness\t: " << happiness << "\n";
		cout << "Health\t\t: " << health << "\n\n";
	}
};
int main()
{
	int option;
	Pet cat;
	cat.init();
	cout << "Welcome!" << endl;
	cout << "Create your pet's name: ";
	cin >> cat.name;
	cout << "Enter you pet's age: ";
	cin >> cat.age;

	while (cat.energy > 30 && cat.happiness > 30 && cat.health > 30 && cat.hunger > 30)
	{
		cout << "1. Sleep\n2. Eat\n3. Play\n4. Exercise\n5. Show Status\n";
		cout << "Choose an action: ";
		cin >> option;

		switch (option)
		{
			case 1:
			{
				cat.sleep();
				break;
			}
			case 2:
			{
				cat.feed();
				break;
			}
			case 3:
			{
				cat.play();
				break;
			}
			case 4:
			{
				cat.exercise();
				break;
			}
			case 5:
			{
				cat.stat();
				break;
			}
		}
	}
	cout << cat.name << " is dead! :(" << endl;
	system("PAUSE");
	return 0;
}