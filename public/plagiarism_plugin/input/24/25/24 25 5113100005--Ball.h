
#include"wx/wx.h"

class Ball
{
private:
	int x,y;
	int speedX, speedY;
	int r;

public:
	Ball();
	~Ball();
};

wxBrush *brush;