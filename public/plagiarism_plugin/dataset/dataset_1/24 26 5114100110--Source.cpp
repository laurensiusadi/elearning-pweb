#include <iostream>
#include <string>
#include <ctime>
#include <cstdlib>
using namespace std;

class Pet
{
	
	public:
		string name;
		string breed;
		
		int healthiness;
		int happiness;
		int hygiene;
		int hunger;
		int thu, the, tha, thy;
		Pet()
		{
		}

		void Eat()
		{
			cout << "You take " << name << " to eat with you\n";
			srand(time(NULL));
			thu = rand() % 50 + 50;
			the = rand() % 21;
			tha = rand() % 30 + 20;
			thy = rand() % 21;
			hunger -= thu;
			if (hunger < 0) hunger = 0;
			healthiness -= the;
			if (healthiness < 0) healthiness = 0;
			happiness += tha;
			if (happiness > 100) happiness = 100;
			hygiene -= thy;
			if (hygiene < 0) hygiene = 0;
		}
		void Play()
		{
			cout << "You take " << name << " play with you\n";
			srand(time(NULL));
			thu = rand() % 21;
			the = rand() % 21;
			tha = rand() % 50 + 50;
			thy = rand() % 21;
			hunger += thu;
			if (hunger > 100) hunger = 100;
			healthiness -= the;
			if (healthiness < 0) healthiness = 0;
			happiness += tha;
			if (happiness > 100) happiness = 100;
			hygiene -= thy;
			if (hygiene < 0) hygiene = 0;
		}
		void Bath()
		{
			cout << "You take " << name << " to the bath\n";
			srand(time(NULL));
			thu = rand() % 21;
			the = rand() % 21;
			tha = rand() % 20 + 30;
			thy = rand() % 50 + 50;
			hunger += thu;
			if (hunger > 100) hunger = 100;
			healthiness -= the;
			if (healthiness < 0) healthiness = 0;
			happiness += tha;
			if (happiness > 100) happiness = 100;
			hygiene += thy;
			if (hygiene > 100) hygiene = 100;
		}
		void Sleep()
		{
			cout << "You put " << name << " to sleep\n";
			srand(time(NULL));
			thu = rand() % 21;
			the = rand() % 50 + 50;
			tha = rand() % 21;
			thy = rand() % 21;
			hunger += thu;
			if (hunger > 100) hunger = 100;
			healthiness += the;
			if (healthiness > 100) healthiness = 100;
			happiness -= tha;
			if (happiness < 0) happiness = 0;
			hygiene -= thy;
			if (hygiene < 0) hygiene = 0;
		}
		void Stat()
		{
			cout << "-------------------------------------\n" << "Name : " << name << "\nHunger : " << hunger << "\nHealthiness : " 
				<< healthiness << "\nHappiness : " << happiness << "\nHygine : " << hygiene << endl;
			if (healthiness <= 50)
			{
				cout << name << " look tired, " << name << " need to take a rest!\n";
			}
			if (hunger >= 50)
			{
				cout << name << " seems hungry, " << name << " need to eat something!\n";
			}
			if (happiness <= 50)
			{
				cout << name << " look bored, " << name << " need to play with you!\n";
			}
			if (hygiene <= 50)
			{
				cout << name << " smells bad, " << name << " need to take a bath!\n";
			}
			cout << "-------------------------------------\n";
			return;
		}
};

int main()
{
	int i = 1, k;
	Pet kucing1;
	cout << "-------Welcome To Tama Gochi---------" << endl;
	cout << "Insert your pet name : ";
	cin >> kucing1.name;
	srand(time(NULL));
	kucing1.healthiness = rand() % 101;
	kucing1.happiness = rand() % 101;
	kucing1.hygiene = rand() % 101;
	kucing1.hunger = rand() % 101;
	cout << "Your Pet name : " << kucing1.name << "\n";
	kucing1.Stat();
	cout << "Do your best to make your pet in the best condition\n";
	while (i == 1)
	{
		cout << "What do you want to do with your pet ?\n";
		cout << "1. Eat with your pet\n";
		cout << "2. Put your pet to sleep\n";
		cout << "3. Play with your pet\n";
		cout << "4. put your pet to the bath\n";
		cout << "5. End the game\n";
		cout << "Your step : ";
		cin >> k;
		if (k == 1)
		{
			kucing1.Eat();
		}
		else if (k == 2)
		{
			kucing1.Sleep();
		}
		else if (k == 3)
		{
			kucing1.Play();
		}
		else if (k == 4)
		{
			kucing1.Bath();
		}
		else if (k == 5)
		{
			i = 0;
			cout << "\t\tYou leave " << kucing1.name << endl;
		}
		kucing1.Stat();
		if (kucing1.happiness >= 80 && kucing1.healthiness >= 80 && kucing1.hunger <= 20 && kucing1.hygiene >=80)
		{
			cout << "\n\n\n\tCongratulation your pet in the best condition\n\tyou are the best owner!!\n";
			i = 0;
		}
	}
	cout << "\n\n\n\t--------------Game Over--------------\n\n\n\n";
	system("pause");
	return 0;
}