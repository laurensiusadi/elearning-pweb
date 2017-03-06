#include <iostream>

using namespace std;

class pet
{
public:
	char nama[20];
	int darah = 100;
	int kenyang = 100;
	int senang = 100;
	int exp = 0;

	pet()
	{

	}

	void makan()
	{
		if (kenyang == 100)
		{
			cout << "Hewan Kamu Udah Kenyang\n" << endl;
		}
		else
		{
			kenyang = kenyang + 10;
		}
	}

	int trainning()
	{
		if (darah == 0)
		{
			cout << "Hewan kamu perlu istirahat" << endl;
			cout << "Game Over" << endl;
			return 1;
		}
		else
		{
			darah = darah - 10;
			kenyang = kenyang - 10;
			exp = exp + 10;
			if (exp > 100)
			{
				cout << "Hewan kamu naik ke LVL 2" << endl;
			}
			else if (exp > 200)
			{
				cout << "Hewan kamu naik ke LVL 3" << endl;
			}
			else if (exp > 300)
			{
				cout << "Hewan kamu naik ke LVL 4" << endl;
			}
			else if (exp > 400)
			{
				cout << "Hewan kamu naik ke LVL MAX" << endl;
				cout << "note : walaupun exp naik sudah tidak bisa naik lvl" << endl;
			}
		}
	}

	void istirahat()
	{
		if (darah == 100)
		{
			cout << "Hewan kamu sudah terlalu banyak istirahat" << endl;
		}
		else
		{
			darah = darah + 10;
		}
	}

	void main_game()
	{
		if (senang == 100)
		{
			cout << "Hewan kamu sudah terlalu senang" << endl;
		}
		else
		{
			senang = senang + 10;
		}
	}

	void cek_status()
	{
		cout << "\nDarah : " << darah;
		cout << "\nKenyang : " << kenyang;
		cout << "\nSenang : " << senang;
		cout << "\nEXP : " << exp;
	}
};

int main()
{
	
	int ngapain;
	pet pet_t;

	cout << "Masukkan Nama Hewan : ";
	cin >> pet_t.nama;
	cout << "Nama Hewan Kamu Adalah : " << pet_t.nama << endl;
	cout << "Darah Kamu Adalah : " << pet_t.darah << endl;
	cout << "Status Perut Adalah : " << pet_t.kenyang << endl;
	cout << "Status Senang Adalah : " << pet_t.senang << endl;
	cout << "EXP Hewanmu Adalah : " << pet_t.exp << endl;
	
	while(true)
	{

		cout << "\n 1)Makan\n 2)Trainning\n 3)Istirahat\n 4)Cek Status\n 5)Main Game\n 6)Exit" << endl;
		cout << "Apa yg bakal kamu lakukan terhadap hewanmu ? " << endl;
		cin >> ngapain;
		
		if (ngapain == 1)
		{
			/*if (kenyang == 100)
			{
				cout << "Hewan Kamu Udah Kenyang\n" << endl;
			}
			else
			{
				kenyang = kenyang + 10;
			}*/
			pet_t.makan();
		}
		else if (ngapain == 2)
		{
			if (pet_t.trainning == 1)
			{
				return 0;
			}
			//pet_t.trainning();
			/*if (darah == 0)
			{
				cout << "Hewan kamu perlu istirahat" << endl;
				cout << "Game Over" << endl;
				break;
			}
			else
			{
				darah = darah - 10;
				kenyang = kenyang - 10;
				exp = exp + 10;
				if (exp > 100)
				{
					cout << "Hewan kamu naik ke LVL 2" << endl;
				}
				else if (exp > 200)
				{
					cout << "Hewan kamu naik ke LVL 3" << endl;
				}
				else if (exp > 300)
				{
					cout << "Hewan kamu naik ke LVL 4" << endl;
				}
				else if (exp > 400)
				{
					cout << "Hewan kamu naik ke LVL MAX" << endl;
					cout << "note : walaupun exp naik sudah tidak bisa naik lvl" << endl;
				}
			}*/
		}
		else if (ngapain == 3)
		{
			pet_t.istirahat();
			/*if (darah == 100)
			{
				cout << "Hewan kamu sudah terlalu banyak istirahat" << endl;
			}
			else
			{
				darah = darah + 10;
			}*/
		}
		else if (ngapain == 4)
		{
			pet_t.cek_status();
			/*cout << "\nDarah : " << darah;
			cout << "\nKenyang : " << kenyang;
			cout << "\nSenang : " << senang;
			cout << "\nEXP : " << exp;*/
		}
		else if (ngapain == 5)
		{
			pet_t.main_game();
			/*if (senang == 100)
			{
				cout << "Hewan kamu sudah terlalu senang" << endl;
			}
			else
			{
				senang = senang + 10;
			}*/
			
		}
		else if (ngapain == 6)
		{
			//pet_t.exit;
			break;
		}
	}
	return 0;
}