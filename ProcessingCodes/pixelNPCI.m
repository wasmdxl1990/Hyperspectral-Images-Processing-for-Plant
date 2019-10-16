function npci=pixelNPCI(X,wavelength)

% NPCI = [R(680)-R(430)]  /  [R(680)+R(430)]

[err1,i680]=min(abs(wavelength-680));

 [err2,i430]=min(abs(wavelength-430));
     if err1<2 & err2<2
          npci=mean((X(:,i680)-X(:,i430))./(X(:,i680)+X(:,i430)));
     else
        npci=NaN;
     end    
 
    