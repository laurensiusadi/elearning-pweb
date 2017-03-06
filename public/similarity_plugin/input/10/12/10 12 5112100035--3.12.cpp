#include <iostream>
using namespace std;
class Account
{

public:
	Account(int uang_masuk) {
		if(uang_masuk < 0) {
			cout<<"Eror ! Uang anda kurang dari 0"<<endl;
			uang_masuk=0;
		}
		cek = uang_masuk;
	}

	void kredit(int data) {
		cek = data + cek;
	}

	void Debit(int y) {
		if (cek < y) {
			cout <<"Saldo tidak cukup."<< endl;
		}
		else {
			cek = cek - y;
		}
	}

	int getBalance() {
		return cek;
	}

private:
	int cek;

};

int main(){
	
	return 0;
};
