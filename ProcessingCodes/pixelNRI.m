function nri=pixelNRI(X,wavelength)

% NRI = [R(570)-R(670)]  /  [R(570)+R(670)]

[err1,i570]=min(abs(wavelength-570));
[err2,i670]=min(abs(wavelength-670));
     if err1<2 & err2<2
        nri=mean((X(:,i570)-X(:,i670))./(X(:,i570)+X(:,i670)));
     else
        NRI=NaN;
     end    
 
