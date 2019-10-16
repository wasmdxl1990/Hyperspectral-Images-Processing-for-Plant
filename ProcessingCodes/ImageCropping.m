function ImageCropping(rootfolder,a,b)
% initialization
[c name] = system('hostname');
fprintf('\n\nhostname:%s\n', name);

dt1=char(datetime);
fprintf('\n\nStart Date and Time:%s\n',dt1)

warning off

rootfolder=pathmodifier(rootfolder);

%%
fn=dir(rootfolder);

for i=3:length(fn)
    name=fn(i).name;   
    load(fullfile(rootfolder,name,'matfiles.mat'));  
    reference=cell2mat(DataCell(2,3));
    threshold=cell2mat(DataCell(2,4));

    C=strsplit(name,{'_','-'});
    if length(C)==4
        newfolder=fullfile(rootfolder,name,strcat('subimage_',name));
        mkdir(newfolder);
        
        [X1,X2,mask1,mask2,rgb1,rgb2]=imageslicer(X,mask,wavelength,a,b);
      
        if a>b
            filepart1=char(strcat(C(1),'_',C(2)));
            filepart2=char(strcat(C(1),'_',C(3)));
            [DCell1]=gettable(filepart1,rootfolder,reference,X1,mask1,wavelength,threshold);
            [DCell2]=gettable(filepart2,rootfolder,reference,X2,mask2,wavelength,threshold);
        elseif b>a
            filepart1=char(strcat(C(1),'_',C(3)));
            filepart2=char(strcat(C(1),'_',C(2)));
            [DCell1]=gettable(filepart2,rootfolder,reference,X2,mask2,wavelength,threshold);
            [DCell2]=gettable(filepart1,rootfolder,reference,X1,mask1,wavelength,threshold);
        elseif a=b
        end
        
       
        
        DataCell=[DCell1;DCell2(2,:)];
        
        % saving results
        savename=fullfile(newfolder,'matfiles');
        imwrite(rgb1,fullfile(newfolder,strcat(filepart1,'_RGB.png')),'png');
        imwrite(rgb2,fullfile(newfolder,strcat(filepart2,'_RGB.png')),'png');
        imwrite(mask1,fullfile(newfolder,strcat(filepart1,'mask.png')),'png');   
        imwrite(mask2,fullfile(newfolder,strcat(filepart2,'mask.png')),'png');  
        save(savename,'X1','X2','mask1','mask2','DataCell','wavelength','-v7.3');
        
    end
    
    if i==3
        DataTable=DataCell;
    else
        DataTable=[DataTable;DataCell(2:end,:)];
    end
  
end

[tabfolder,datefolder,~]=fileparts(rootfolder);

tablename=fullfile(tabfolder,strcat('CroppedTable_',datefolder));
save(tablename,'DataTable');

dt2=char(datetime);
fprintf('\n\nEnd Date and Time:%s\n',dt2)
