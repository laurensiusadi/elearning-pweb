#include <iostream>
#include <stdlib.h>
#include <string>

using namespace std;

class tama
{
public:
	string name;
	int health;
	int happiness;
	int hunger;
	int expi;
	int LVL;
	int tired;
	int level = 0;

	tama(){}

	void eating() {
		health = health + 15;
		hunger = hunger - 25;
		if ((health > 100) && (hunger < 0))
		{
			health = 100;
			hunger = 0;
		}
		system("pause");
		system("cls");
	}
	void levelling() {
		cout << endl;
		health = health - (0.1*health);
		tired = tired + 12;
		hunger = hunger + 20;
		level += expi;
		cout << "exp : " << level << endl;
		if (hunger > 60)
			cout << "Becareful, your pet is hungry !!" << endl;
		if (tired > 50) {
			cout << "Becareful, your pet is too tired for levelling!!" << endl;
			happiness = happiness - 10;
			}
		if (level % 600 == 0)
		{
			LVL++;
			cout << "level up " << LVL << "!!! good work , keep training!!" << endl;
			system("pause");
			system("cls");
		}
		cout << "HP : " << health << endl;
	}
	void playing() {
		cout << "yeeeeeeee ............ zzzzzzzz" << endl;
		happiness = happiness + 15;
		hunger = hunger - 5;
		cout << "go on" << endl;
		system("pause");
	}
	void resttime() {
		cout << "wow" << endl;
		cout << "just wait for a moment" << endl;
		tired = tired - 45;
		if (tired < 0)
			tired = 0;
		system("pause");
	}
	void status() {
		cout << "-------------Your Pet Status------------" << endl;
		cout << "| Health : " << health << "| Level : " << level
			<< "| Happiness : " << happiness << "| Hunger level : " << hunger << "| Tired level : " << tired << endl;
		system("pause");
		//system("cls");
	}
};

int main() {
	int pilihan;
	char x[20];
	tama first; 
	first.expi = 150;
	first.LVL = 0;
	first.happiness = 100;
	first.hunger = 0;
	first.health = 100;
	first.tired = 0;
	cout << "---------WELCOME---------" << endl;
	cout << "pick the name first :";
	cin >> x;
	do {
		cout << "|||--------WELCOME TO TAMAGOTCHI GAME--------|||" << endl
			<< "|||-----------------ENJOY IT!----------------|||" << endl;
		cout << "what do you want?" << endl << "1. eat" << endl << "2. level up" << endl
			<< "3. rest" << endl << "4. playing" << endl << "5. Status" << endl << "0. Exit" << endl
			<< "-->";
		cin >> pilihan;

		if (pilihan == 1) {
			first.eating();
		}
		if (pilihan == 2)
		{
			first.levelling();
		}
		if (pilihan == 3)
		{
			first.resttime();
		}
		if (pilihan == 4) {
			first.playing();
		}
		if (pilihan == 5) {
			first.status();
		}
	} while (pilihan != 0);
	return 0;
}