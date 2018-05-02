package rooms
  connector HeatTransfer
    flow Real dQ;
    Real T;
  end HeatTransfer;

  model Env
    HeatTransfer conn(T = 293);
  end Env;

  model Wall
    HeatTransfer conn1, conn2;
    parameter Real A = 9, d = 0.15, coeff = 0.06;
  equation
    conn1.dQ = A / d * coeff * (conn1.T - conn2.T);
    conn2.dQ = -conn1.dQ;
  end Wall;

  model Room
    HeatTransfer conn;
    parameter Real m = 100000 * V / (R * T0);
    //1.184; // calculating the initial mass in the system based on pV=mRT (we have p, V, R and T)
    constant Real R = 288;
    // gas constant given value from the slides
    parameter Real V = 25;
    // Volume
    parameter Real T0 = 293.15;
    // initial Temperature used in line 4
    constant Real cv = 720;
    // constant given in the slides
    Real u;
    // internal Energy of the system
    Real T(start = T0, fixed = true);
    // start temperature
    Real p;
    // pressure
    Real TC;
    // temperature in Celcisu
    Real dQ;
  equation
    der(u) = dQ / m;
// internal energy of system changes based on heat going out of system and U = u*m ==> and der(U) = dQ ==> der(u)*m = dQ ==> der(u) = dQ/m
    p * V = m * R * T;
// gas equation
    u = cv * T;
// equation to calculate internal energy
    TC = T - 273.15;
// calculating celsius from kelvin
    conn.T = T;
    conn.dQ = dQ;
    annotation(
      uses(Modelica(version = "3.2")));
  end Room;

  model Room1
    Room r(T0 = 260);
    Wall w;
    Env e;
  equation
    connect(e.conn, w.conn1);
    connect(w.conn2, r.conn);
  end Room1;

  model Room4Walls
    Room r(T0 = 260);
    Wall w1, w2, w3, w4;
    Env e;
  equation
    connect(e.conn, w1.conn1);
    connect(w1.conn2, r.conn);
    
    connect(e.conn, w2.conn1);
    connect(w2.conn2, r.conn);
    
    connect(e.conn, w3.conn1);
    connect(w3.conn2, r.conn);
    
    connect(e.conn, w4.conn1);
    connect(w4.conn2, r.conn);
  end Room4Walls;

end rooms;
