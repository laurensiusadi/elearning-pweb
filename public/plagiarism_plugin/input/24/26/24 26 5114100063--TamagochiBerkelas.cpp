#include <iostream>
using namespace std;

class Pet
{
public:
	int energi, bersih, kuat, lapar;
	char nama[100];

	Pet()
	{

	}

	void sleep()
	{
		energi += 3;
	}

	void eat()
	{
		lapar += 3;
	}

	void bath()
	{
		bersih += 3;
	}

	void training()
	{
		kuat += 3;
	}

	void mines()
	{
		bersih -= 1;
		energi -= 1;
		lapar -= 1;
	}
};

int menu(char jeneng[])
{
	int angka;
	cout << "Apa yang ingin " << jeneng << " lakukan?\n";
	cout << "1.Stats\t2.Tidur\t3.Makan\t4.Mandi\t5.Latihan\n";
	cin >> angka;
	return angka;
}

int main()
{
	Pet mypet;
	mypet.bersih = mypet.kuat = mypet.energi = mypet.lapar = 10;
	cout << "Masukkan nama peliharaan : ";
	cin >> mypet.nama;
	while (mypet.bersih != 0 && mypet.energi != 0 && mypet.lapar != 0)
	{
		cout << "\n";
		switch (menu(mypet.nama)) {
		case 1:
			cout << "====\t" << mypet.nama << " Status\t====\n";
			cout << "Energi : " << mypet.energi << "\n";
			cout << "Kebersihan : " << mypet.bersih << "\n";
			cout << "Kekuatan : " << mypet.kuat << "\n";
			cout << "Kelaparan : " << mypet.lapar << "\n";
			break;
		case 2:
			mypet.sleep();
			mypet.mines();
			cout << "zZz... zZz... (" << mypet.nama << " tertidur)\n\n";
			break;
		case 3:
			mypet.eat();
			mypet.mines();
			cout << "nyam nyam... (" << mypet.nama << " makan)\n\n";
			break;
		case 4:
			mypet.bath();
			mypet.mines();
			cout << "byur byur... (" << mypet.nama << " mandi)\n\n";
			break;
		case 5:
			mypet.training();
			mypet.mines();
			cout << "hosh hosh... (" << mypet.nama << " berlatih)\n\n";
			break;
		}
	}

	cout << "\n\n======\t\tGame Over !!!\t\t======\n\n";
	cout << "====\t" << mypet.nama << " Status\t====\n";
	cout << "Energi : " << mypet.energi << "\n";
	cout << "Kebersihan : " << mypet.bersih << "\n";
	cout << "Kekuatan : " << mypet.kuat << "\n";
	cout << "Kelaparan : " << mypet.lapar << "\n";

	system("pause");
	return 0;
}