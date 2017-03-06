/*
 * main.cpp
 *
 *  Created on: Sep 18, 2013
 *      Author: ericivander
 */


#include<iostream>
#include<algorithm>
#include<cstdio>
#include<string>
using namespace std;

class Invoice{
public:
	Invoice(){}
	Invoice(string inp1,string inp2,int q,int p){
		partNumber=inp1;
		name=inp2;
		quantity=q;
		price=p;
	}
	void set(){
		cout << "Inputkan Part Number : ";
		cin >> partNumber;
		cout << "Inputkan Nama Barang : ";
		cin >> name;
		cout << "Inputkan Jumlah Pesanan : ";
		cin >> quantity;
		cout << "Inputkan Harga Barang : ";
		cin >> price;
	}
	void get(){
		cout << "Part Number : " << partNumber << endl;
		cout << "Nama Barang : " << name << endl;
		cout << "Jumlah Pesanan : " << quantity << endl;
		cout << "Harga Barang : " << price << endl;
	}
private:
	string partNumber;
	string name;
	int quantity;
	int price;
};

int main(){

	return 0;
}
