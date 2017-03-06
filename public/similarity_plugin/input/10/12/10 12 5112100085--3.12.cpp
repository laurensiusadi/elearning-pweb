#include<cstdio>
#include<iostream>
#include<algorithm>

using namespace std;
class customor
{
private:
   	int JumlahSaldo;

public:
	customor(){
		JumlahSaldo = 0;
	}
    void setCredit(int tabung){
		JumlahSaldo += tabung;
    }
	void setDebit(int ambil){
		if(ambil>JumlahSaldo) cout << "jumlah debit anda melebihi saldo." << endl;
		else JumlahSaldo -= ambil;
	}
	int getSaldo(){
		return JumlahSaldo;
	}
};

int main()
{

}
