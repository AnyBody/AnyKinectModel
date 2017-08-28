# -*- coding: utf-8 -*-
"""
Created on Tue Dec 13 14:33:49 2011

Script to batch process AnyBody models.  Requires the 
package AnyPyTools. 

@author: Morten Enemark Lund
"""
import os
import time
try:
	from anypytools.abcutils import AnyBatchProcess
except ImportError:
	print "The package AnyPyTools needs to be installed. Please contact Morten Enemark Lund mel@m-tech.aau.dk"
	time.sleep(6)


folder = os.path.join(os.getcwd(),'Subjects')
abp = AnyBatchProcess(basepath = folder,
                      searchfile = 'InverseDynamics.main.any',
                      num_processes = 1)
folder
macro =  ['load "InverseDynamics.main.any"', 
         'operation  Main.InverseDynamicAnalysisSequence',
         'run',
         'operation Main.SaveResults',
         'run',
         'exit']

		  
abp.start(macro)

