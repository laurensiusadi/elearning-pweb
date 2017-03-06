#include "Balls.h"


Balls::Balls(int x, int y, int radius)
	:x(x), y(y), r(radius)
{
		
}


Balls::~Balls()
{
}

void Balls::Render(wxDC *dc)
{
	dc->SetPen(*wxWHITE_PEN);
	dc->SetBrush(*wxBLACK_BRUSH);

	this->speedY = this->speedY + 0.5 * t;

	x = x + speedX;
	y = y + speedY;

	dc->DrawCircle(x, y, this->r);

	t += 0.01f;
}

void Balls::WallHitTest(int x1, int y1, int x2, int y2)
{
	if ((y - this->r)<y1 || (y + r)>y2)
		speedY = -speedY;
	if ((x - r)<x1 || x + r>x2)
		speedX = -speedX;
}

void Balls::Collides(Balls *otherBall)
{
	int xd = x - otherBall->x;
	int yd = y - otherBall->y;

	float sumR = r + otherBall->r;
	float sqrR = sumR*sumR;

	float distSqr = (xd*xd) + (yd*yd);

	if (distSqr <= sqrR)
	{
		speedX *= -1;
		speedY *= -1;
	}
}