#include <iostream>
#include <string>
using namespace std;

class pet
{
public:
	string name;
	int type;
	int hunger;
	int happiness;
	int health;

	void play()
	{
		happiness = happiness + 20;
		if (happiness > 100)
		{
			happiness = 100;
		}
		hunger = hunger - 15;
		health = health - 5;
	}

	void eat()
	{
		hunger = hunger + 25;
		if (hunger > 100)
		{
			hunger = 100;
		}
		happiness = happiness - 10;
		if (happiness < 0)
		{
			happiness = 0;
		}
	}

	void jogging()
	{
		health = health + 10;
		if (health > 100)
		{
			health = 100;
		}
		hunger = hunger - 20;
		happiness = happiness + 10;
		if (happiness > 100)
		{
			happiness = 100;
		}
	}

	void sleep()
	{
		health = health + 10;
		if (health > 100)
		{
			health = 100;
		}
		hunger = hunger - 20;
		happiness = happiness + 10;
		if (happiness > 100)
		{
			happiness = 100;
		}
	}

	void cure()
	{
		health = health + 40;
		if (health > 100)
		{
			health = 100;
		}
		hunger = hunger - 10;
		happiness = happiness - 10;
		if (happiness < 0)
		{
			happiness = 0;
		}
	}

	void stats()
	{
		cout << "\n----------------\nPet's Statistics\n----------------\n" << endl;
		cout << "Name\t\t: " << name;
		if (type == 1)
		{
			cout << "\nType\t\t: Dragon" << endl;
		}
		else if (type == 2) {
			cout << "\nType\t\t: Bird" << endl;
		}
		else if (type == 3) {
			cout << "\nType\t\t: Pig" << endl;
		}
		else if (type == 4) {
			cout << "\nType\t\t: Mouse" << endl;
		}
		else {
			cout << "\nType\t\t: Anoa" << endl;
		}
		cout << "Hunger\t\t: " << hunger << "\nHappiness\t: " << happiness << "\nHealth\t\t: " << health << "\n" << endl;
	}
};

int main()
{
	int act;
	pet mine;
	mine.hunger = 100;
	mine.happiness = 100;
	mine.health = 100;

	cout << "1. Dragon\n2. Bird\n3. Pig\n4. Monkey\n5. Anoa\nWhich pet do you want? ";
	cin >> mine.type;

	cout << "Enter your pet's name: ";
	cin >> mine.name;

	while (1)
	{
		cout << "\n1. Play\n2. Eat\n3. Jogging\n4. Sleep\n5. Cure\nWhat would you do with your pet? " << endl;
		cin >> act;

		if (act == 1)
		{
			mine.play();
			if (mine.hunger <= 0)
			{
				cout << "GAME OVER BRO!!!\n" << endl;
				break;
			}
			if (mine.health <= 0)
			{
				cout << "GAME OVER BRO!!! DEAD!!!\n" << endl;
				break;
			}
		}

		else if (act == 2)
		{
			mine.eat();
		}

		else if (act == 3)
		{
			mine.jogging();
			if (mine.hunger <= 0)
			{
				cout << "GAME OVER BRO!!!\n" << endl;
				break;
			}
		}

		else if (act == 4)
		{
			mine.sleep();
			if (mine.hunger <= 0)
			{
				cout << "GAME OVER BRO!!!\n" << endl;
				break;
			}
		}

		else if (act == 5)
		{
			mine.cure();
			if (mine.hunger <= 0)
			{
				cout << "GAME OVER BRO!!!\n" << endl;
				break;
			}
		}

		else
		{
			cout << "Enter the right input!\n" << endl;
		}

		cout << "\n----------------\nPet's Statistics\n----------------\n" << endl;
		cout << "Name\t\t: " << mine.name;
		if (mine.type == 1)
		{
			cout << "\nType\t\t: Dragon" << endl;
		}
		else if (mine.type == 2) {
			cout << "\nType\t\t: Bird" << endl;
		}
		else if (mine.type == 3) {
			cout << "\nType\t\t: Pig" << endl;
		}
		else if (mine.type == 4) {
			cout << "\nType\t\t: Mouse" << endl;
		}
		else {
			cout << "\nType\t\t: Anoa" << endl;
		}
		cout << "Hunger\t\t: " << mine.hunger << "\nHappiness\t: " << mine.happiness << "\nHealth\t\t: " << mine.health << "\n" << endl;

	}
}