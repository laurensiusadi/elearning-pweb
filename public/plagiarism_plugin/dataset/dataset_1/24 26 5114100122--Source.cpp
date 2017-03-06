#include<iostream>

using namespace std;

class Monster {
public:
	char nama[1000];
	int kesehatan, kekenyangan, kekuatan;
	Monster() {

	}
	void stats() {
		cout << "status: kesehatan:" << kesehatan << "/100 " << "kekenyangan:" << kekenyangan << "/100 " << "kekuatan:" << kekuatan << " penghancur" << endl;
	}
	void makan(int energi) {
		kekenyangan += energi;
		cout << "kekenyangan bertambah " << energi << " point" << endl;
		if (kekenyangan > 100) { kekenyangan = 100; cout << "udah kenyang" << endl; }
	}
	void mengobati() {
		kesehatan += 25;
		if (kesehatan > 100) { kesehatan = 100; cout << "sudah sehat boss" << endl; }
	}
	void latihan() {
		if (kekenyangan <= 10 || kesehatan <= 10) {
			cout << "tidak bisa nanti mati" << endl;
		}
		else {
			kekuatan += 5;
			kekenyangan -= 10;
			kesehatan -= 5;
		}
	}
};

int main() {
	int lakukan, makan;
	Monster tempemon;
	tempemon.kesehatan = 10;
	tempemon.kekenyangan = 10;
	tempemon.kekuatan = 0;
	cout << "halo selamat datang di tamagochi B" << endl;
	cout << "sebelumnya masukkan nama pet anda:" << endl;
	cin >> tempemon.nama;
	while (1) {
		cout << "halo " << tempemon.nama << endl;
		cout << "Mau apa sekarang?" << endl;
		cout << "1. status" << endl;
		cout << "2. makan" << endl;
		cout << "3. medicine" << endl;
		cout << "4. latihan" << endl;
		cout << "5. EXIT GAME" << endl;
		cin >> lakukan;
		switch (lakukan) {
		case 1: {
			tempemon.stats();
			break;
		}
		case 2: {
			cout << "makan apa?\n1.pisang\n2.apel\n3.anggur\n";
			cin >> makan;
			switch (makan) {
			case 1: {tempemon.makan(10);break;}
			case 2: {tempemon.makan(15);break;}
			case 3: {tempemon.makan(20);break;}
			}
			break;
		}
		case 3: {
			tempemon.mengobati();
			break;
		}
		case 4: {
			tempemon.latihan();
			break;
		}
		case 5: {
			return 0;
			break;
		}
		}
	}

}