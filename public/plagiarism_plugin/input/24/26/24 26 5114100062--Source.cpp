#include <iostream>
#include <string>
using namespace std;

int pilih;

class pet
{
	public:
		string name;
	int healthiness, happiness, hunger;

	void start()
	{
		cout << "nama: " << name << "| Hunger= " <<
			hunger << " | Healthiness=" << healthiness <<
			"| Happiness=" << happiness << endl;
	}

	void eat(int amount)
	{
		hunger += amount;
		healthiness -= amount;
		happiness++;
	}

	void sleep(int amount)
	{
		hunger -= amount;
		healthiness += amount;
		happiness--;
	}

	void play(int amount)
	{
		hunger -= amount;
		healthiness -= amount;
		happiness++;
	}

};

int main()
{
	cout << "Selamat datang di Tamagochi!" << endl;
	pet cat;
	cat.name = "Lucha";
	cout << endl;
	cat.happiness = 100;
	cat.hunger = 0;
	cat.healthiness = 100;

	while (!0)
	{
		cout << "Pilih menu" << endl;
		cout << "1. Beri Makan" << endl;
		cout << "2. Ajak Main" << endl;
		cout << "3. Tidur" << endl;

		cin >> pilih;
		if (pilih == 1) cat.eat(10);
		else if (pilih == 2) cat.play(10);
		else if (pilih == 3) cat.sleep(10);
		cat.start();
	}

	return 0;
}