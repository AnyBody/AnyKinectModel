function [out] = ConvertBVHToAny(filename)

[skel, channels, frameLength] = bvhReadFile(filename);

%create a new folder to save the file
FolderName = skel.name(1:length(skel.name)-4);
mkdir(FolderName);

%for m= 1: 2

for m= 1: length(skel.tree)
    
    Name = skel.tree(m).name;
    ExtraPoints(m,1)=struct('name',strcat(Name,'X'),'sRel',[100,0,0],'ParentName',Name);
    ExtraPoints(m,2)=struct('name',strcat(Name,'Y'),'sRel',[0,100,0],'ParentName',Name);
    ExtraPoints(m,3)=struct('name',strcat(Name,'Z'),'sRel',[0,0,100],'ParentName',Name);
    
        
    fid(m,1)=fopen(sprintf('%s/%s',FolderName,strcat(Name,'X','.txt')),'w');
    fid(m,2)=fopen(sprintf('%s/%s',FolderName,strcat(Name,'Y','.txt')),'w');
    fid(m,3)=fopen(sprintf('%s/%s',FolderName,strcat(Name,'Z','.txt')),'w');
    fid(m,4)=fopen(sprintf('%s/%s',FolderName,strcat(Name,'InitPos','.txt')),'w');
    

    
    for k= 1:size (channels,1)
        [xyz,ExtraPointsXYZ,RotMat] = bvh2xyzPlusExtraPoints(m, skel, channels(k,:),ExtraPoints(m,:));
        time=frameLength*(k-1);
        
        if k==1
            fprintf(fid(m,4),'%.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f %.15f\r\n',time,xyz/100,RotMat(1,:),RotMat(2,:),RotMat(3,:) );

        end
        

        fprintf(fid(m,1),'%.15f %.15f %.15f %.15f\r\n',time,ExtraPointsXYZ(1,:)/100);
        fprintf(fid(m,2),'%.15f %.15f %.15f %.15f\r\n',time,ExtraPointsXYZ(2,:)/100);
        fprintf(fid(m,3),'%.15f %.15f %.15f %.15f\r\n',time,ExtraPointsXYZ(3,:)/100);
    end
    
    
end

fclose('all');


