#include<cstdio>
#include<iostream>
#include<cstdlib>
#include<string>

#define clear system("cls");
#define pause {cout<<endl; system("pause");}

using namespace std;

class Pet
{
public:
	//attributes
	string name;
	string type;
	int energy, mood, hygiene, food;

	//constructor
	Pet()
	{
	}

	//behavior
	void mangan()
	{
		clear;
		if (food<100)
		{
			cout << "Thanks for feeding me!" << endl;
			energy += 21;
			if (energy >= 100)	energy = 100;
			food += 37;
			if (food >= 100)	food = 100;
		}
		else	cout << "Sorry, I'm full, Human." << endl;
		pause;
	}


	void turu()
	{
		clear;
		if (energy<100)
		{
			cout << "Gute Nacht, Master! :)" << endl;
			energy += 48;
			if (energy >= 100)	energy = 100;
		}
		else cout << "Sorry, I'm not sleepy yet." << endl;
		pause;
	}
	void dolen()
	{
		clear;
		if (energy>20 && food>0)
		{
			mood += 16; hygiene -= 70; energy -= 27; food -= 25;
			if (mood >= 100)		mood = 100;
			if (hygiene <= 0) 	hygiene = 0;
			if (energy <= 0)	energy = 0;
			if (food <= 0)		food = 0;
			cout << endl << "Yay! I love playing!!" << endl;
		}
		else if (energy <= 20)
		{
			mood -= 15;
			if (mood <= 0)	mood = 0;
			cout << "Too bad, I'm too tired to play. Let me sleep, Human!" << endl;
		}
		else if (food == 0)
		{
			mood -= 45;
			if (mood <= 0)	mood = 0;
			cout << "Feed me! I'm starving!!" << endl;
		}
		pause;
	}
	void adus()
	{
		clear;
		if (hygiene<100)
		{
			cout << "Hmmm.. Love this fresh smell" << endl;
			hygiene += 50; energy += 10; mood += 20;
			if (hygiene >= 100)	hygiene = 100;
			if (energy >= 100)		energy = 100;
			if (mood >= 100) 		mood = 100;
		}
		else
		{
			mood -= 25;
			if (mood <= 0)	mood = 0;
			cout << "Don't you see my fresh and clean body, huh?!" << endl;
		}
		pause;
	}
	void stat()
	{
		clear;
		cout << "Name: " << name << endl;
		cout << "Type: " << type << endl;
		cout << "Mood: " << mood << "%" << endl;
		cout << "Food: " << food << "%" << endl;
		cout << "Hygiene: " << hygiene << "%" << endl;
		cout << "Energy: " << energy << "%" << endl;
		pause;
	}
};

int main()
{
	cout << "WELCOME TO THE FAILED TAMAGOTCHI" << endl;
	pause;
	Pet kewan;
	clear;
	cout << "What type of animal do you wanna keep as pet?" << endl;
	cin >> kewan.type;
	cout << "What is its name?" << endl;
	cin >> kewan.name;

	clear;
	cout << "Hi, my name is " << kewan.name << ". I'm your " << kewan.type << endl;
	cout << "Thanks for adopting me :D" << endl;
	kewan.food = 100;
	kewan.energy = 100;
	kewan.hygiene = 100;
	kewan.mood = 100;
	pause;
	int choice;

	while (1)
	{
		clear;
		cout << "Choose what you wanna do" << endl;
		cout << "[1] Feed me" << endl;
		cout << "[2] Play with me" << endl;
		cout << "[3] Let me sleep" << endl;
		cout << "[4] Clean me up" << endl;
		cout << "[5] See how my life goes" << endl;
		cout << "[6] Exit game" << endl;
		cin >> choice;

		if (choice == 1)	kewan.mangan();
		else if (choice == 2)	kewan.dolen();
		else if (choice == 3)	kewan.turu();
		else if (choice == 4)	kewan.adus();
		else if (choice == 5)	kewan.stat();
		else
		{
			clear;
			cout << "Thanks for playing! :)" << endl;
			pause;
			break;
		}
	}
	return 0;
}