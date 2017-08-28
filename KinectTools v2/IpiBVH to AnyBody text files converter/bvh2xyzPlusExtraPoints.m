function [xyz,ExtraPointsXYZ,RotMat] = bvh2xyzPlusExtraPoints(m,skel, channels, ExtraPoints)

% ExtraPoints(i).Name - "marker" name
% ExtraPoints(i).sRel - "marker" local coordinate
% Extrapoints(i).ParentName - The "marker"'s parent name
NumberOfPoints = length(ExtraPoints);
ExtraPointsXYZ = zeros([NumberOfPoints,3]);

for i = 1:length(skel.tree)  
  if ~isempty(skel.tree(i).posInd)
    xpos = channels(skel.tree(i).posInd(1));
    ypos = channels(skel.tree(i).posInd(2));
    zpos = channels(skel.tree(i).posInd(3));
  else
    xpos = 0;
    ypos = 0;
    zpos = 0;
  end
  xyzStruct(i) = struct('rotation', [], 'xyz', []); 

  
  if nargin < 2 | isempty(skel.tree(i).rotInd)
    xangle = 0;
    yangle = 0;
    zangle = 0;
    
  else
    xangle = deg2rad(channels(skel.tree(i).rotInd(1)));
    yangle = deg2rad(channels(skel.tree(i).rotInd(2)));
    zangle = deg2rad(channels(skel.tree(i).rotInd(3)));
  end
  thisRotation = RotMatFun(xangle, yangle, zangle, skel.tree(i).order);
  thisPosition = [xpos ypos zpos];
  if ~skel.tree(i).parent
    xyzStruct(i).rotation = thisRotation;
    xyzStruct(i).xyz = skel.tree(i).offset + thisPosition;
    for j=1:NumberOfPoints
        if (strcmp(skel.tree(i).name,ExtraPoints(j).ParentName)==1)
        ExtraPointsXYZ(j,:)=((xyzStruct(i).xyz)'+xyzStruct(i).rotation*((ExtraPoints(j).sRel))')';  
        end
    end
  else
    xyzStruct(i).xyz = ...
        (skel.tree(i).offset + thisPosition)*xyzStruct(skel.tree(i).parent).rotation' ...
        + xyzStruct(skel.tree(i).parent).xyz;
    xyzStruct(i).rotation = xyzStruct(skel.tree(i).parent).rotation*thisRotation;
    for j=1:NumberOfPoints
        if (strcmp(skel.tree(i).name,ExtraPoints(j).ParentName)==1)
        ExtraPointsXYZ(j,:)=((xyzStruct(i).xyz)'+xyzStruct(i).rotation*((ExtraPoints(j).sRel))')';  
        end
    end
  end  
       
end       

% xyz = reshape([xyzStruct(i:).xyz], 3, length(skel.tree))';
xyz = xyzStruct(m).xyz;
RotMat = xyzStruct(m).rotation;

