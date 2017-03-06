#include "Circle.h"
#include <stdlib.h>
#define KANAN_BAWAH speedX > 0 && speedY > 0
#define KANAN_ATAS speedX > 0 && speedY < 0
#define KIRI_ATAS speedX < 0 && speedY < 0
#define KIRI_BAWAH speedX < 0 && speedY > 0
#define O_KANAN_BAWAH Other->speedX > 0 && Other->speedY > 0
#define O_KANAN_ATAS Other->speedX > 0 && Other->speedY < 0
#define O_KIRI_ATAS Other->speedX < 0 && Other->speedY < 0
#define O_KIRI_BAWAH Other->speedX < 0 && Other->speedY > 0


Circle::Circle(int X, int Y)
{
	size = rand() % 30;
	posX = X ;
	posY = Y;
	R = rand() % 255;
	G = rand() % 255;
	B = rand() % 255;
	speedX = rand() % 10;
	speedY = rand() % 10;
}


Circle::~Circle()
{
}

void Circle::ballMove(){

	posX += speedX;
	posY += speedY;

}

void Circle::wallHit(){
	int x1, x2, y1, y2;
	x1 = posX;
	y1 = posY;
	x2 = 500;
	y2 = 300;
	if (x1 + size > x2 || x1 - size < 0) speedX *= -1;
	if (y1 + size > y2 || y1 - size < 0) speedY *= -1;
}

void Circle::ballHit(Circle *Other){
	int x1 = posX,
		x2 = Other->posX,
		y1 = posY,
		y2 = Other->posY;
	int xd = x2 - x1;
	int yd = y2 - y1;
	float distance = xd*xd + yd*yd;
	distance = floor(sqrt(distance));
	if (distance < size + Other->size){
		if (KANAN_BAWAH && O_KANAN_ATAS){
			speedY *= -1;
			Other->speedY *= -1;
		}
		else if (KANAN_BAWAH && O_KIRI_ATAS){
			speedX *= -1;
			Other->speedX *= -1;
			speedY *= -1;
			Other->speedY *= -1;
		}
		else if (KANAN_BAWAH && O_KIRI_BAWAH){
			speedX *= -1;
			Other->speedX *= -1;
		}
		else if (KANAN_ATAS && O_KANAN_BAWAH){
			speedY *= -1;
			Other->speedY *= -1;
		}
		else if (KANAN_ATAS && O_KIRI_ATAS){
			speedX *= -1;
			Other->speedX *= -1;
		}
		else if (KANAN_ATAS && O_KIRI_BAWAH){
			speedX *= -1;
			Other->speedX *= -1;
			speedY *= -1;
			Other->speedY *= -1;
		}
		else if (KIRI_ATAS && O_KANAN_ATAS){
			speedX *= -1;
			Other->speedX *= -1;
		}
		else if (KIRI_ATAS && O_KANAN_BAWAH){
			speedX *= -1;
			Other->speedX *= -1;
			speedY *= -1;
			Other->speedY *= -1;
		}
		else if (KIRI_ATAS && O_KIRI_BAWAH){
			speedY *= -1;
			Other->speedY *= -1;
		}
		else if (KIRI_BAWAH && O_KIRI_ATAS){
			speedY *= -1;
			Other->speedY *= -1;
		}
		else if (KIRI_BAWAH && O_KANAN_ATAS){
			speedX *= -1;
			Other->speedX *= -1;
			speedY *= -1;
			Other->speedY *= -1;
		}
		else if (KIRI_BAWAH && O_KANAN_BAWAH){
			speedX *= -1;
			Other->speedX *= -1;
		}
	}
}