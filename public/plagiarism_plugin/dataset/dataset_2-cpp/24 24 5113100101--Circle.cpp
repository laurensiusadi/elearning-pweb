#include "Circle.h"
#include <cstdlib>
#define BOT_RIGHT vX > 0 && vY > 0
#define TOP_RIGHT vX > 0 && vY < 0
#define TOP_LEFT vX < 0 && vY < 0
#define BOT_LEFT vX < 0 && vY > 0
#define O_BOT_RIGHT Other->vX > 0 && Other->vY > 0
#define O_TOP_RIGHT Other->vX > 0 && Other->vY < 0
#define O_TOP_LEFT Other->vX < 0 && Other->vY < 0
#define O_BOT_LEFT Other->vX < 0 && Other->vY > 0


Circle::Circle(int X, int Y)
{
	size = rand() % 30;
	posX = X ;
	posY = Y;
	R = rand() % 255;
	G = rand() % 255;
	B = rand() % 255;
	vX = rand() % 10;
	vY = rand() % 10;
}


Circle::~Circle()
{
}

void Circle::ballMove(){

	posX += vX;
	posY += vY;

}

void Circle::wallHit(){
	int x1, x2, y1, y2;
	x1 = posX;
	y1 = posY;
	x2 = 500;
	y2 = 300;
	if (x1 + size > x2 || x1 - size < 0) vX *= -1;
	if (y1 + size > y2 || y1 - size < 0) vY *= -1;
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
		if (BOT_RIGHT && O_TOP_RIGHT){
			vY *= -1;
			Other->vY *= -1;
		}
		else if (BOT_RIGHT && O_TOP_LEFT){
			vX *= -1;
			Other->vX *= -1;
			vY *= -1;
			Other->vY *= -1;
		}
		else if (BOT_RIGHT && O_BOT_LEFT){
			vX *= -1;
			Other->vX *= -1;
		}
		else if (TOP_RIGHT && O_BOT_RIGHT){
			vY *= -1;
			Other->vY *= -1;
		}
		else if (TOP_RIGHT && O_TOP_LEFT){
			vX *= -1;
			Other->vX *= -1;
		}
		else if (TOP_RIGHT && O_BOT_LEFT){
			vX *= -1;
			Other->vX *= -1;
			vY *= -1;
			Other->vY *= -1;
		}
		else if (TOP_LEFT && O_TOP_RIGHT){
			vX *= -1;
			Other->vX *= -1;
		}
		else if (TOP_LEFT && O_BOT_RIGHT){
			vX *= -1;
			Other->vX *= -1;
			vY *= -1;
			Other->vY *= -1;
		}
		else if (TOP_LEFT && O_BOT_LEFT){
			vY *= -1;
			Other->vY *= -1;
		}
		else if (BOT_LEFT && O_TOP_LEFT){
			vY *= -1;
			Other->vY *= -1;
		}
		else if (BOT_LEFT && O_TOP_RIGHT){
			vX *= -1;
			Other->vX *= -1;
			vY *= -1;
			Other->vY *= -1;
		}
		else if (BOT_LEFT && O_BOT_RIGHT){
			vX *= -1;
			Other->vX *= -1;
		}
	}
}