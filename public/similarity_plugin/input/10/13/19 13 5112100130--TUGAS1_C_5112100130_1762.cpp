//==========================||
//  Maulina Nur Istiqomah   ||
//  5112100130              ||
//  PBO - C                 ||
//==========================||

#include <iostream>

using namespace std;

class invoice
{
    public:
        void setQty(int a)
        {
            if(a>0) qty = a;
            else qty = 0;
        }
        void setPrice(int a)
        {
            if(a>0) price = a;
            else price = 0;
        }
        void setID(string b) 
        {
            id = b;
        }
        void setDCB(string b)
        {
            dcb = b;
        }
        int getQty()
        {
            return qty;
        }
        int getPrice()
        {
            return price;
        }
        string getID()
        {
            return id;
            
        }
        string getDCB()
        {
            return dcb;
        }
        int getInvoiceAmount()
        {
            return qty*price;
        }
    private:
        string id, dcb;
        int qty, price;
};

int main()
{

    return 0;
}
