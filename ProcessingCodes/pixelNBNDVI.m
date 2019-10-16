function nbndvi=pixelNBNDVI(X,wavelength)

% NBNDVI = [R(850)-R(680)]  /  [R(850)+ R(680)]

[err1,i850]=min(abs(wavelength-850));
[err2,i680]=min(abs(wavelength-680));
     if err1<2 & err2<2
         nbndvi=mean((X(:,i850)-X(:,i680))./(X(:,i850)+X(:,i680)));
     else
         nbndvi=NaN;
     end    
 
    