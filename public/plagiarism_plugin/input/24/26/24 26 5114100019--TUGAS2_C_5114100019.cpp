#include <iostream>
#include<cstdlib>
#include <string>
#include<algorithm>
using namespace std;

class Pet
{
public:
	//atributes
	string nama;
	int kotor;
	int energi;
	int ngantuk;
	int bahagia;

	//constructor
	Pet()
	{
		energi = 50;
		kotor = 50;
		bahagia = 50;
		ngantuk = 50;
	}

	//behaviour
	void Makan()
	{
		if (energi <= 85) energi += 15;
		else {
			energi = 100;
			cout << nama << " sangat berenergi ^^\n";
		}
		if (ngantuk <= 95) ngantuk += 5;
		else {
			ngantuk = 100;
			cout << nama << " sangat mengantuk :(\n";
		}
		if (bahagia <= 95) bahagia += 5;
		else {
			bahagia = 100;
			cout << nama << " sangat bahagia ^^\n";
		}
		if (kotor <= 90) kotor += 5;
		else {
			kotor = 100;
			cout << nama << " sangat kotor :(\n";
		}
	}

	void Main()
	{
		if (bahagia <= 85) bahagia += 15;
		else {
			bahagia = 100;
			cout << nama << " sangat bahagia ^^\n";
		}
		if (energi >= 45) energi -= 45;
		else {
			energi = 0;
			cout << nama << " butuh energi :(\n";
		}
		if (kotor <= 85) kotor += 15;
		else {
			kotor = 100;
			cout << nama << " sangat kotor :(\n";
		}
	}

	void Mandi()
	{
		if (kotor >= 35) kotor -= 35;
		else {
			kotor = 0;
		}
		if (energi >= 5) energi -= 5;
		else {
			energi = 0;
			cout << nama << " butuh energi :(\n";
		}
		if (ngantuk >= 5) ngantuk -= 5;
		else {
			ngantuk = 0;
		}
	}

	void Tidur()
	{
		if (ngantuk >= 25) ngantuk -= 25;
		else {
			ngantuk = 0;
		}
		if (energi <= 90) energi += 10;
		else {
			energi = 100;
		}
		if (kotor <= 90) kotor += 10;
		else {
			kotor = 100;
			cout << nama << " butuh mandi :(\n";
		}
	}

	void Stat()
	{
		cout << "Status " << nama << " sekarang:\n";
		cout << ">> energi : " << energi << endl;
		cout << ">> kotor : " << kotor << endl;
		cout << ">> ngantuk : " << ngantuk << endl;
		cout << ">> bahagia : " << bahagia << endl;
	}
};

int main()
{
	char nama[10], jenis[20];

	cout << "Selamat datang, selamat Bermain!\n";
	cout << "Jenis binatang apa yang ingin kamu pelihara? (harus 1 kata!) ";
	cin >> jenis;
	cout << "Apa nama " << jenis << " kamu? (harus 1 kata!) ";
	cin >> nama;
	cout << endl << nama << " siap bermain!\n";
	cout << "Hai nama saya " << nama << ", peliharalah saya dengan baik yaa ^^\n\n";
	cout << "=======->>><><><><><><><><o><0><o><><><><><><><><<<-=======\n";

	//instansi kelas pet menjadi objek cat
	Pet peliharaan;
	peliharaan.nama = nama;
	int input=1;
	peliharaan.Stat();
	
	while (input != 0) {
		if (peliharaan.energi == 0) cout << nama << " butuh energi :(\n";
		if (peliharaan.kotor == 100) cout << nama << " butuh mandi :(\n";
		if (peliharaan.ngantuk == 100) cout << nama << " butuh istirahat :(\n";
		if (peliharaan.bahagia == 0) cout << nama << " butuh main :(\n";

		//cout << "\n----------------------\n";
		cout << "\n";
		cout << "1. Beri makan!\n";
		cout << "2. Ajak main!\n";
		cout << "3. Bersihkan!\n";
		cout << "4. Biarkan dia tidur!\n";
		cout << "0. Keluar\n";
		cout << "Input : ";
		cin >> input;

		if (input == 1) { //makan
			peliharaan.Makan();
		}
		else if (input == 2) { //main
			peliharaan.Main();
		}
		else if (input == 3) { //mandi
			peliharaan.Mandi();
		}
		else if (input == 4) { //tidur
			peliharaan.Tidur();
		}
		else cout << "Input harus >= 1 dan <=4 ^^\n";

		cout << "\n~~~~~~~~~~~~~~~~~~~~~~\n";

		peliharaan.Stat();
	}
	getchar();
	getchar();
	return 0;
}