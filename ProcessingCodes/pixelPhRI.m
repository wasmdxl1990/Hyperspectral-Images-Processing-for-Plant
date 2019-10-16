function phri=pixelPhRI(X,wavelength)

% PhRI = [R(550)-R(531)]  /  [R(550)+R(531)]

[err1,i550]=min(abs(wavelength-550));
 [err2,i531]=min(abs(wavelength-531));
     if err1<2 & err2<2
         phri=mean((X(:,i550)-X(:,i531))./(X(:,i550)+X(:,i531)));
     else
         phri=NaN;
     end    
 
   