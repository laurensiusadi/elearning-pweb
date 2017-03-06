#include <iostream>	

using namespace std;
class Pet
{
public:
	char nama[10];//atribut
	int hunger = 0, strength = 5, power = 0, kebersihan = 100;//atribut
	void Makan()
	{	
		if (kebersihan < 0)
		{
			cout << "Aku ingin mandi terlebih dahulu!" << endl;
		}
		else if (kebersihan>100)
		{	
			kebersihan = 100;
			kebersihan -= 5;
		}
		else { kebersihan -= 5; }
		cout << "Ah enak sekali makanannya\n";
		if (hunger <= 0)
		{
			hunger = 0;
		}
		else if (hunger <= 100 && hunger > 0)
		{
			hunger = hunger - 10;
			if (hunger < 0) { hunger == 0; }
		}
		else if (hunger > 100) {
			hunger = 100;
			hunger = hunger - 10;
		}
		if (power <= 0)
		{
			power = 0;
		}
		if (power <= 100 && power > 0)
		{
			power = power - 5;
		}
		else if (power > 100)
		{
			power = 100;
			power = power - 5;
		}


	}
	void Tidur()
	{
		if (hunger >= 100)
		{
			hunger = 100;
		}
		else if (hunger <= 100 && hunger >= 0)
		{
			hunger = hunger + 40;
			if (hunger >= 100)
			{
				hunger = 100;
			}
		}
		else if (hunger < 0)
		{
			hunger = 0;
			hunger = hunger + 40;
		}
		if (power <= 0) { power = 0; }
		else if (power > 100) {
			power = 100;
			power = power - 50;
		}
		else if (power >= 0 && power <= 100)
		{
			power = power - 50;
		}
		cout << "Nyenyak sekali tidurku!!!\n";
	}
	void Latihan()
	{
		if (hunger >= 100 && power >= 100)
		{
			cout << "Aku lapaaar dan terlalu lelah untuk latihan\n";
			return;
		}
		else
		{
			if (hunger < 0) hunger = 0;
			hunger = hunger + 20;
			if (hunger > 100) hunger = 100;
			if (power < 0)power = 0;
			power = power + 20;
			if (power > 100) power = 100;
			strength = strength + 5;
		}
		cout << "Aku akan semakin kuat!\n";
	}
	void Status()
	{
		cout << "tingkat kelaparan: " << hunger << "\n";
		cout << "tingkat kelelahan: " << power << "\n";
		cout << "tingkat kekuatan: " << strength << "\n";
		cout << "tingkat kebersihan: " << kebersihan << "\n";
	}
	void Mandi()
	{	
		if (kebersihan + 10 > 100)
		{
			cout << "Aku tidak ingin mandi >.<"<<endl;
		}
		else
		{
			kebersihan += 10;
			cout << "Badanku terasa segar dan bersih!" << endl;
		}
	}
};
int main()
{	
	Pet monster;
	int input;
	cout << "Masukkan Nama Peliharaan: ";
	cin >> monster.nama;
	cout << "Hai Namaku " << monster.nama << "\n";
	do
	{
		cout << "Apa yang harus kulakukan sekarang:\n1. Makan\n2. Latihan\n3. Tidur\n4. Mandi\n5. Status\n6. Exit\n";
		cin >> input;
		switch (input)
		{
		case 1:
			monster.Makan();
			break;
		case 2:
			monster.Latihan();
			break;
		case 3:
			monster.Tidur();
			break;
		case 4:
			monster.Mandi();
			break;
		case 5:
			monster.Status();
			break;
		case 6:
			exit(0);
		}
	} while (1 == 1);
}



