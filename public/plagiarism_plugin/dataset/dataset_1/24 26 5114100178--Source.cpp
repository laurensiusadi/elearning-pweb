#include<iostream>
#include<string>
#include<stdlib.h>

using namespace std;

class Pet
{
public:
	string name_pet;
	int hunger, health, stamina, clean, playful;

	Pet(){
	}

	void cek_hunger()
	{
		if (hunger > 100)
			hunger = 100;
		if (hunger < 0)
			hunger = 0;
	}

	void cek_health()
	{
		if (health > 100)
			health = 100;
		if (health < 0)
			health = 0;
	}

	void cek_stamina()
	{
		if (stamina > 100)
			stamina = 100;
		if (stamina < 0)
			stamina = 0;
	}

	void cek_clean()
	{
		if (clean > 100)
			clean = 100;
		if (clean < 0)
			clean = 0;
	}

	void cek_playful()
	{
		if (playful > 100)
			playful = 100;
		if (playful < 0)
			playful = 0;
	}

	void Eat()
	{
		hunger += 15;
		health -= 10;
		clean -= 15;
		playful -= 5;
		cek_hunger();
		cek_health();
		cek_clean();
		cek_playful();
	}

	void Medicine()
	{
		health += 50;
		clean -= 5;
		playful -= 10;
		cek_health();
		cek_clean();
		cek_playful();
	}

	void Play()
	{
		playful += 30;
		stamina -= 30;
		clean -= 10;
		health -= 5;
		cek_playful();
		cek_stamina();
		cek_clean();
		cek_health();
	}

	void Bath()
	{
		clean += 40;
		playful += 5;
		cek_clean();
		cek_clean();
	}


	void Sleep()
	{
		stamina += 60;
		playful -= 10;
		clean -= 5;
		health += 5;
		cek_stamina();
		cek_playful();
		cek_clean();
		cek_health();
	}

	void Status()
	{
		cout << "Hunger\t\t: " << hunger << "%" << endl;
		cout << "Health\t\t: " << health << "%" << endl;
		cout << "Playful\t\t: " << playful << "%" << endl;
		cout << "Stamina\t\t: " << stamina << "%" << endl;
		cout << "Cleanliness\t: " << clean << "%" << endl;
		system("pause");
		system("cls");
	}
};

int main()
{
	cout << "WELCOME TO THE DIGITAL WORLD!!!"<<endl<<endl<<endl;
	
	Pet tama;

	cout << "Enter your digimon name : ";
	getline(cin, tama.name_pet);
	cout << endl;
	system("cls");

	tama.hunger = 100;
	tama.health = 100;
	tama.clean = 100;
	tama.playful = 100;
	tama.stamina = 100;

	cout << "Hi! Let's have fun together" << endl<<endl;

	while (1)
	{
		int choice;

		cout << "What do you want to do with " << tama.name_pet<<endl;
		cout << "1. Give food" << endl;
		cout << "2. Play together" << endl;
		cout << "3. Make sleep" << endl;
		cout << "4. Take a bath together" << endl;
		cout << "5. Give medicine" << endl;
		cout << "6. Status" << endl;
		cout << "7. Exit" << endl;
		cin >> choice;
		system("cls");

		if (choice == 1)
			tama.Eat();
		else if (choice == 2)
			tama.Play();
		else if (choice == 3)
			tama.Sleep();
		else if (choice == 4)
			tama.Bath();
		else if (choice == 5)
			tama.Medicine();
		else if (choice == 6)
			tama.Status();
		else if (choice == 7)
			break;
		else
			cout << "Wrong input!!!!!" << endl;
	}
}