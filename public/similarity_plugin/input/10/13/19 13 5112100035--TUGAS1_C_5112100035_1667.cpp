#include<iostream>
using namespace std;

class Invoice
{

public:
	Invoice (string partNumber, string deskripsi, int banyak, int harga ) {
		setPartNumber(partNumber);
		setDeskripsi(deskripsi);
		setBanyak(banyak);
		setHarga(harga);
	}

	void setPartNumber(string partnum) {
		number = partnum;
	}

	void setDeskripsi(string deskrip) {
		deskripsi= deskrip;
	}

	void setBanyak(int jumlah) {
		if(jumlah < 0)
			jumlah = 0;
		quantity = jumlah;
	}

	void setHarga(int harga) {
		if(harga < 0)
			harga = 0;
		price = harga;
	}

	string getPartNumber() {
		return number;
	}

	string getDeskripsi() {
		return deskripsi;
	}

	int getBanyak() {
		return quantity;
	}

	int getHarga() {
		return price;
	}

	int InvoiceAmount() {
		return quantity*price;
	}

private:
	string number;
	string deskripsi;
	int quantity;
	int price;
};


int main() {
	return 0;
}





