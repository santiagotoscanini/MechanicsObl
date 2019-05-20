clear
m=0.45;
g=9.8;
dt=0.001;
rho=1.2;
R=0.11;
v0=30;
d_phi=1;

//ITERANDO NORMAL
iter_phi=0;
max_phi=0;
max_dis=0;

while (iter_phi<=90)
    // Condiciones iniciales
    x(1)=0;
    y(1)=0;
    vx(1)=v0*cos(iter_phi*%pi/180);
    vy(1)=v0*sin(iter_phi*%pi/180);
    t(1)=0;
    i=1;
    
    while(y(i)>=0)
        // Caida libre
        Fx = -1/2*rho*%pi*R^2*sqrt(vx(i)^2+vy(i)^2)*vx(i);
        Fy = -g*m -1/2*rho*%pi*R^2*sqrt(vx(i)^2+vy(i)^2)*vy(i);
        
        ax = Fx/m;
        ay = Fy/m;
        
        vx(i+1)=vx(i)+ax*dt;
        vy(i+1)=vy(i)+ay*dt;
        
        x(i+1)=x(i)+vx(i)*dt;
        y(i+1)=y(i)+vy(i)*dt;
        
        t(i+1)=t(i)+dt;
        i=i+1;
    end
    
    if(x(i)>max_dis) then
        max_dis=x(i);
        max_phi=iter_phi;        
    end
    
    iter_phi=iter_phi+d_phi;
end

disp(max_phi);

//Datos de inicio
y(1)=0;
vy(1)=v0*sin(max_phi*%pi/180);
x(1)=0;
vx=v0*cos(max_phi*%pi/180);
t(1)=0;
i=1;

while (y(i)>=0)
    //Velocidad
    vy(i+1)=vy(i)+ay*dt;
    
    //Posiciones
    x(i+1)=x(i)+vx*dt;
    y(i+1)=y(i)+vy(i)*dt;
    
    //Seteo el tiempo
    t(i+1)=t(i)+dt;
    i=i+1;
end

scf(1)
plot2d(x,y,-9);

iter_phi=45;

x(1)=0;
y(1)=0;
vx(1)=v0*cos(iter_phi*%pi/180);
vy(1)=v0*sin(iter_phi*%pi/180);
t(1)=0;
i=1;


while(y(i)>=0)
    // Caida libre
    Fx = -1/2*rho*%pi*R^2*sqrt(vx(i)^2+vy(i)^2)*vx(i);
    Fy = -g*m -1/2*rho*%pi*R^2*sqrt(vx(i)^2+vy(i)^2)*vy(i);
    
    ax = Fx/m;
    ay = Fy/m;
    
    vx(i+1)=vx(i)+ax*dt;
    vy(i+1)=vy(i)+ay*dt;
    
    x(i+1)=x(i)+vx(i)*dt;
    y(i+1)=y(i)+vy(i)*dt;
    
    t(i+1)=t(i)+dt;
    i=i+1;
end

plot2d(x,y,-9);


iter_phi=90;

x(1)=0;
y(1)=0;
vx(1)=v0*cos(iter_phi*%pi/180);
vy(1)=v0*sin(iter_phi*%pi/180);
t(1)=0;
i=1;

max_h=0;
max_t=0;
while(y(i)>=0)
    // Caida libre
    Fx = -1/2*rho*%pi*R^2*sqrt(vx(i)^2+vy(i)^2)*vx(i);
    Fy = -g*m -1/2*rho*%pi*R^2*sqrt(vx(i)^2+vy(i)^2)*vy(i);
    
    ax = Fx/m;
    ay = Fy/m;
    
    vx(i+1)=vx(i)+ax*dt;
    vy(i+1)=vy(i)+ay*dt;
    
    x(i+1)=x(i)+vx(i)*dt;
    y(i+1)=y(i)+vy(i)*dt;
    
    t(i+1)=t(i)+dt;
    i=i+1;
    
   if y(i)>max_h
       max_h=y(i);
       max_t=t(i);
   end
end

disp(max_t);
