function [X1,X2,mask1,mask2,rgb1,rgb2]=imageslicer(X,mask,wavelength,a,b)

[row,col]=size(mask);
dummy=zeros(row,col);
[~,r1]=imstack2vectors(dummy,mask);

alim=floor(row/a);
blim=floor(col/b);
if a<b
    m1=dummy;
    m1(:,1:blim)=1;
    m2=dummy;
    m2(:,blim:end)=1;    
    mask1=logical(mask.*m1);
    mask2=logical(mask.*m2);
elseif b<a
    m1=dummy;
    m1(1:alim,:)=1;
    m2=dummy;
    m2(alim:end,:)=1;    
    mask1=logical(mask.*m1);
    mask2=logical(mask.*m2);
end
    
[~,r]=imstack2vectors(dummy,mask);
[~,r1]=imstack2vectors(dummy,mask1);
[~,r2]=imstack2vectors(dummy,mask2);

R=sub2ind([row col],r(:,1),r(:,2));
R1=sub2ind([row col],r1(:,1),r1(:,2));
R2=sub2ind([row col],r2(:,1),r2(:,2));

[C1,ia1,ib1]=intersect(R,R1);
[C2,ia2,ib2]=intersect(R,R2);

X1=X(ia1,:);
X2=X(ia2,:);

rgb1=rgbmaker(X1,wavelength,mask1);
rgb2=rgbmaker(X2,wavelength,mask2);
end






