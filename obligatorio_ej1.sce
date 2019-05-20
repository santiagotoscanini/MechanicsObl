//Datos
v0=30;
dt=0.001;
d_phi=0.5;
ay = -9.8;

//Seteando los angulos

//ITERANDO VECTOR
//iter_phi(1)=0;
//xF(1)=0;
//j=1;

//ITERANDO NORMAL
iter_phi=0;
max_phi=0;
max_dis=0;

while (iter_phi<=90)
    //Datos de inicio
    y(1)=0;
    vy(1)=v0*sin(iter_phi*%pi/180);
    x(1)=0;
    vx=v0*cos(iter_phi*%pi/180);
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

    //ITERANDO
    //iter_phi(j+1)=iter_phi(j)+d_phi;
    //j=j+1;
    //xF(j)=x(i);
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

xa=x(1)+vx(1)*t;
ya=y(1)+vy(1)*t+ay*t.^2/2;
plot2d(xa,ya,-1);

