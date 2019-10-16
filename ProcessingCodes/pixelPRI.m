function pri=pixelPRI(X,wavelength)

% PRI = [R(570)-R(531)]  /  [R(570)+R(531)]

[err1,i570]=min(abs(wavelength-570));
[err2,i531]=min(abs(wavelength-531));
     if err1<2 & err2<2
         pri=mean((X(:,i570)-X(:,i531))./(X(:,i570)+X(:,i531)));
     else
         pri=NaN;
     end    
 
     