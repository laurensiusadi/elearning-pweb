#include "wx/wx.h"
#pragma once

class Bounce
{
private:
	int radius;
	int x;
	int y;
	int speedX;
	int speedY;
	int *brush;

public:
	Bounce(void);
	~Bounce(void);
};

wxBrush *brush;
