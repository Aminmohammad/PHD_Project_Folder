clc

a = [ -1 2 3 -1 3 2 3 3 3 2 -1 ] ;
b = [ -1 3 3 -1 3 2 2 2 2 3 3 ] ;

output = MS_Error(  'selected_Classification_Method_Name', 'Test',  ...    
                    'classLabels_from_Net', b, ...
                    'classLabels_from_DataBank', a);
                            
                            
output.mean_Square_Error_Value                            
