within ;
package ContainerExample
  import Modelica.SIunits.*;
constant Acceleration g = 9.81;

connector Massflow
  flow MassFlowRate m;
  Density rho;
end Massflow;



model Env
  Massflow out;
end Env;




model Container
// normal
  parameter Area A = 0.0003;
  parameter Length width = 0.2;
  Length height;
  Massflow massflow_out;
  Massflow massflow_in;
  Mass m;

equation
  der(m) = massflow_out.m + massflow_in.m;
  height* width^2*massflow_in.rho = m;
  massflow_out.m = if  (height<0.001) then 0 else   -A*sqrt(2*g*height)*massflow_in.rho;
  massflow_out.rho = massflow_in.rho;
end Container;

  model SimpleClass
  
    Env e1, e2;
    
    Container c(m(start = 20));
    
    equation
    c.massflow_in.m = 0.5;
    e1.out.rho = 1000;
    connect(e1.out, c.massflow_in);
    connect(c.massflow_out, e2.out); 
    
  end SimpleClass;

  model SimpleClass2
    Env e1, e2;
    Container c1, c2, c3;
    
    
  equation
    e1.out.m = -0.5;
    e1.out.rho = 1000;
    
    connect(e1.out, c1.massflow_in);
    connect(c1.massflow_out, c2.massflow_in);
    connect(c2.massflow_out, c3.massflow_in);
    connect(c3.massflow_out, e2.out);
    
  end SimpleClass2;

model SimpleClass3
  Env e1, e2, e3, e4, e5;
  Container c1(A = 0.001), c2, c3, c4, c5;
  
equation

  e1.out.m = -0.5;
  e1.out.rho = 1000;
  
  e2.out.m = -0.5;
  e4.out.m = -0.5;
  e5.out.m = -0.5;
  //e2.out.rho = 1000;
  
  connect(e1.out, c1.massflow_in);
  connect(e2.out, c2.massflow_in);
  connect(e4.out, c4.massflow_in);
  connect(e5.out, c5.massflow_in);
  
  connect(c1.massflow_out, c3.massflow_in);
  connect(c2.massflow_out, c3.massflow_in);
  
  connect(c4.massflow_out, c3.massflow_in);
  connect(c5.massflow_out, c3.massflow_in);
  
  connect(c3.massflow_out, e3.out);
end SimpleClass3;



  model SimpleClass4
    Env e1, e2, e3, e4;
    Container c1, c2, c3, c4, c5;
  equation
    e1.out.m = -0.5;
    e1.out.rho = 1000;
    e2.out.m = -0.5;
    

    connect(e1.out, c1.massflow_in);
    connect(e2.out, c2.massflow_in);
    connect(c3.massflow_out, c4.massflow_in);
    connect(c3.massflow_out, c5.massflow_in);
    connect(c4.massflow_out, e3.out);
    connect(c5.massflow_out, e4.out);
    
    connect(c1.massflow_out, c3.massflow_in);
    connect(c2.massflow_out, c3.massflow_in);
    c4.massflow_in.m = 2 * c5.massflow_in.m;
  
  end SimpleClass4;



  annotation (uses(Modelica(version="3.2")));
end ContainerExample;
