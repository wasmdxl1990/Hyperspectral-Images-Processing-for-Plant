function rgb=img2rgb(img,wavelength)

redband=680;
greenband=510;
blueband=475;

[~,rindex]=min(abs(wavelength-redband));
[~,gindex]=min(abs(wavelength-greenband));
[~,bindex]=min(abs(wavelength-blueband));

r=img(:,:,rindex)/768;
g=img(:,:,gindex)/768;
b=img(:,:,bindex)/768;
%r=(r-min(min(r)))/(max(max(r))-min(min(r)));
%g=(g-min(min(g)))/(max(max(g))-min(min(g)));
%b=(b-min(min(b)))/(max(max(b))-min(min(b)));

%r1=imadjust(r,[],[],0.5);
%g1=imadjust(g,[],[],0.5);
%b1=imadjust(b,[],[],0.5);
rgb=cat(3,r,g,b);
