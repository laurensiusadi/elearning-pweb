#include <wx/wx.h>

class ball
{
public:
	float radius;
	float x;
	float y;
	float speedX;
	float speedY;
	
	ball(float x, float y);

	void HitWall(int x1, int y1, int x2, int y2);
	void Collides(ball *otherBall);
	void move();
};
