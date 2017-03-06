#include "wx/wx.h"
#pragma once

class Bounces
{
private:
	int radius;
	int x;
	int y;
	int speedX;
	int speedY;
	int *brush;

public:
	Bounces(void);
	~Bounces(void);
};

wxBrush *brush;

