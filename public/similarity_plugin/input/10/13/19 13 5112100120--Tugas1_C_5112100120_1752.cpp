#include<iostream>
#include<string>
using namespace std;

class Invoice
{
	public:
		Invoice(string ID,string Description,int jmlh, int hrg)
		{
				setID(ID);
				setDescription(Description);
				if(jmlh > 0)
				{
					setJumlah(jmlh);
				}
				else
				{
					setJumlah(0);
				}
				if(hrg > 0)
				{
					setHarga(hrg);
				}
				else
				{
					setHarga(0);
				}
		}
		void setID(string kodebarang)
		{
			ID=kodebarang;
		}
		string getID()
		{
			return ID;
		}
		void setDescription(string jenis)
		{
			Description = jenis;
		}
		string getDescription()
		{
			return Description;
		}
		void setJumlah(int jmlh)
		{
			Jumlah = jmlh;
		}
		int getJumlah()
		{
			return Jumlah;	
		}	
		void setHarga(int hrg)
		{
			Harga = hrg;
		}
		int getHarga()
		{
			return Harga;
		}
		int getInvoiceAmount()
		{
			return (Jumlah*Harga);
		}
		private:
			string ID,Description;
			int Jumlah,Harga; 		
};

int main()
{
	
	return 0;
}
