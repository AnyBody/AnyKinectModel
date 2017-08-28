# -*- coding: utf-8 -*-
"""
Created on Tue Dec 13 14:33:49 2011

Script to batch process AnyBody models.  Requires the 
package AnyPyTools. 

@author: Morten Enemark Lund
"""
import os
import time
from anypytools.abcutils import AnyBatchProcess


folder = os.path.join(os.getcwd(),'Subjects/')
abp = AnyBatchProcess(basepath = folder,
                      searchfile = 'Kinematics.main.any',
                      num_processes = 3)

macro =  ['load "Kinematics.main.any"', 
            'operation Main.RunMotionAndParameterOptimizationSequence',
        'run',
        'exit',' ']

		  
abp.start(macro)

