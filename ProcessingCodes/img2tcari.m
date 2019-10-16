function TCARIimg=img2tcari(img,wavelength,mask)

Band1=550;
Band2=600;
Band3=670;
Band4=700;
Band5=850;


[~,Band1index]=min(abs(wavelength-Band1));
[~,Band2index]=min(abs(wavelength-Band2));
[~,Band3index]=min(abs(wavelength-Band3));
[~,Band4index]=min(abs(wavelength-Band4));
[~,Band5index]=min(abs(wavelength-Band5));


Band1mask=img(:,:,Band1index);
Band2mask=img(:,:,Band2index);
Band3mask=img(:,:,Band3index);
Band4mask=img(:,:,Band4index);
Band5mask=img(:,:,Band5index);

NDVImask=3.*((Band4mask-Band2mask)-0.2.*(Band4mask-Band1mask).*(Band4mask./(Band5mask+Band3mask)));


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
TCARIimg=NDVImask.*Nmask;
