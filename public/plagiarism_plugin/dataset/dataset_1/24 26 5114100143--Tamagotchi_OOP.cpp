#include <iostream>
#include <string>
#include <math.h>

using namespace std;

class Pet
{
public:
	string name;
	int level;
	int exp;
	int health;
	int fun;
	int stamina;
	int food;

	Pet(string input)
	{
		name = input;
		level = 1;
		exp = 0;
		food = 10;
		fun = 25;
		health = 20;
		stamina = 40;
	}

	void checkTreshold() {
		if (food > 100) {
			food = 100;
		}
		else if (food < 0) {
			food = 0;
		}

		if (fun > 100) {
			fun = 100;
		}
		else if (fun < 0) {
			fun = 0;
		}

		if (health > 100) {
			health = 100;
		}
		else if (health < 0) {
			health = 0;
		}

		if (stamina > 100) {
			stamina = 100;
		}
		else if (stamina < 0) {
			stamina = 0;
		}
	}

	void checkLevel() {
		if (exp == (level * 5)) {
			level++;
			exp = 0;
			cout << ">>>>>>>>>> LEVEL UP <<<<<<<<<\n";
		}
	}

	void play() {
		if (stamina > 5 && health > 8 && food > 6) {
			food -= 6;
			stamina -= 5;
			fun += 10;
			health -= 8;
			checkTreshold();
			cout << "Wooooow It's Fun master :)\n";
			exp++;
			checkLevel();
		}
		else {
			cout << "Noooo.. I'm not Okay Now :(\n";
		}
	}

	void sleep() {
		if (food > 9) {
			food -= 9;
			stamina += 12;
			fun -= 2;
			health += 2;
			checkTreshold();
			cout << "Good Night Master :)\n";
			exp++;
			checkLevel();
		}
		else {
			cout << "No..... I'm Hungry Now :(\n";
		}

	}

	void feed() {
		if (food < 95) {
			food += 11;
			stamina += 5;
			fun -= 2;
			health -= 4;
			checkTreshold();
			cout << "Yummmy :)\n";
			exp++;
			checkLevel();
		}
		else {
			cout << "Nooo..... My Stomach is Full :)\n";
		}
	}

	void medic() {
		food -= 1;
		stamina -= 3;
		fun -= 8;
		health += 15;
		checkTreshold();
		cout << "I Feel Better Now :)\n";
		exp++;
		checkLevel();
	}

	void displayStat() {
		int bar1, bar2, bar3, bar4;
		bar1 = (int)ceil((double)food / 2.5);
		bar2 = (int)ceil((double)stamina / 2.5);
		bar3 = (int)ceil((double)fun / 2.5);
		bar4 = (int)ceil((double)health / 2.5);
		cout << "\n-------------------------------\n";
		cout << "Name : " << name << "\n";
		cout << "-------------------------------\n";
		cout << "LEVEL : " << level << "\n";
		cout << "-------------------------------\n";
		cout << "Food\t : [" << food << "]\n";
		while (bar1--) {
			cout << "=";
		}
		cout << "\nStamina\t : [" << stamina << "]\n";
		while (bar2--) {
			cout << "=";
		}
		cout << "\nFun\t : [" << fun << "]\n";
		while (bar3--) {
			cout << "=";
		}
		cout << "\nHealth\t : [" << health << "]\n";
		while (bar4--) {
			cout << "=";
		}
		cout << "\n-------------------------------\n";
	}

};

int main() {

	char opsi;
	string name;
	int flag;

	cout << "Hi! ^_^ Will you adopt me?\n";
	cout << "[Y/N] : ";
	cin >> opsi;

	if (opsi != 'Y' && opsi != 'y') {
		cout << "So Sad :(\n";
		system("pause");
		flag = 0;
	}
	else {
		cout << "Give Me a Name ^_^\n";
		getchar();
		getline(cin, name);
		cout << "Woooo " << name << " sound cute! ^_^\n";
		cout << "Take Care of Me Master ^_^\n";
		system("pause");
		flag = 1;
	}

	if (flag == 1) {
		int opt;
		Pet myPet(name);

		while (1) {
			cout << "Option : \n";
			cout << "\t1. Feed\n\t2. Play\n\t3. Sleep\n\t4. Medic\n\t5. Exit\n";
			cout << "-------------------------------\n";
			cout << "Choose the Option : "; cin >> opt; cout << "\n";
			system("CLS");
			switch (opt) {
			case 1:
				myPet.feed();
				system("pause");
				myPet.displayStat();
				break;
			case 2:
				myPet.play();
				system("pause");
				myPet.displayStat();
				break;
			case 3:
				myPet.sleep();
				system("pause");
				myPet.displayStat();
				break;
			case 4:
				myPet.medic();
				system("pause");
				myPet.displayStat();
				break;
			case 5:
				cout << "Good Bye master :(\n";
				cout << "------------------------------------\n";
				system("pause");
				return 0;
			default: myPet.displayStat();
			}
		}
	}
	return 0;
}