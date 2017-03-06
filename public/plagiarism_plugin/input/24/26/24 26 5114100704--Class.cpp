#include <iostream>
#include <string.h>
#include <cstdio>

using namespace std;

class Pet
{
public:

	string name;
	int happiness;
	int energy;
	int hygine;
	int hunger;
	int healthness;

	Pet() {
	}

	void Eat() {
		hunger += 15;
		healthness += 10;
		hygine -= 5;
		energy += 5;
	}

	void Play() {
		happiness += 10;
		energy -= 10;
	}

	void TakeABath() {
		hygine += 10;
		energy -= 5;
	}

	void Sleep() {
		hunger -= 5;
		energy += 10;
	}

	void State() {
		hunger = 30;
		healthness = 30;
		hygine = 30;
		energy = 30;
		happiness = 30;
	}

	void printState() {
		cout << "energy = " << energy << endl << "hygine = " << hygine << endl << "healthness = " << healthness << endl << "hunger = " << hunger << endl << "happines = " << happiness << endl;
	}
};

int main()
{
	Pet cat;
	cout << "--------------------------\n" << endl;
	cout << "Welcome To Tamagotchi\n" << endl;
	cout << "write the name of your cat" << endl;
	scanf("%s", cat.name);
	cout << "What Do You Want ??" << endl;

	cat.State();
	int option;
	cout << "1. FOOD | 2. PLAY | 3. TAKE A BATH | 4.SLEEP | 5.CONDITION" << endl;
	while (cin >> option) {
		if (cat.energy >= 10 && cat.hygine >= 10 && cat.happiness >= 10 && cat.hunger >= 10 && cat.happiness >= 10) {
			if (option == 1) {
				cat.Eat();
				cout << "yeayy.. YUMMY!" << endl;
			}
			else if (option == 2) {
				cat.Play();
				cout << "I'TS FUN!" << endl;
			}
			else if (option == 3) {
				cat.TakeABath();
				cout << "cool...I'M HAPPY!" << endl;
			}
			else if (option == 4) {
				cat.Sleep();
				cout << "I'm so Tired" << endl;
			}
			else if (option == 5) {
				cat.printState();
			}
			else {
				cout << "Not found !" << endl;
				break;
			}
		}

		else {
			cout << "Your pet is Died " << endl;
		}
	}

	return 0;
}