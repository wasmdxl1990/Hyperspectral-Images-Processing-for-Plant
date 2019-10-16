function tcari=pixelTCARI(X,wavelength)

% TCARI = 3 [(R(700)-R(600))- 0.2 (R700-R550) * R700/(R850+R670)]  

[err1,i700]=min(abs(wavelength-700));
 [err2,i600]=min(abs(wavelength-600)); 
 [err3,i550]=min(abs(wavelength-550));
 [err4,i850]=min(abs(wavelength-850));
 [err5,i670]=min(abs(wavelength-670));
     if err1<2 & err2<2 & err3<2 & err4<2 & err5<2
         tcari=mean(3*[(X(:,i700)-X(:,i600)) - 0.2*(X(:,i700)-X(:,i550)) .* X(:,i700)./(X(:,i850)+X(:,i670))]);
     else
         tcari=NaN;
     end     

