#include <iostream>
#include <string>
using namespace std;

class Pet
{
public:
	string name;
	int level;
	int energy;
	int exp;
	int hunger;
	int max_exp;

	Pet()
	{
	}

	void header() {
		cout << "====================================================================\n";
		cout << "\t\t\t>>>    LONGCAT    <<<\t\t\t\n";
		cout << "====================================================================\n";
	}

	void status() {
		cout << "\t        Name : " << name << " |";
		cout << " Level : " << level << " | ";
		cout << " Exp : " << exp << "/" << max_exp << " | \n";
		cout << " \t\t Hunger : " << hunger << "/100 | ";
		cout << " Energy : " << energy << "/100 | \n";
		cout << "--------------------------------------------------------------------\n\n\n";
	}

	void signup()
	{
		cout << "Welcome to LONGCAT. Who's your cat name?\n";
		getline(cin, name);
		level = 1;
		hunger = 50;
		energy = 50;
		exp = 0;
		max_exp = level * 100;
		cout << "Well your cat is yours now. Let the game begin. LOVE LONGCAT\n";
		system("pause");
		system("CLS");
		header();
		status();
	}

	void lvlup()
	{
		level = level + 1;
		hunger = 50;
		energy = 50;
		exp = 0;
		max_exp = level * 100;
		cout << "====================================================================\n";
		cout << "\t\t\t>>>    LEVEL UP    <<<\t\t\t\n";
		cout << "====================================================================\n";
	}

	void feed()
	{
		int flag = 0;
		system("CLS");

		hunger = hunger + 10;
		if (hunger <= 100) {
			energy = energy + 5;
			if (energy > 100) energy = 100;
			exp = exp + 10;
			flag = 1;
		}
		else {
			hunger = 50;
			exp = exp - 50;
		}

		if (exp >= max_exp)
		{
			lvlup();
		}
		header();
		status();
		if (flag == 1) cout << "Yummy!\n";
		else cout << "Aw Snap! She's just vomitted";
		menu();
	}

	void play()
	{
		int flag = 0;
		system("CLS");
		if (energy >= 10 && hunger>0) {
			energy = energy - 25;
			exp = exp + 15;
			hunger = hunger - 10;
			flag = 1;
		}

		if (exp >= max_exp)
		{
			lvlup();
		}
		header();
		status();
		if (flag == 1) cout << "Hooray!\n";
		else cout << "NO!\n";
		menu();
	}


	void sleep()
	{
		int flag = 0;
		system("CLS");
		if (energy <= 75) {
			energy = energy + 50;
			if (energy > 100) energy = 100;
			exp = exp + 5;
			hunger = hunger - 50;
			if (hunger < 0) hunger = 0;
			flag = 1;
		}

		if (exp >= max_exp)
		{
			lvlup();
		}
		header();
		status();
		if (flag == 1) cout << "Nyam Nyam\n";
		else cout << "I'm Strong Enough!\n";
		menu();
	}

	void menu()
	{
		int id_number;
		cout << "\n\n";
		cout << "Meong Meong!\n";
		cout << "What would you like to do?\n";
		cout << "1.I Think She Is Hungry. Feed Her\n2.Boring? Let's Play\n3.Sleepy Little Cat? Lullaby\n4.I Hate Her! Kill My Cat\n";
		cout << "Well choose it : ";
		cin >> id_number;

		if (id_number == 1) feed();
		else if (id_number == 2) play();
		else if (id_number == 3) sleep();
		else if (id_number == 4) return;
		else if (id_number == 99) {
			level = 99;
			system("CLS");
			lvlup();
			header();
			status();
			menu();
		}
		else {
			system("CLS");
			header();
			status();

			cout << "Wrong Input\n";
			menu();
		}
	}
};



int main()
{

	Pet cat;
	cat.header();
	cat.signup();
	cat.menu();
	system("CLS");
	cat.header();
	cout << "\n\nDead!\n\n";
	system("pause");
}