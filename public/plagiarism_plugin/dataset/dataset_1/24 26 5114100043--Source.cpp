#include <iostream>
#include <string>
using namespace std;

class Peliharaan {
public:
	string name;
	int energy = 100;
	int fun = 100;
	int cleanesses = 100;

	Peliharaan() {

	}
public:

	void futsal() {
		energy -= 20;
		fun += 30;
		cleanesses -= 30;
	}
	void tenis() {
		energy -= 15;
		fun += 10;
		cleanesses -= 30;
	}
	void catur() {
		energy -= 5;
		fun += 5;
	}
	void gaming() {
		fun += 25;
		cleanesses -= 10;
	}
	void makan() {
		energy += 50;
		fun += 30;
		cleanesses -= 30;
	}
	void minum() {
		energy += 40;
		fun += 20;
		cleanesses += 5;
	}
	void tidur() {
		energy += 50;
		fun += 30;
		cleanesses -= 30;
	}
	void mandi() {
		energy += 10;
		fun += 30;
		cleanesses += 50;
	}
	void statuss() {
		cout << "Name\t\t: " << name << endl;
		cout << "Energy\t\t: " << energy << endl;
		cout << "Fun\t\t: " << fun << endl;
		cout << "Cleanesses\t: " << cleanesses << endl;
	}
};

int main() {
	char milihs[30];
	Peliharaan a;
	cout << "\t\t\t___....GAME_TAMAGOCHI....___" << endl;
	cout << "Selamat datang di dunia virtual tamagochi. Disini kalian bisa merasakan rasanya memiliki hewan peliharaan. Rasakan keseruannya !!!" << endl <<endl;
	cout << "Pet Name : "; 
	getline(cin, a.name);
	a.statuss() ;
	while (1) {
		system("cls");
		cout << "\t\t\t___....GAME_TAMAGOCHI....___" << endl;
		cout << ("\n\t\t\t\t    Futsal\n");
		cout << ("\t\t\t\t    Tenis\n");
		cout << ("\t\t\t\t    Catur\n");
		cout << ("\t\t\t\t    Nge-Game\n");
		cout << ("\t\t\t\t    Makan\n");
		cout << ("\t\t\t\t    Minum\n");
		cout << ("\t\t\t\t    Tidur\n");
		cout << ("\t\t\t\t    Mandi\n");
		cout << ("\t\t\t\t    Status\n");
		cout << ("\t\t\t\t    Keluar\n\n");
		cout << "\t\t\t___....0-0-0-0-0-0-0-0....___" << endl;
		cout << ("Gotchi/Activities >$ \a");
		cin >> milihs; getchar();
		if (milihs[0] == 'F') {
			a.futsal();
		}
		else if (milihs[1] == 'e' && milihs[0] == 'T' ){
			a.tenis();
		}
		else if (milihs[0] == 'C') {
			a.catur();
		}
		
		else if (milihs[0] == 'N') {
			a.gaming();
				
		}
		else if (milihs[2] == 'k') {
			a.makan();
				
		}
		else if (milihs[1] == 'i') {
			a.minum();
				
		}
		else if (milihs[0] == 'T') {
			a.tidur();
				
		}
		else if (milihs[2] == 'n') {
			a.mandi();
				
		}
		else if(milihs[0]=='S'){
			a.statuss();
		}
		else if (milihs[0] == 'K') {
			break;
		}
		else {
			cout << "ZzzzZzzZ" << endl;
		}
		
		system("pause");
	}
	return 0;
}

