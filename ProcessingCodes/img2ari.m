function ARIimg=img2ari(img,wavelength,mask)

Band1=550;
Band2=700;

[~,Band1index]=min(abs(wavelength-Band1));
[~,Band2index]=min(abs(wavelength-Band2));

Band1mask=img(:,:,Band1index);
Band2mask=img(:,:,Band2index);

NDVImask=(1./Band1mask)-(1./Band2mask)+1;


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
ARIimg=NDVImask.*Nmask;






