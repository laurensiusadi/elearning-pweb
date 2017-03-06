#pragma once
#include <math.h>
#include <iostream>

class Bulat
{
public:
	int pos1;
	int pos2;
	int size;
	int kecX;
	int kecY;

	Bulat(int a, int b);
	~Bulat();

	void Move(){
		pos1 += kecX;
		pos2 += kecY;

	}

	void TabrakD(){
		int x1, y1, x2, y2;
		x1 = pos1;
		y1 = pos2;
		x2 = 500;
		y2 = 300;
		if (x1 + size > x2 || x1 - size < 0) 
			kecX *= -1;
		if (y1 + size > y2 || y1 - size < 0) 
			kecY *= -1;
	}

	void TabrakB(Bulat *OtherBall){
		int x1 = pos1,
			y1 = pos2,
			x2 = OtherBall->pos1,
			y2 = OtherBall->pos2;
		int xnew = x2 - x1;
		int ynew = y2 - y1;
		float distance;
		distance = xnew*xnew + ynew*ynew;
		distance =(sqrt(distance));
		if (distance < size + OtherBall->size){
			kecX = -kecX;
			kecY = -kecY;
			OtherBall->kecX = -OtherBall->kecX;
			OtherBall->kecY = -OtherBall->kecY;
		}
	}
};