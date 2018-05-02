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
    e1.out.m = -0.5;
    e1.out.rho = 1000;
    connect(e1.out, c.massflow_in);
    connect(c.massflow_out, e2.out); 
    
  end SimpleClass;








  annotation (uses(Modelica(version="3.2")));
end ContainerExample;