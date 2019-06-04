//OBTIENE EL ANGULO MAXIMO CON O SIN AIRE
function [max_phi] = maxPhi(aire)
    
    iter_phi=0; //es el angulo que va a iterar
    max_phi=0; //angulo maximo
    max_dis=0; //distancia maxima hallada
    d_phi=1; //lo que vamos a iterar del angulo
    
    while (iter_phi<=90)  //iteramos hasta los 90 grados
        [x]=calcularRec(iter_phi,0.11,aire); // calculamos el recorrido en el eje X
        if(x(length(x))>max_dis) then //si este recorrido es mayor que el que teniamos
            max_dis=x(length(x));  //reemplazamos el actual con ese
            max_phi=iter_phi; //conseguimos el angulo que logro ese recorrido mayor
        end
        iter_phi=iter_phi+d_phi; //le sumamos la iteracion al angulo
    end
    
endfunction

//CALCULA EL TIEMPO EN ALCANZAR LA ALTURA MAXIMA
function [t] = maxM(y)
    
    m=0; //guardamos la maxima altura
    i=1; //iterador
    while(i<length(y)) //iteramos sobre todo el vector
        if(y(i)>m) //si la altura actual es mayor al maximo
            m=y(i); //el maximo es esa altura
            t=i; //conseguimos el tiempo de ese maximo
        end
        i=i+1; //seguimos iterando
    end
    t=t*0.001; //multiplicamos la cantidad de veces que se itero hasta subir por el tiempo entre cada intervalo
    
endfunction

//REALIZA METODO DE EULER Y OBTIENE 
//(X,Y,TRABAJO DEL AIRE,ENERGIA INICIAL,ENERGIA FINAL, TIEMPO)
function [x,y,trabajo,ei,ef,t] = calcularRec(phi,R,aire) 
                                            //phi: angulo
                                            //R: radio de la bola
                                            //aire: recorrido con o sin aire
    m=0.45; //masa de la bola
    g=9.8; //gravedad
    dt=0.001;//diferencial
    rho=1.2;//densidad del aire
    vo=30; //velocidad inicial
    
    // Condiciones iniciales
    
        //comenzamos en el (0,0)
        x(1)=0; 
        y(1)=0;
        
        //conseguimos la velocidad inicial en ambos ejes
        vox(1)=vo*cos(phi*%pi/180);
        voy(1)=vo*sin(phi*%pi/180);
        
        t(1)=0; //comenzamos en el tiempo 0
        i=1; //------------------------------------------------------------------------
        ei=m*(vo^2)/2; //energia inicial
        trabajo=0;
    
    while(y(i)>=0)
        // Caida libre
        if(aire==%T) //con aire
            FaireY= -1/2*rho*%pi*R^2*sqrt(vox(i)^2+voy(i)^2)*voy(i); //formula de la fuerza del aire en y
            FaireX= -1/2*rho*%pi*R^2*sqrt(vox(i)^2+voy(i)^2)*vox(i); //formula de la fuerza del aire en x
        else //sin aire
            FaireY=0;
            FaireX=0;
        end
            
        Fy = -g*m+FaireY; // fuerza en eje y con newton, fuerza de la gravedad + fuerza del aire en y
        
        ax = FaireX/m; //---------------------------------------------------------------
        ay = Fy/m;

        trabajo = trabajo + (FaireX*vox(i)*dt) + (FaireY*voy(i)*dt);
        
        vox(i+1)=vox(i)+ax*dt;
        voy(i+1)=voy(i)+ay*dt;
        
        x(i+1)=x(i)+vox(i)*dt;
        y(i+1)=y(i)+voy(i)*dt;
        
        t(i+1)=t(i)+dt;
        i=i+1; //---------------------------------------------------------------
    end
    
    ef=m*(vox(i)^2 + voy(i)^2)/2;
    
endfunction

//EJERCICIO 1
[s] = maxPhi(%F); //conseguimos el maximo angulo sin aire y lo guardamos en s
disp("MAXIMO PHI SIN AIRE")
disp(s); //mostramos s

scf(1) //lo colocamos en la ventana 1
[xN,yN]=calcularRec(s,0,%F); //calculamos el recorrido del angulo maximo
plot2d(xN,yN,-1); //lo ploteamos con los ejes x,y 

scf(1) //en la  misma ventana
t=length(yN)*0.001; //tiempo que demora en caer
xa = 30 * cos(s*%pi/180) * t; //posicion en x : vo.cos(phiMax).t 
ya = 30 * sin(s*%pi/180) * t - 9.8*t.^2/2;//posicion en y : vy.sin(phiMax).t
plot2d(xa,ya,-1); //lo ploteamos con los ejes x,y

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
