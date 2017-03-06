#include<iostream>
#include<string>

using namespace std;

class Pet {
public:
	string name;
	int hunger;
	int bladder;
	int fun;
	int hygiene;

	void initiation() {
		hunger = 10; bladder = 5; fun = 3; hygiene = 5;
	}

	void Eat() {
		if (hunger + 5 <= 10) hunger = hunger + 5;
		else hunger = 10;
		bladder = bladder = 3; fun--;
	}

	void goToToilet() {
		bladder = 10;
		fun--; hunger = hunger - 3; hygiene = hygiene - 3;
	}

	void play() {
		if (fun != 10) fun++;
		hygiene--; hunger--;
	}

	void washIt() {
		hygiene = 10; hunger--;
		fun--;
	}

	void seeStatus() {
		cout << "Hunger	: ";
		for (int i = 0; i < hunger; i++)
			cout << "O";
		cout << endl;
		cout << "Bladder	: ";
		for (int i = 0; i < bladder; i++)
			cout << "O";
		cout << endl;
		cout << "Fun	: ";
		for (int i = 0; i < fun; i++)
			cout << "O";
		cout << endl;
		cout << "Hygiene	: ";
		for (int i = 0; i < hygiene; i++)
			cout << "O";
		cout << endl;
	}
};

int main() {
	int choose;
	cout << "Welcome to Tamagotchi Text Based!" << endl;
	Pet cat1;

	cout << "Give your pet a name: ";
	cin >> cat1.name;
	cat1.initiation();

	while (true) {
		cout << "Choose Your Treatment:" << endl <<
			"1) Feed " << cat1.name << endl <<
			"2) Go To Toilet" << endl <<
			"3) Play with " << cat1.name << endl <<
			"4) Wash " << cat1.name << endl <<
			"5) See " << cat1.name << " status" << endl <<
			"0) Quit the Game" << endl;

		cout << "Choose : " << endl;
		cin >> choose;
		if (choose == 1) cat1.Eat();
		else if (choose == 2) cat1.goToToilet();
		else if (choose == 3) cat1.play();
		else if (choose == 4) cat1.washIt();
		else if (choose == 5) cat1.seeStatus();
		else if (choose == 0) return 0;
	}
}
