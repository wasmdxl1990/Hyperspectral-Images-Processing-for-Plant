function sipi=pixelSIPI(X,wavelength)


[err1,i800]=min(abs(wavelength-800));
[err2,i445]=min(abs(wavelength-445));  
[err3,i680]=min(abs(wavelength-680));
     if err1<2 & err2<2 & err3<2
         sipi=mean((X(:,i800)-X(:,i445))./(X(:,i800)+X(:,i680)));
     else
         sipi=NaN;
     end  
   