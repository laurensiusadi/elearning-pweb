#include <iostream>
#include <string>
using namespace std;

class tama{
public:
	int happy, health, hunger;
	string nama;

	tama(){

	}

	void play(){
		cout << "You have played with " << nama << "!\n";
		if (happy<10)
			happy += 1;
		if (health>0)
			health -= 1;
		if (hunger<9)
			hunger += 2;
		else if (hunger == 10)
			health -= 3;
		else if (hunger == 9)
			hunger += 1;
	}

	void feed(){
		cout << nama << " have been fed!\n";
		if (happy>0)
			happy -= 1;
		if (health<10)
			health += 1;
		if (hunger == 10)
			health -= 3;
		else
			hunger -= 2;
	}

	void sleep(){
		cout << nama << " just woke up!\n";
		if (happy>0)
			happy -= 1;
		if (health<9)
			health += 2;
		if (hunger == 10)
			health -= 3;
		else if (hunger<9)
			hunger += 2;
		else if (hunger == 9)
			hunger += 1;
	}

	void nothing(){
		cout << "Hey, " << nama << "is trapped in a boredom!\n";
		if (happy>0)
			happy -= 1;
		if (health>0)
			health -= 1;
		if (hunger == 10)
			health -= 3;
		else if (hunger<10)
			hunger += 1;
	}

	int checkStat(int mode){
		if (mode == 1){
			if (happy == 0)
				cout << "Please take a good care of him!";
			else if (happy<4)
				cout << nama << " is feeling so blue";
			else if (happy >= 4 && happy<8)
				cout << nama << " is content";
			else if (happy <= 10 && happy >= 8)
				cout << nama << " is content";
		}
		else if (mode == 2){
			if (health <= 0){
				cout << nama << " is dead. You are a really horrible owner :(";
				return 0;
			}
			if (health<4)
				cout << nama << " looks unhealthy";
			else if (health >= 4 && health<8)
				cout << nama << " is fine";
			else if (health <= 10 && health >= 8)
				cout << nama << " is on a top form";
		}
		else if (mode == 3){
			if (hunger<4)
				cout << nama << " is full";
			else if (hunger >= 4 && hunger<8)
				cout << nama << " is alright";
			else if (hunger <= 10 && hunger >= 8)
				cout << nama << " is starving";
		}
		return 1;
	}

	int printStat(){
		cout << "\nYour current state: \n";
		cout << "Happiness\t: ";
		int i;
		for (i = 1; i <= happy; i++)
			cout << "^";
		cout << "\t";
		checkStat(1);
		cout << "\nHealth\t\t: ";
		for (i = 1; i <= health; i++)
			cout << "~";
		cout << "\t";
		checkStat(2);
		cout << "\nHunger\t\t: ";
		for (i = 1; i <= hunger; i++)
			cout << "+";
		cout << "\t";
		checkStat(3);
		cout << "\n";
		if (checkStat(2))
			return 1;
		else
			return 0;
	}
};

int main()
{
	tama monster;

	monster.happy = 10;
	monster.health = 10;
	monster.hunger = 1;
	int input, i;

	cout << "Enter your monster's name: ";
	cin >> monster.nama;

	cout << "Welcome " << monster.nama << " to the real world!\n";
	monster.printStat();

	while (1){
		cout << "\nWhat do u want to do?\n";
		cout << "Enter 1 to play with him\n";
		cout << "Enter 2 to feed him\n";
		cout << "Enter 3 to let him sleep\n";
		cout << "Enter 4 to do nothing\n";
		cout << "Enter 5 to exit\n";
		cout << "> ";
		cin >> input;

		system("cls");

		if (input < 5 && input>0){
			if (input == 1)
				monster.play();
			else if (input == 2)
				monster.feed();
			else if (input == 3)
				monster.sleep();
			else if (input == 4)
				monster.nothing();
		}
		else if (input == 5)
		{
			cout << "Enough already for today? Well, then. Farewell!\n";
			break;
		}
		else
			cout << "Wrong input!! Please enter the proper command\n";
		if (monster.printStat())
			continue;
		else
			break;
	}

	return 0;
}