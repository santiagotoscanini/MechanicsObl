m=3;
g=9.8;
dt=0.1;

// Condiciones iniciales
x(1)=0;
y(1)=10;
vx(1)=0;
vy(1)=0;
t(1)=1;
i=1;

while(y(i)>0)
// Caida libre
Fx = 0;
Fy = -g*m;

ax = Fx/m;
ay = Fy/m;

vx(i+1)=vx(i)+ax*dt;
vy(i+1)=vy(i)+ay*dt;

x(i+1)=x(i)+vx(i)*dt;
y(i+1)=y(i)+vy(i)*dt;

t(i+1)=t(i)+dt;
i=i+1;
end

// Graficas
scf(1)
plot2d(t,x);
scf(2)
plot2d(t,y); 
scf(3)
plot2d(x,y); // Trayectoria
