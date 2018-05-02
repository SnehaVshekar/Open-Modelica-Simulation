package CarTest

model cars
  car car1(F=0);
  car car2(F=-10000);
  car car3(F=0, angle = -18);
  car car4(F=0, angle = 18);
end cars;















model car

  constant Real g = 9.81;
  
  Real a, v, d;
  Real Fair;
  Real Foverall;
  Real Ffric;
  
  Real vMPH;
  
  parameter Real  m = 1500;
  parameter Real  F = 10000;
  parameter Real density = 1.225;
  parameter Real C = 0.29;
  parameter Real A = 2;
  parameter Real coeff = 0.3;
  
  parameter Real angle = 0;
  parameter Real angleRad = angle * 3.14 / 180;
  Real Fn, Fgdrive;
  
  
  equation
    m * a = Foverall; 
    Foverall = F + Fair + Ffric + Fgdrive; 
    der(v) = a;
    der(d) = v;
    
    Ffric = -sign(v) * Fn * coeff;
    Fair = -sign(v) * ((density * C * A)/2) * (v*v);
    
  
    Fn = m * g * cos(angleRad);
    Fgdrive = -m * g * sin(angleRad);
    
    
    vMPH * 1.6 = v * 1000 /(60 * 60);
  
end car;












































end CarTest;
