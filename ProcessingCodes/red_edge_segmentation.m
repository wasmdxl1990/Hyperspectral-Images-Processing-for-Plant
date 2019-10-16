function [mask,t]=red_edge_segmentation(img,wavelength,threshold)

% bands=size(img,3);

lin=transpose(-20:20);
t=zeros(size(img,1),size(img,2));

redband=680;
[~,rindex]=min(abs(wavelength-redband));

for i=1:size(img,1)
    
    t(i,:)=(lin'*transpose(squeeze(img(i,:,rindex:rindex+40))))/(lin'*lin);
    
%     if bands<600
%         t(i,:)=(lin'*transpose(squeeze(img(i,:,225:265))))/(lin'*lin);
%     else
%         t(i,:)=(lin'*transpose(squeeze(img(i,:,460:500))))/(lin'*lin);  
%     end
end
% mask=t>20;
mask=t>threshold;

