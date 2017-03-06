#pragma once
#include<iostream>
#include "wx\wx.h"

using namespace std;

class Balls
{
public:
	Balls(int x, int y, int radius);
	~Balls();
	void Render(wxDC *dc);
	void Collides(Balls *otherBall);
	void WallHitTest(int x1, int y1, int x2, int y2);
private:
	int x;
	int y;
	int r;
	int speedX;
	int speedY;
	float time;
};