function ari=pixelARI(X,wavelength)

% ARI = [1/R(550)]  -  [1/R(700)]

[err1,i550]=min(abs(wavelength-550));
[err2,i700]=min(abs(wavelength-700));
     if err1<2 & err2<2
         ari=mean((X(:,i700)-X(:,i550))./(X(:,i550).*X(:,i700)));
     else
        ari=NaN;
     end    
 
    
%     ari_img=(1./r550)-(1./r700);