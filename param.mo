package par
  model para
   parameter Real t(fixed = false);
   parameter Real i=9;
  initial equation
  t = i+2;
  end para;

  model System
    para p(i=1);
    para p1;
  end System;
end par;
