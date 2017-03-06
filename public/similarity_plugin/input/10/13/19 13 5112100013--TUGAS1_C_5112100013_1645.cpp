/*	Tugas PBO dari buku C++ How to Program, 8th edition. Halaman 99 no. 3.13
 *
 *	Nama		: Fransiskus Gusti Ngurah Dwika Setiawan
 *	NRP			: 5112100013
 *	Kelas PBO	: C
 *
 */

#include <iostream>

using namespace std;

class Invoice {
	
private:
	string partNumber;
	string partDesc;
	int qty;
	int price;
	
public:
	void setPartNumber(string s) {
		partNumber = s;
	}
	
	void setPartDesc(string s) {
		partDesc = s;
	}
	
	void setQty(int q) {
		qty = q>0 ? q:0;
	}
	
	void setPrice(int p) {
		price = p>0 ? p:0;
	}
	
	string getPartNumber() {
		return partNumber;
	}
	
	string getPartDesc() {
		return partDesc;
	}
	
	int getQty() {
		return qty;
	}
	
	int getPrice() {
		return price;
	}
	
	Invoice(string pNumber, string pDesc, int q, int p) {
		setPartNumber(pNumber);
		setPartDesc(pDesc);
		setQty(q);
		setPrice(p);
	}
};



int main() {
	
	return 0;
}
