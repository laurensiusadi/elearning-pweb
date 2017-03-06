#include <iostream>
#include <string>

using namespace std;

class Pet
{
public:
	//atribut
	string name;
	string breed;
	int healthiness = 100;
	int happiness = 100;
	int hygiene = 100;
	int hunger = 0;

	//constructor
	Pet()
	{

	}

	void Eat(int amount)
	{
		hunger += amount;
		healthiness -= amount;
		happiness++;
		hygiene--;
	}

	void Sleep(int amount)
	{
		hunger -= amount;
		healthiness += amount;
		happiness++;
		hygiene--;
	}

	void Play(int amount)
	{
		hunger -= amount;
		healthiness -= amount;
		happiness++;
		hygiene--;
	}

	void TakeABath(int amount)
	{
		hunger--;
		healthiness++;
		happiness++;
		hygiene += amount;
	}

	void Stat()
	{
		cout << "Name:" << name << " | Healthiness:" << healthiness << " | Happiness:" << happiness << " | Hygiene:" << hygiene << endl;
	}
};

int main()
{
	cout << "Hello World of Pets" << endl;

	Pet cat;
	cat.name = "Catty";

	Pet cat2;
	cat2.name = "Pikky";

	Pet cat3;
	cat3.name = "Sissy";

	cout << "Address of cat=" << &cat << endl;
	cout << "Address of cat2=" << &cat2 << endl;

	cat.Eat(10);
	cat.Sleep(0);
	cat.Play(10);
	cat.TakeABath(40);
	cat.Stat();

	cat2.Eat(20);
	cat2.Sleep(50);
	cat2.Play(0);
	cat2.TakeABath(50);
	cat2.Stat();

	cat3.Eat(10);
	cat3.Sleep(100);
	cat3.Play(30);
	cat3.TakeABath(20);
	cat3.Stat();

	cin.get();

	return 0;
}