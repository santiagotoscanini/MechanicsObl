//OBTIENE EL ANGULO MAXIMO
function [max_phi] = maxPhi(aire)
    iter_phi=0;
    max_phi=0;
    max_dis=0;
    d_phi=1;
    while (iter_phi<=90)
    
        [x,y]=calcularRec(iter_phi,0.11,aire);    
        i=1;
        
        if(x(length(x))>max_dis) then
            max_dis=x(length(x));
            max_phi=iter_phi;        
        end
        
        iter_phi=iter_phi+d_phi;
    end
endfunction
//CALCULA EL TIEMPO DEL RECORRIDO TOTAL
function t = maxT(y)
    i=1;
    
    while(i<length(y))
        t=i;
        i=i+1;
    end
    t=t*0.001;
endfunction
//CALCULA EL TIEMPO EN ALCANZAR LA ALTURA MAXIMA
function [t] = maxM(y)
    m=0;
    i=1;
    
    while(i<length(y))
        if(m<y(i))
            m=y(i);
            t=i;
        end
        i=i+1;
    end
    t=t*0.001;
endfunction
//REALIZA METODO DE EULER Y OBTIENE (X,Y,TRABAJO DEL AIRE,ENERGIA INICIAL,ENERGIA FINAL)
function [x,y,trabajo,ei,ef,t] = calcularRec(phi,R,aire)

    m=0.45;
    g=9.8;
    dt=0.001;
    rho=1.2;
    v0=30;
    
    // Condiciones iniciales
    x(1)=0;
    y(1)=0;
    vx(1)=v0*cos(phi*%pi/180);
    vy(1)=v0*sin(phi*%pi/180);
    t(1)=0;
    i=1;
    ei=m*(v0^2)/2;
    
    trabajo=0;
    while(y(i)>=0)
        // Caida libre
        if(aire==%T)
            FaireY=-1/2*rho*%pi*R^2*sqrt(vx(i)^2+vy(i)^2)*vy(i);
            Fx = -1/2*rho*%pi*R^2*sqrt(vx(i)^2+vy(i)^2)*vx(i);
        else
            FaireY=0;
            Fx=0;
        end

        Fy = -g*m+FaireY;
        
        ax = Fx/m;
        ay = Fy/m;

        trabajo=trabajo + (Fx*vx(i)*dt) + (FaireY*vy(i)*dt);
        
        vx(i+1)=vx(i)+ax*dt;
        vy(i+1)=vy(i)+ay*dt;
        
        x(i+1)=x(i)+vx(i)*dt;
        y(i+1)=y(i)+vy(i)*dt;
        
        t(i+1)=t(i)+dt;
        i=i+1;
    end
    
    ef=m*(vx(i)^2 + vy(i)^2)/2;
endfunction

//EJERCICIO 1
[s]=maxPhi(%F); //NUMERICO
disp("MAXIMO PHI SIN AIRE")
disp(s);

scf(1)
[xN,yN]=calcularRec(s,0,%F);
plot2d(xN,yN,-1);

scf(1)
t=maxT(yN);
xa=30*cos(s*%pi/180)*t;
ya=30*sin(s*%pi/180)*t-9.8*t.^2/2;
plot2d(xa,ya,-1);

//EJERCICIO 2

//ANGULO MAXIMO
[a]=maxPhi(%T);
disp("ANGULO MAXIMO CON AIRE")
disp(a);

//TIEMPO EN ALCANZAR ALTURA MAXIMA CON AIRE
[o,p,m]=calcularRec(90,0.11,%T);
m=maxM(p);
disp("TIEMPO EN ALCANZAR ALTURA MAXIMA")
disp(m);

//TRBAJO Y ENERIGA
[x,y,tr,e,f]=calcularRec(a,0.11,%T);
scf(2)
plot2d(x,y,-9);
disp("TRABAJO");
disp(tr);
disp("ENERGIA");
disp(f-e);

