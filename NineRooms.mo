package NineRooms
import Modelica.SIUnits.*;

  
model environment
  pipe outflow; 
end environment;

model room
// this is similar to fridge model

  constant Real R = 288;     // gas constant
  constant Real V = 4*4*4;  // Volume of the room
  constant Real cv = 720; // specific heat capacity
  
  parameter Real T0 =20.0;         // initial Temperature
  parameter Real m = 100000 * 1 / (R * T0);
  
  Real u; //internal Energy of the system
  Real T(start=T0, fixed= true); // start temperature
  Real Q;  // Heat Energy going out of the room
  Real p;     // pressure
  pipe roomFlow;
  
equation
  
  roomFlow.T = T;
  u = cv *T; // equation to calculate internal energy
  p * V= m*R*T; // gas equation
  der(u) = Q/m; 
  Q = (-1) * roomFlow.Qdash;
    
end room;



















model wall

  // describing the wall - length and width
  constant Real l=4.0;
  constant Real w=4.0;
  
  //describing the wall for heat conductivity
  constant Real t=0.25;  //thickness of the wall
  constant Real k=0.16; //hardwood thermal conductivity
  
  Real A; //area of the wall 
  Real Q; // heatflow 
  Real dT;  // difference in temperature over the wall material
  
  pipe innerflow;
  pipe outerflow;

equation

  dT=outerflow.T - innerflow.T;
  Q=(k/t) * A * dT;
  A=l*w; //area of the wall
  
  outerflow.Qdash = innerflow.Qdash;
  outerflow.Qdash = Q;
  
end wall;







connector pipe
   Real T;
   flow Real Qdash;
end pipe;

model building

wall wall01,wall02,wall03,wall11,wall12,wall23,wall33,wall41,wall25,wall36,wall14,wall45,wall56,wall66,wall47,wall58,wall69,wall17,wall78,wall89,wall99,wall07,wall08,wall09;

room room1,room2,room3,room4,room5,room6,room7,room8,room9;

environment env;

equation
env.outflow.T= 0.0;// temperature is in degree celcius --> this is zero degrees

connect(room5.roomFlow, wall58.innerflow);
connect(room5.roomFlow, wall56.innerflow);
connect(room5.roomFlow, wall25.innerflow);
connect(room5.roomFlow, wall45.innerflow);

connect(room2.roomFlow, wall02.innerflow);
connect(room2.roomFlow, wall23.innerflow);
connect(room2.roomFlow, wall12.innerflow);
connect(room2.roomFlow, wall25.outerflow);

connect(room8.roomFlow, wall08.innerflow);
connect(room8.roomFlow, wall78.innerflow);
connect(room8.roomFlow, wall89.innerflow);
connect(room8.roomFlow, wall58.outerflow);

connect(room1.roomFlow, wall11.innerflow);
connect(room1.roomFlow, wall01.innerflow);
connect(room1.roomFlow, wall12.outerflow);
connect(room1.roomFlow, wall41.outerflow);

connect(room7.roomFlow, wall17.innerflow);
connect(room7.roomFlow, wall07.innerflow);
connect(room7.roomFlow, wall78.outerflow);
connect(room7.roomFlow, wall47.outerflow);

connect(room3.roomFlow, wall03.innerflow);
connect(room3.roomFlow, wall33.innerflow);
connect(room3.roomFlow, wall23.outerflow);
connect(room3.roomFlow, wall36.outerflow);

connect(room9.roomFlow, wall09.innerflow);
connect(room9.roomFlow, wall99.innerflow);
connect(room9.roomFlow, wall69.outerflow);
connect(room9.roomFlow, wall89.outerflow);

connect(room4.roomFlow, wall41.innerflow);
connect(room4.roomFlow, wall14.innerflow);
connect(room4.roomFlow, wall47.innerflow);
connect(room4.roomFlow, wall45.outerflow);

connect(room6.roomFlow, wall69.innerflow);
connect(room6.roomFlow, wall66.innerflow);
connect(room6.roomFlow, wall36.innerflow);
connect(room6.roomFlow, wall56.outerflow);

connect(env.outflow,wall01.outerflow);
connect(env.outflow,wall02.outerflow);
connect(env.outflow,wall03.outerflow);
connect(env.outflow,wall33.outerflow);
connect(env.outflow,wall66.outerflow);
connect(env.outflow,wall99.outerflow);
connect(env.outflow,wall09.outerflow);
connect(env.outflow,wall08.outerflow);
connect(env.outflow,wall07.outerflow);
connect(env.outflow,wall17.outerflow);
connect(env.outflow,wall14.outerflow);
connect(env.outflow,wall11.outerflow);



end building;








end NineRooms;
