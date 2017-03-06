#include<iostream>
#include<string>
#include<algorithm>

using namespace std;

class Pet
{
public:
	string name;
	int hunger = 100;
	int happy = 100;
	int health = 100;
	int hygiene = 100;

	void Stat()
	{
		cout << "Current status of " << name << " :\nHunger: " << hunger << " | Happy: " << happy
		<< " | Health: " << health << " | Hygiene: " << hygiene << endl;
	}

	void Train(char tr)
	{
		if (tr == 'C')
		{
			if (happy != 100) happy = happy + 10;
			if (hunger != 0) hunger = hunger - 10;
			if (health != 0) health = health - 10;
			if (hygiene != 0) hygiene = hygiene - 10;
		}
		else if (tr == 'B')
		{
			if (happy != 0) happy = happy - 10;
			if (hunger != 0) hunger = hunger - 5;
			if (hygiene != 0) hygiene = hygiene - 5;
		}
	}

	void Feed(char food)
	{
		if (food == 'M')
		{
			int amount;
			cout << "Amount: ";
			cin >> amount;
			if (hunger != 100) hunger = min(hunger + 10, 10);
			if (happy != 100) happy = happy + 5;
			if (health != 0) health = max(health - amount, 0);
			if (hygiene != 0) hygiene = hygiene - 5;
		}
		else if (food == 'S')
		{
			int amount;
			cout << "Amount: ";
			cin >> amount;
			if (happy != 100) happy = happy + 10;
			if (hunger != 100) hunger = hunger + 5;
			if (health != 0) health = max(health - amount, 0);
			if (hygiene != 0) hygiene = hygiene - 5;
		}
	}

	void TakeBath()
	{
		if (hygiene != 100) hygiene = hygiene + 10;
	}

	void Sleep(char sl)
	{
		if (sl == 'N')
		{
			if (health != 100) health = health + 5;
			if (hygiene != 0) hygiene = hygiene - 10;
		}
		else if (sl == 'D')
		{
			if (happy != 100) happy = happy + 10;
			if (health != 100) health = health + 10;
			if (hunger != 0) hunger = hunger - 10;
			if (hygiene != 0) hygiene = hygiene - 10;
		}
	}

};

int main()
{
	char per;
	int warning = 0;
	Pet tama;
	cout << "Hello!\n";
	cout << "Enter your pet name: ";
	cin >> tama.name;
	tama.Stat();
	cout << "\nWhat do you want to do?\nTrain(T) / Feed(F) / Sleep(S) / Take Bath(B) / Exit(X): ";
	cin >> per;
	while (per != 'X')
	{
		if (per == 'T')
		{
			char tr;
			cout << "Catch(C) / Behave(B): ";
			cin >> tr;
			tama.Train(tr);
		}
		else if (per == 'F')
		{
			char food;
			cout << "Meal(M) / Snack(S): ";
			cin >> food;
			tama.Feed(food);
		}
		else if (per == 'S')
		{
			char sl;
			cout << "Nap(N) / Deep Sleep(D): ";
			cin >> sl;
			tama.Sleep(sl);
		}
		else if (per == 'B')
		{
			tama.TakeBath();
		}
		tama.Stat();
		if (tama.hunger < 10 || tama.happy < 10 || tama.health < 10) cout << "Warning status Low! Please take care of your pet!\n";
		if (tama.hunger == 0 || tama.health == 0)
		{
			warning++;
		}
		if (warning == 2) {
			cout << "Can't Live!Goodbye!";
			break;
		}
		cout << "\nWhat do you want to do?\nTrain(T) / Feed(F) / Sleep(S) / Take Bath(B) / Exit(X): ";
		cin >> per;
	}
	cout << "Goodbye!";

	cin.get();
	return 0;
}