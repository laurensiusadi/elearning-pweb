#include<iostream>
#include<string>

using namespace std;

class Pet
{
public:
	string name;
	int feed=100, energy=100, health=100, mood=100, hygiene=100, money=100000, food;

	Pet()
	{
	}
	
	void print()
	{
		cout<<"\n\nHere is your status"<<endl;
		cout<<"Feed\t: "<<feed<<endl;
		cout<<"Energy\t: "<<energy<<endl;
		cout<<"Health\t: "<<health<<endl;
		cout<<"Mood\t: "<<mood<<endl;
		cout<<"Hygiene\t: "<<hygiene<<endl;
		cout<<"Money\t: "<<money<<endl;
		if(feed<=25) cout<<endl<<endl<<"Oh no! "<<name<<" is starving!"<<endl;
		else if(energy<=25) cout<<endl<<endl<<"Hoam "<<name<<" is tired!"<<endl;
		else if(health<=25) cout<<endl<<endl<<"Oh my God! "<<name<<" is sick!"<<endl;
		else if(mood<=25) cout<<endl<<endl<<"Hey! "<<name<<" needs refreshing!"<<endl;
		else if(hygiene<=25) cout<<endl<<endl<<"Eww, "<<name<<"'s smell is stink!"<<endl;
		else if(money<=25000) cout<<endl<<endl<<"BANKRUPT!"<<endl;
	}

	void eat()
	{
		if(feed==100) cout<<endl<<endl<<name<<" is full!"<<endl;
		else if(money<15000) cout<<endl<<endl<<"Ups sorry, you don't have enough money!"<<endl;
		else
		{
			cout<<endl<<"TC's Menu :"<<endl;
			cout<<"1)Campur Rice & Ice Tea\t\t15000\tFeed+20"<<endl;
			cout<<"2)Fried Chicken & Orange Juice\t30000\tFeed+40"<<endl;
			cout<<"3)Carls' Jr\t\t\t60000\tFeed+80"<<endl;
			cout<<"What "<<""<<name<<" want to eat? (1/2/3) ";
			cin>>food;
			switch(food)
			{
				case 1:
				if(feed<=80) feed+=20;
				else feed=100;
				if(health<=95) health+=5;
				else health=100;
				money-=15000;
				break;
			case 2:
				if(feed<=60) feed+=40;
				else feed=100;
				if(health<=90) health+=10;
				else health=100;
				money-=30000;
				break;
			case 3:
				if(feed<=20) feed+=80;
				else feed=100;
				if(health<=80) health+=20;
				else health=100;
				money-=60000;
				break;
			default :
				cout<<endl<<endl<<"INPUT ERROR!"<<endl;
				return;
			}
			cout<<endl<<endl<<"Nomnom!"<<endl;
		}
		return;
	}

	void sleep()
	{
		if(energy==100) cout<<endl<<endl<<name<<" is not sleepy!"<<endl;
		else
		{
			if(energy<=75) energy+=25;
			else energy=100;
			if(health<=90) health+=10;
			else health=100;
			cout<<endl<<endl<<"Recharge done!"<<endl;
		}
		return;
	}

	void buy()
	{
		if(health>60) cout<<endl<<endl<<name<<" is fine!"<<endl;
		else if(money<40000) cout<<endl<<endl<<"Ups sorry, you don't have enough money!"<<endl;
		else
		{
			if(health<=90) health+=10;
			else health=100;
			money-=40000;
			cout<<endl<<endl<<"Get well soon!"<<endl;
		}
		return;
	}

	void play()
	{
		if(energy<=20||feed<=20||health<=20||hygiene<=30) cout<<endl<<endl<<name<<" is not in mood to play!"<<endl;
		else
		{
			if(mood<=70) mood+=30;
			else mood=100;
			energy-=20;
			feed-=20;
			health-=5;
			hygiene-=30;
			cout<<endl<<endl<<"It's so refreshing!"<<endl;
		}
		return;
	}

	void bath()
	{
		if(hygiene==100) cout<<endl<<endl<<name<<" is clean enough!"<<endl;
		else
		{
			if(hygiene<=50) hygiene+=50;
			else hygiene=100;
			cout<<endl<<endl<<"Fresh!"<<endl;
		}
		return;
	}

	void work()
	{
		if(energy<=25||feed<=20||health<=20||mood<=30) cout<<endl<<endl<<name<<" is not in mood to work!"<<endl;
		else
		{
			money+=25000;
			energy-=25;
			feed-=20;
			health-=20;
			mood-=30;
			cout<<endl<<endl<<"Yey! "<<name<<" gains money!"<<endl;
		}
		return;
	}
};

int main()
{
	string name;
	int command;
	cout<<"\n--------------------HELLO!--------------------\n";
	cout<<"\nWelcome to TC Pet Shop!\n";
	cout<<"Please, choose you pet :\n";
	cout<<"1) Puppy\n2) Kitten\n3) Hamster\n";
	cout<<"Your choice is (1/2/3) ";
	cin>>command;
	Pet tamagotchi;
	getline(cin,tamagotchi.name);
	switch(command)
	{
		case 1:
			cout<<"What's your puppy's name? ";
			break;
		case 2:
			cout<<"What's your kitten's name? ";
			break;
		case 3:
			cout<<"What's your hamster's name? ";
			break;
		default:
			cout<<"\n\nPet Not Available! Try again next time!\n";
			return 0;		
	}
	getline(cin,tamagotchi.name);
	do {
		cout<<"\n\nHi "<<tamagotchi.name<<"\n";
		cout<<"\nWhat do you want to do?\n";
		cout<<"1) Eat\n2) Sleep\n3) Buy Medicine\n4) Play\n5) Take a bath\n6) Work\n7) Print Status\n0) Exit\n";
		cout<<"You want to (1/2/3/4/5/6/7/0) ";
		cin>>command;
		switch(command)
		{
			case 0:
				cout<<"\n\nIf you close this program, your pet will DIE\n";
				cout<<"\n--------------Thanks for playing--------------\n"; 
				return 0;
			case 1:
				tamagotchi.eat();
				break;
			case 2:
				tamagotchi.sleep();
				break;
			case 3:
				tamagotchi.buy();
				break;
			case 4:
				tamagotchi.play();
				break;
			case 5:
				tamagotchi.bath();
				break;
			case 6:
				tamagotchi.work();
				break;
			case 7:
				tamagotchi.print();
				break;
			default :
				cout<<"\nINPUT ERROR!\n";
				break;
		}
	} while(true);
	return 0;
}
