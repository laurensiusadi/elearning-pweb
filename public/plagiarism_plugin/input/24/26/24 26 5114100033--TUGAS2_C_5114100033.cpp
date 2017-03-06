#include<iostream>
#include<string>
#include<cstdlib>
#define clear system("cls");
#define pause {cout<<endl; system("pause");}

using namespace std;

class Pet
{
public:
	//atribut:
	string jenis;
	string name;
	string breed;
	int energy = 25;
	int happiness = 25;
	int health = 25;
	int hygiene = 30;

	//constructor
	Pet()
	{

	}

	void Exercise()
	{
		health += 5;
		energy -= 4;
		hygiene -= 4;
	}

	void Play()
	{
		happiness += 5;
		energy -= 4;
		hygiene -= 4;
	}

	void Eat()
	{
		energy += 5;
		health += 5;
		hygiene -= 4;
	}

	void Sleep()
	{
		energy += 5;
		health += 5;
		happiness -= 4;
		//hygiene--;
	}

	void TakeABath()
	{
		health += 5;
		hygiene += 5;
	}

	void Stat()
	{
		/*cout << "Name:" << name << endl<<" Health:  " << health << " | Happiness:  " << happiness <<
		" | Hygiene:  " << hygiene << " | Energy:  " << energy<< endl; */
		cout << "------------------------------*************------------------------------------" << endl;
		cout << "Pet's status : " << endl;
		cout << "Name:" << name << endl;
		cout << "Energy = " << energy << "/80 |  ";
		cout << "Happiness = " << happiness << "/80 |  ";
		cout << "Hygiene = " << hygiene << "/80 |  ";
		cout << "Health = " << health << "/80 |" << endl << endl;
		cout << "------------------------------**************-----------------------------------" << endl;
	}

};

int main()
{

	cout << "Hai, Welcome to Tamagochi ^o^" << endl << "Here, you can get a pet and name it." << endl << endl;
	cout << "What pet do you want to have?" << endl;
	cout << "Type animal you want to have as your pet : " << endl;

	Pet hewan;
	cin >> hewan.jenis;

	cout << endl << "--------------------------------------------------------------------------------" << endl;
	cout << "You have chosen a " << hewan.jenis << " as your pet." << endl << "Please input your pet's name : " << endl;
	cin >> hewan.name;

	cout << "--------------------------------------------------------------------------------" << endl;
	cout << "Hello! My name's " << hewan.name << endl;
	cout << "Please take care of me !" << endl << endl;

	hewan.Stat();
	pause;

	int flag = 0;
	int opsi;

	while (1)
	{
		clear;
		cout << "What do you want to do with me? " << endl;
		cout << "(1) Exercise with " << hewan.name << endl;
		cout << "(2) Play with " << hewan.name << endl;
		cout << "(3) Feed " << hewan.name << endl;
		cout << "(4) Sing " << hewan.name << " Nina Bobo" << endl;
		cout << "(5) Take A Bath " << hewan.name << endl;
		cout << "(6) Quit game" << endl;
		cout << "Enter your choice: 1/2/3/4/5/6 : ";

		if (flag == 0) cin >> opsi;

		if (opsi == 1)
		{
			if (hewan.health<80)
			{
				hewan.Exercise();
				cout << endl << "Awww, Thank you! I feel better" << endl << endl;
				hewan.Stat();
				flag = 0;
				pause;
			}
			else
			{
				cout << hewan.name << " is already healthy nyaww!" << endl << endl;
				flag = 0;
			}
		}

		else if (opsi == 2)
		{
			if (hewan.happiness<80)
			{
				hewan.Play();
				cout << endl << "Yay! Let's play!" << endl << endl;
				hewan.Stat();
				flag = 0;
				pause;
			}
			else
			{
				cout << hewan.name << " is already happy enough" << endl << endl;
				flag = 0;
			}
		}

		else if (opsi == 3)
		{
			if (hewan.energy<80)
			{
				hewan.Eat();
				cout << endl << "Nyam nyam... Delicious.. I love it" << endl << endl;
				hewan.Stat();
				flag = 0;
				pause;
			}
			else
			{
				cout << hewan.name << " is still full :3 " << endl << endl;
				flag = 0;
			}
		}

		else if (opsi == 4)
		{
			if (hewan.energy<80)
			{
				hewan.Sleep();
				cout << endl << "Nina Bobo...ooo Nina bobo.. kalo tidak bobo, digigit semut :3" << endl << endl;
				cout << endl << "I feel so tired. Let's sleep, good night ^^ " << endl << endl;
				hewan.Stat();
				flag = 0;
				pause;
			}
			else
			{
				cout << hewan.name << "Still wanna play :((( " << endl << endl;
				flag = 0;
			}
		}

		else if (opsi == 5)
		{
			if (hewan.health<80)
			{
				hewan.TakeABath();
				cout << endl << "Oh no, I'm so dirty. Let's take a shower :3 " << endl << endl;
				hewan.Stat();
				flag = 0;
				pause;
			}
			else
			{
				cout << hewan.name << " I'm still clean and cool right? haha " << endl << endl;
				flag = 0;

			}
		}

		else if (opsi == 6)
		{
			cout << endl << "Thank you for playing!" << endl << "Looking forward to see you again :)" << endl;
			flag = 0;
			pause;
			break;
		}

		else
		{
			if (opsi>6)
			{
				cout << "Your option is wrong, Please choose again (1/2/3/4/5/6) : ";
				flag = 1;
				cin >> opsi;
			}
		}

	}

	cin.get();

	return 0;
}

