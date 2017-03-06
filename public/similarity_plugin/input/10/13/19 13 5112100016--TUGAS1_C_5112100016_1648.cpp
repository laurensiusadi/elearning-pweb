#include <iostream>
#include <string>
using namespace std;
class Invoice {
	string number;
	string description;	//description of item
	int purchased;		//quantity of item being purchased
	int price;			//price per item
	
	public:
		//constructor tanpa parameter 
		Invoice(){}
		
		//constructor dengan parameter
		Invoice(string nomer, string deskripsi, int dibeli, int harga) {
			number = nomer;
			description = deskripsi;
			setPurchased(dibeli);
			setPrice(harga);
		}
		
		//fungsi setter "number"
		void setNumber(string nomer) {
			number = nomer;
		}
		
		//fungsi setter "description item"
		void setDescription(string deskripsi) {
			description = deskripsi;
		}
		
		//fungsi setter "quantity of item being purchased"
		int setPurchased(int dibeli) {
			if(dibeli < 0) 
				purchased = 0;
			else 
				purchased = dibeli;
		}
		
		//fungsi setter "price per item"
		int setPrice(int harga) {
			if(price < 0) 
				price = 0;
			else 
				price = harga;
		}
		
		//fungsi menampilkan "number"
		string getNumber() {
			return number;
		}
		
		//fungsi menampilkan "description item" 
		string getDescription()	{
			return description;
		}
		
		//fungsi menampilkan "quantity of item being purchased"
		int getPurchased()	{	
			return purchased;
		}
		
		//fungsi menampilkan "price per item"
		int getPrice()	{
			return price;
		}
		
		//fungsi menghitung jumlah invoice barang
		int getInvoiceAmmount()	{
			return purchased * price;
		}
};
int main(){
	
}
