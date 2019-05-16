//Datos
v0=30;
dt=0.001;
d_phi=0.1;
ay = -9.8;

//Seteando los angulos
iter_phi(1)=0;
xF(1)=0;

j=1;

while (iter_phi(j)<=90)
    //Datos de inicio
    y(1)=0;
    vy(1)=v0*sin(iter_phi(j)*%pi/180);
    x(1)=0;
    vx=v0*cos(iter_phi(j)*%pi/180);
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
    //scf(2)
    //plot2d(x,y,-6);
    
    iter_phi(j+1)=iter_phi(j)+d_phi;
    j=j+1;
    xF(j)=x(i);
end

scf(1)
plot2d(iter_phi,xF,-6);

