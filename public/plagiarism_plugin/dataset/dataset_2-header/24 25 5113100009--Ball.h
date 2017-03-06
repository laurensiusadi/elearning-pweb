#pragma once
#include "wx/wx.h"

class Ball
{
public:
	Ball(void);

	 void Ball::Collides(Ball *otherBall);

	 void Ball::Render(wxDC *dr);

	 void Ball::WallHitTest(int x1, int y1, int x2, int y2);

	~Ball(void);
};

