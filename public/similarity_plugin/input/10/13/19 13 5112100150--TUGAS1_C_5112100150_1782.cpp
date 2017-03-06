#include <iostream>
#include <string.h>

using namespace std;

class Stroke{
	int quantity, price;
	string partnumber, partdescription;
	public:
		Stroke (int jumlah, int harga, string nomor, string ket){
			if (harga < 0){
				setPrice(0);
			}else{
				setPrice(harga);
			}
			if (jumlah < 0){
				setQuantity(0);
			}else{
				setQuantity(jumlah);
			}
			setPartnumber(nomor);
			setPartdescription(ket);
		}
		void setPrice(int harga){
			price = harga;
		}
		int getPrice(){
			return price;
		}
		void setQuantity(int jumlah){
			quantity = jumlah;
		}
		int getQuantity(){
			return quantity;
		}
		void setPartnumber(string nomor){
			partnumber = nomor;
		}
		string getPartnumber(){
			return partnumber;
		}
		void setPartdescription(string ket){
			partdescription = ket;
		}
		string getPartdescription(){
			return partdescription;
		}
		int Gia(){
			return (price*quantity);
		}
};

int main ()
{
	
}
