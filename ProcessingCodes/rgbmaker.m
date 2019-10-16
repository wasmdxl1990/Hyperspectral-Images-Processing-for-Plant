function rgb=rgbmaker(X,wavelength,mask)

redband=680;
greenband=510;
blueband=475;

[~,rindex]=min(abs(wavelength-redband));
[~,gindex]=min(abs(wavelength-greenband));
[~,bindex]=min(abs(wavelength-blueband));

r=zeros(size(mask));
g=zeros(size(mask));
b=zeros(size(mask));

r(mask)=X(:,rindex);
g(mask)=X(:,gindex);
b(mask)=X(:,bindex);

rgb=cat(3,r,g,b);

end
