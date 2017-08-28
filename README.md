# AnyKinectModel

This project contains a model and a set of MatLab tools that enable to use kinect data for running an AnyBody Model. 
 
The model utililize a BVH file obtained with the IPi software (http://ipisoft.com/). The BVH file is processed by a MatLab? Script which ensures the angles from IPI are correct and has no gimbal locks
 
1. Please download the two files in the files section of this project and unzip the model and the tool
2. Then download these two tools
        ndlutil: https://github.com/SheffieldML/ndlutil
        mocap: https://github.com/SheffieldML/mocap
3. Unzip the files. The path for the installation needs to be inserted in the "ConvertMultipleFile.m" 
4. addpath('../../mocap-master');
5. addpath('../../ndlutil-master');

Please notice that the model was originally developed for AnyBody Managed Model Repository version 1.5 and incompatibility issues with later versions can occur.