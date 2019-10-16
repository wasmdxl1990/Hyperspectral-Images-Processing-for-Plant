function NPCIimg=img2npci(img,wavelength,mask)

Band1=430;
Band2=680;

[~,Band1index]=min(abs(wavelength-Band1));
[~,Band2index]=min(abs(wavelength-Band2));

Band1mask=img(:,:,Band1index);
Band2mask=img(:,:,Band2index);

NDVImask=(Band2mask-Band1mask)./(Band2mask+Band1mask)+1;


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
NPCIimg=NDVImask.*Nmask;

