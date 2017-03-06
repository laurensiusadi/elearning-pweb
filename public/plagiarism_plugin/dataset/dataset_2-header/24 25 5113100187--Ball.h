#include <wx/wx.h>
#include <Windows.h>
#include <stdlib.h>

#include "wx/wx.h"

class Bounce{
private:
	int radius;
	
public:
	Bounce();
	~Bounce;
	int x;
	int y;
	int speedX;
	int speedY;
	int *brush;
};

wxBrush *brush;



