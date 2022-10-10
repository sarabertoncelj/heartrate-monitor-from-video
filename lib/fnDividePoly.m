function [PXY, Xnew, Ynew] = fnDividePoly(polygon,nX,nY)

Xnew = zeros(nY+1, nX+1);
Ynew = zeros(nY+1, nX+1);   
    
d1 = sqrt((polygon.x(2)-polygon.x(1))^2+(polygon.y(2)-polygon.y(1))^2)/nX;
k1 = (polygon.y(2)-polygon.y(1))/(polygon.x(2)-polygon.x(1));

dy1 = sqrt((polygon.x(4)-polygon.x(1))^2+(polygon.y(4)-polygon.y(1))^2)/nY;
ky1 = (polygon.x(4)-polygon.x(1))/(polygon.y(4)-polygon.y(1));
        
dyNx = sqrt((polygon.x(3)-polygon.x(2))^2+(polygon.y(3)-polygon.y(2))^2)/nY;
kyNx = (polygon.x(3)-polygon.x(2))/(polygon.y(3)-polygon.y(2));
    
Xnew(1,1) = polygon.x(1);
Ynew(1,1) = polygon.y(1);
Xnew(1,nX+1) = polygon.x(2);
Ynew(1,nX+1) = polygon.y(2);
  
for j = 2:nX
    Xnew(1,j) = Xnew(1,j-1) + (d1*cos(k1));
    Ynew(1,j) = Ynew(1,j-1) + (d1*sin(k1));
end

for i = 2:nY+1 
    Xnew(i,1) = Xnew(i-1,1) + (dy1*sin(ky1));
    Ynew(i,1) = Ynew(i-1,1) + (dy1*cos(ky1));
    Xnew(i,nX+1) = Xnew(i-1,nX+1) + (dyNx*sin(kyNx));
    Ynew(i,nX+1) = Ynew(i-1,nX+1) + (dyNx*cos(kyNx));
    
    di = sqrt((Xnew(i,1) - Xnew(i,nX+1))^2 + (Ynew(i,1) - Ynew(i,nX+1))^2)/nX;
    ki = (Ynew(i,nX+1)-Ynew(i,1))/(Xnew(i,nX+1)-Xnew(i,1)); 
 
    for j = 2:nX
        Xnew(i,j) = Xnew(i,j-1) + (di*cos(ki));
        Ynew(i,j) = Ynew(i,j-1) + (di*sin(ki));
    end
     
end


% Xnew(nY+1,1) = polygon.x(4);
% Ynew(nY+1,1) = polygon.y(4);
% 
% dnY = sqrt((polygon.x(3)-polygon.x(4))^2+(polygon.y(3)-polygon.y(4))^2)/nX;
% knY = (polygon.y(3)-polygon.y(4))/(polygon.x(3)-polygon.x(4));
% for j = 2:nX
%     Xnew(nY+1,j) = Xnew(i,j-1) + round(dnY*cos(knY));
%     Ynew(nY+1,j) = Ynew(i,j-1) + round(dnY*sin(knY));
% end
% Xnew(nY+1,nX+1) = polygon.x(3);
% Ynew(nY+1,nX+1) = polygon.y(3);

for j=1:nX
    for i=1:nY
        PXY{j,i}.x = [Xnew(i,j) Xnew(i,j+1) Xnew(i+1,j+1) Xnew(i+1,j)];
        PXY{j,i}.y = [Ynew(i,j) Ynew(i,j+1) Ynew(i+1,j+1) Ynew(i+1,j)];
    end
end