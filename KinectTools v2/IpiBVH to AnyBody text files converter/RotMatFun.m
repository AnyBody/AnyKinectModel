function rotMat = RotMatFun(xangle, yangle, zangle, order);

if nargin < 4
  order = 'zxy';
end
if isempty(order)
  order = 'zxy';
end

  rotMat = eye(3);
  for i = 1:length(order)
    switch order(i)
     case 'x'
      c1 = cos(xangle);
      s1 = sin(xangle);
      rotMat = rotMat*[1 0 0
                0  c1 -s1
                0 s1 c1];
        case 'y'
      c2 = cos(yangle);
      s2 = sin(yangle);

    rotMat = rotMat*[c2 0 s2
                0 1 0
                -s2 0 c2];
     case 'z' 
      c3 = cos(zangle);
      s3 = sin(zangle);

       rotMat = rotMat*[c3 -s3 0
                s3 c3 0
                0 0 1];
      
    end
  
end
