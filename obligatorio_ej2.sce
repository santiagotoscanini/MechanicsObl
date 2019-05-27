//DEFINIR FUNCION

function [m] = maxM(y)
    m=0;
    i=1;
    
    while(i<length(y))
        if(m<y(i))
            m=y(i);
        end
        i=i+1;
    end
endfunction
<<<<<<< Updated upstream

function [x,y] = calcularRec(phi)
=======
function [x,y,trabajo] = calcularRec(phi)
>>>>>>> Stashed changes
    m=0.45;
    g=9.8;
    dt=0.001;
    rho=1.2;
    R=0.11;
    v0=30;
    
    // Condiciones iniciales
    x(1)=0;
    y(1)=0;
    vx(1)=v0*cos(phi*%pi/180);
    vy(1)=v0*sin(phi*%pi/180);
    t(1)=0;
    i=1;
    
    trabajo=0;
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
        
        dX = x(i+1)-x(i);
        dY = y(i+1)-y(i);
        
        trabajo=trabajo + (Fx*dX) + ((Fy-(g*m))*dY)
        
        t(i+1)=t(i)+dt;
        i=i+1;
    end
endfunction

//ITERANDO NORMAL
iter_phi=0;
max_phi=0;
max_dis=0;
d_phi=1;
trabajo = 0;
while (iter_phi<=90)

    [x,y]=calcularRec(iter_phi);
    
    i=1;
    
    if(x(length(x))>max_dis) then
        max_dis=x(length(x));
        max_phi=iter_phi;        
    end
    
    iter_phi=iter_phi+d_phi;
end

disp(max_phi);

[x,y,tr]=calcularRec(max_phi);
scf(1)
plot2d(x,y,-9);

disp(tr);

[o,p,m]=calcularRec(90);
m=maxM(p);
disp(m);


