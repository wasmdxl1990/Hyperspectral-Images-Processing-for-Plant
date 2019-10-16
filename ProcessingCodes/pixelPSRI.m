function psri=pixelPSRI(X,wavelength)

% PSRI = [R(678)-R(500)]  /  [R(750)]

[err1,i678]=min(abs(wavelength-678));
 [err2,i500]=min(abs(wavelength-500)); 
 [err3,i750]=min(abs(wavelength-750));
     if err1<2 & err2<2 & err3<2
          psri=mean((X(:,i678)-X(:,i500))./(X(:,i750)));
     else
         psri=NaN;
     end  
 