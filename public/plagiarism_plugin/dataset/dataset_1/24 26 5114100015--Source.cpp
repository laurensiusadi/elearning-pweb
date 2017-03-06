#include<iostream>
#include<stdlib.h>

using namespace std;

class Pet
{
public:
	char nama[10];
	int makan, mandi, main, tidur, hebat;


	void eat(int jumlah)
	{
		mandi -= (jumlah / 2);
		tidur -= 2;
		main -= 1;
		makan += jumlah;
		if (makan>10)
		{
			makan = 10;
			cout << nama << " kekenyangaaaan" << "\n";
		}
	}

	void bath(int lama)
	{
		mandi += lama;
		main -= 1;
		tidur -= 2;
		makan -= (lama / 2);
		if (mandi>10)
		{
			mandi = 10;
			cout << nama << " sudah bersih bos!" << "\n";
		}
	}

	void play(int lama)
	{
		main += lama;
		mandi -= (lama / 2);
		tidur -= 2;
		makan -= (lama - 3);
		if (main>10)
		{
			main = 10;
			cout << nama << " capek kakaaa" << "\n";
		}
	}

	void sleep(int lama)
	{
		tidur += lama;
		main -= 1;
		mandi -= 3;
		makan -= (lama / 2);
		if (tidur>10)
		{
			tidur = 10;
			cout << nama << " tidur terlalu lama gak baik buat kesehatan" << "\n";
		}
	}

	void battle(int lv)
	{
		if (lv == 1)
		{
			if (tidur >= 5 && makan >= 5)
			{
				cout << nama << " menaaang!!\tselamaat :D" << "\n";
				tidur -= 2;
				makan -= 2;
				mandi -= 3;
				hebat += 1;
			}
			else
			{
				cout << nama << " telah kalah :((" << "\n";
				tidur -= 3;
				makan -= 3;
				mandi -= 3;
				hebat -= 1;
			}
		}
		else if (lv == 2)
		{
			if (tidur >= 7 && makan >= 7)
			{
				cout << nama << " menaaang!!\tselamaat :D" << "\n";
				tidur -= 2;
				makan -= 2;
				mandi -= 3;
				hebat += 2;
			}
			else
			{
				cout << nama << " telah kalah :((" << "\n";
				tidur -= 3;
				makan -= 3;
				mandi -= 3;
				hebat -= 1;
			}
		}
		if (lv == 3)
		{
			if (tidur >= 9 && makan >= 9)
			{
				cout << nama << " menaaang!!\tselamaat :D" << "\n";
				tidur -= 2;
				makan -= 2;
				mandi -= 3;
				hebat += 5;
			}
			else
			{
				cout << nama << " telah kalah :((" << "\n";
				tidur -= 3;
				makan -= 3;
				mandi -= 3;
				hebat += 3;
			}
		}


	}

	void help()
	{
		cout << "masukan perintah dalam bentuk angka dalam bentuk angka,\n diikuti kuantitas dari perintah tersebut\n";
		cout << "1. makan\n2. tidur\n3. main\n4. mandi\n5. tarung\n6. cek kondisi\n7. bantuan\n*ps : tarungkan hewanmu jika hewanmu dalam keadaan sehat\n";
		cout << "(untuk tarung, masukan  nilai lv 1-3. lainnya cukup kuantitasnya saja 1-9)\n";
	}

	void dead()
	{
		cout << nama << " telah mati, kau tidak pantas memelihara sesuatu -____-" << "\n";
	}

	void check()
	{
		cout << "\n===============================================================\n";
		cout << "kondisi " << nama << " sekarang\n";
		cout << "kenyang\t\t:" << makan << "\nkebersihan\t:" << mandi << "\nsenang\t\t:" << main << "\nkebugaran\t:" << tidur << "\nkehebatan\t:" << hebat << "\n";
	}
};

int main()
{
	cout << "TAMAGHOCIIIII!!!\ngame menang jika hewan peliharaan anda telah menjadi kuat\n";
	Pet Kucing;
	Kucing.makan = 7, Kucing.mandi = 7, Kucing.main = 7, Kucing.tidur = 7, Kucing.hebat = 0;
	int perintah, jumlah;
	cout << "beri nama hewanmu dong :D\nnama \t:";
	cin >> Kucing.nama;
	cout << "sekarang " << Kucing.nama << " sudah jadi milikmu, pelihara dia :D\n\n========================================================\n";
	Kucing.help();
	Kucing.check();
	while (1)
	{
		if (Kucing.hebat == 10)
		{
			cout << "hewan peliharaan anda telah mandiri sekarang, saatnya melepasnya di alam bebas :')\nselamat trainer hebat\n";
			break;
		}
		else if (Kucing.makan == 0 || Kucing.tidur == 0)
		{
			Kucing.dead();
			break;
		}
		cout << "masukan perintah dan jumlahnya (pisahkan dengan spasi) :";
		cin >> perintah >> jumlah;
		if (perintah == 1) Kucing.eat(jumlah);
		else if (perintah == 2) Kucing.sleep(jumlah);
		else if (perintah == 3) Kucing.play(jumlah);
		else if (perintah == 4) Kucing.bath(jumlah);
		else if (perintah == 5) Kucing.battle(jumlah);
		else if (perintah == 7) Kucing.help();
		else if (perintah == 6) Kucing.check();
		else
		{
			cout << "masukan angka 1- 6 yaaaa :D\n";
			Kucing.help();
		}
	}
	return 1;
}
