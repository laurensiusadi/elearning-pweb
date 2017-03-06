#include<iostream>
#include<string>

using namespace std;

class Pet
{
	public:
		string name;
		string breed;
		int hunger=80;
		int energy=85;
		int happiness=85;
		int hygiene=80;
		int healthiness=85;

		Pet() {
		}

		void ShowStat() {
			cout << "Name\t\t: " << name << endl;
			cout << "Breed\t\t: " << breed << endl;
			cout << "Energy\t\t: " << energy << endl;
			cout << "Happiness\t: " << happiness << endl;
			cout << "Health\t\t: " << healthiness << endl;
			cout << "Hunger\t\t: " << hunger << endl;
			cout << "Hygiene\t\t: " << hygiene << "\n" << endl;
		}

		void Eat() {
			if (hunger<100) {
				energy-=5;
				if (hunger <= 90) {
					hunger += 10;
					cout << name << " ate something!\n"<<endl;
				}
				else {
					healthiness -= 5;
					hunger = 100;
				}
			}
			else {
				cout << name << " is Full!\n" << endl;
			}
		}

		void Sleep() {
			if (energy<100) {
				energy = 100;
				hunger -= 5;
				hygiene -= 5;
				cout << name << " slept already!"<<endl;
			}
			else {
				cout << name<<"'s energy is Full!\n"<< endl;
			}
		}

		void Exercise() {
			if (healthiness<100) {
				happiness -= 5;
				energy -= 10;
				hunger -= 5;
				hygiene -= 10;
				if (healthiness <= 90) {
					healthiness += 10;
				}
				else {
					healthiness = 100;
				}
				cout << name << " Worked Out!\n"<< endl;
			}
			else {
				cout << name << "is Healthy\n" << endl;
			}
		}

		void Bath() {
			if (hygiene<100) {
				happiness -= 5;
				energy -= 5;
				hunger -= 5;
				if (hygiene <= 90) {
					hygiene += 10;
				}
				else {
					hygiene = 100;
				}
				cout << name << " Took a Bath!\n"<< endl;
			}
			else {
				cout << name<< " is Clean!\n"<<endl;
			}
		}

		void Play() {
			if (happiness<100) {
				healthiness -= 5;
				energy -= 10;
				hunger -= 10;
				hygiene -= 5;
				if (happiness <= 90) {
					happiness += 10;
				}
				else {
					happiness = 100;
				}
				cout << name << " Played Something!\n"<<endl;
			}
			else {
				cout << name << "is Happy\n" << endl;
			}
		}
};

int main()
{
	int pilih;
	Pet myPet;
	
	cout<<"Welcome to Tamagochi!\n\nBreed of Your Pet\t: ";
	cin >> myPet.breed;
	
	cout << "Name of Your Pet\t: ";
	cin >> myPet.name;

	while (1) {
		cout << "Choose The Number of The Menu:\n1. Show Status\n2. Eat\n3. Sleep\n4. Exercise\n5. Take a Bath\n6. Play\n7. Exit\n\n";
		cin >> pilih;

		if (pilih == 1) {
			myPet.ShowStat();
		}
		else if (pilih == 2) {
			myPet.Eat();
		}
		else if (pilih == 3) {
			myPet.Sleep();
		}
		else if (pilih == 4) {
			myPet.Exercise();
		}
		else if (pilih == 5) {
			myPet.Bath();
		}
		else if (pilih == 6) {
			myPet.Play();
		}
		else if (pilih == 7) {
			cout << "Thankyou for Playing! :)"<<endl;
			break;
		}
	}

	cin.get();

	return 0;
}