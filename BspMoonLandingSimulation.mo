package moon
// hier wird die Mondlandung mit Hilfe von Vererbung realisiert
model MoonLanding
	parameter Real force1 = 36350;
	parameter Real force2 = 1308;
	parameter Real thrustEndTime = 210;
	parameter Real thrustDecreaseTime = 43.2;
	Rocket apollo(name="apollo13", mass(start=1038.358) );
	CelestialBody moon(mass=7.382e22,radius=1.738e6,name="moon");
equation
	apollo.thrust = if (time<thrustDecreaseTime) then force1
	else if (time<thrustEndTime) then force2
	else 0;
	apollo.gravity =moon.g*moon.mass/(apollo.altitude+moon.radius)^2;
end MoonLanding;

model CelestialBody
	extends Body;
	constant Real g = 6.672e-11;
	parameter Real radius;
end CelestialBody;

model Body "generic body"
	Real mass;
	String name;
end Body;

model Rocket "generic rocket class"
	extends Body;
	parameter Real massLossRate=0.000277;
	Real altitude(start= 59404);
	Real velocity(start= -2003);
	Real acceleration;
	Real thrust;
	Real gravity;
equation
	thrust-mass*gravity= mass*acceleration;
	der(mass)= -massLossRate*abs(thrust);
	der(altitude)= velocity;
	der(velocity)= acceleration;
end Rocket;



end moon;
