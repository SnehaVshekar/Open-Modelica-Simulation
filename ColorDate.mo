package color
record ColorData
	parameter Real red = 0.2;
	parameter Real blue = 0.6;
	Real green;
end ColorData;

////////////////////////////////////////

class Color
	extends ColorData;
equation
	red + blue + green = 1;
end Color;

////////////////////////////////////

class ErrorColor
  extends Color;
equation
  red + blue + green = 1;
end ErrorColor;

////////////////////////////////////

class ErrorColor2
  extends Color;
equation
  red + blue + green = 1.0;
end ErrorColor2;

end color;
