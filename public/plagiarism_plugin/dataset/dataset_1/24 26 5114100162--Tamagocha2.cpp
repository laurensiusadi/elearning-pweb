#include <iostream>
#include <string>
using namespace std;

class Digimon {
public:
	double age = 1;
	int love = 0;
	int hate = 0;
	int fat = 0;
	string nama;

	Digimon() {

	}

	void status(char x)
	{
		if (x == 'f' || x == 'F') {
			fat++;
			love++;
			age += 0.5;
			cout << "Feeded\n";

			if (fat > 10) {
				love -= 2;
				fat -= 0.5;
				hate += 1;
				cout << "ku sudah kenyang, huft\n";
			}
		}
		else if (x == 'b' || x == 'B') {
			love++;
			age += 0.5;
			cout << "sudah mandi\n";
			if (hate > 0) {
				hate--;
			}
		}
		else if (x == 'L' || x == 'l') {
			cout << "status digimon kamu : si " << nama << " memiliki stat\n\n";
			cout << "     .^._.^." << endl;
			cout << "    | 0 0  |" << endl;
			cout << "   (  v    |" << endl;
			cout << "   |       |" << endl;
			cout << "Umur : " << age << endl;
			cout << "Status Love : " << love << endl;
			cout << "Kebencian : " << hate << endl;
			cout << "Gendut : " << fat << endl;
		}
		else if (x == 'D' || x == 'd') {
			cout << "sudah diet\n";
			if (fat > 0) {
				fat--;
			}
			else {
				cout << "butuh makan\n";
			}
		}
	}

};

void help()
{
	cout << "Kalian akan memelihara sebuah digimon yang hidup di kokoro(hati) kalian" << endl;
	cout << "Jadilah majikan yang baik pada peliharaanmu, niscaya dia akan patuh kepadamu" << endl;
}

int main()
{
	Digimon myhero;
	char command;
	cout << "-----------------------Option-------------------------------" << endl;
	cout << "1. Press H for Tutorial" << endl;
	cout << "2. Press Q for quit" << endl;
	cout << "3. Press D for Diet" << endl;
	cout << "4. Press F for Give Food" << endl;
	cout << "5. Press B for Take Bath" << endl;
	cout << "6. Press L for Look Status" << endl;
	cout << "-----------------------Option-------------------------------";
	cout << "\n";
	cout << "Insert your digimon name\n";
	cin >> myhero.nama;
	cout << "Meet " << myhero.nama << ", your digimon in Informatics Departement\n";
	cout << "     .^._.^." << endl;
	cout << "    | 0 0  |" << endl;
	cout << "   (  v    |" << endl;
	cout << "   |       |" << endl;

	while (true)
	{
		cout << "\nMasukkan command: \n";
		cin >> command;
		if (command == 'H' || command == 'h') {
			help();
		}
		else if (command == 'Q' || command == 'q') {
			break;
		}
		else if (command == 'F' || command == 'f') {
			myhero.status(command);
		}
		else if (command == 'B' || command == 'b') {
			myhero.status(command);
		}
		else if (command == 'F' || command == 'f') {
			myhero.status(command);
		}
		else if (command == 'L' || command == 'l') {
			myhero.status(command);
		}
		else if (command == 'D' || command == 'd') {
			myhero.status(command);
		}
		else {
			cout << "Perintah tidak diketahui\n";
		}
	}
	return 0;
}