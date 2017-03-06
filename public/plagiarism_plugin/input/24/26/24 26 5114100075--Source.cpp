/* 
PROJECT 1 - TAMAGOTCHI (+class+object)
[TUGAS2_C_5114100075]

Nama  : Panji Rimawan
NRP   : 5114100075
Kelas : PBO - C
*/

#include <iostream>
#include <string>

using namespace std;

// deklarasi Class
class Digimon {
public:
	// atribut
	string name;
	int energy = 65;	// energi dari sumber makanan digimon
	int health = 70;	// kesehatan dari digimon
	int	clean = 60;		// kebersihan dari digimon
	int happy = 65;		// mood dari digimon

	// behavior
	void DoEnergy()
	{
		energy += 7;
		health += 1;
		happy += 1;
		clean -= 3;
		cout << "" << name << " is eating some food......." << endl;
	}

	void DoGames()
	{
		energy -= 4;
		health -= 1;
		happy += 8;
		clean -= 2;
		cout << "" << name << " is playing a games......." << endl;
	}

	void DoClean()
	{
		energy -= 1;
		health += 1;
		clean += 10;
		cout << "" << name << " is taking a bath......." << endl;
	}

	void DoExercises()
	{
		energy -= 3;
		health += 7;
		clean -= 4;
		cout << "" << name << " is doing an exercises......." << endl;
	}

	void Stat()
	{
		cout << "********************************" << endl;
		cout << "Your " << name << "'s status are:" << endl;
		cout << "Energy\t\t: " << energy << endl;
		cout << "Health\t\t: " << health << endl;
		cout << "Happiness\t: " << happy << endl;
		cout << "Cleanliess\t: " << clean << endl;
		cout << "********************************" << endl;
	}
};

int main()
{
	int sign;

	cout << "Welcome to DIGIMON WORLD XXI" << endl << endl;
	cout << "Enter your digimon's name: ";

	// instansiasi Class menjadi Object
	Digimon digi;
	cin >> digi.name;
	digi.Stat();

	do {
		cout << "\nHy " << digi.name << ". What will you do now? ^^" << endl;
		cout << "1. Take a breakfast\n2. Play a games\n3. Take a bath\n4. Do exercises\n5. Check Status\n0. Exit program" << endl;
		cout << "Input: ";
		cin >> sign;

		switch (sign) {
		case 0: break;
		case 1: {
			digi.DoEnergy();
			break;
		}
		case 2: {
			digi.DoGames();
			break;
		}
		case 3: {
			digi.DoClean();
			break;
		}
		case 4: {
			digi.DoExercises();
			break;
		}
		case 5: {
			digi.Stat();
			break;
		}
		default: cout << "Wrong Input!" << endl;
		}
	} while (sign != 0);

	return 0;
}