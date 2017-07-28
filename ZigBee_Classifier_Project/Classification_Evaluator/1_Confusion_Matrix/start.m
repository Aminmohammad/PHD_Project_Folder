%             clc
%             a = randi ([ -1 4], 1, 10)';
%             b = randi ([ min(a) 3], 1, 10)';
clc
a = [ -1 2 3 -1 3 2 3 3 3 2 -1 ] ;
b = [ -1 3 3 -1 3 2 2 2 2 3 3 ] ;
% [ c , d ] = Confusion_Matrix(   'selected_Classification_Method_Name', 'Test',  ...    
%                                 'classLabels_from_Net', b, ...
%                                 'classLabels_from_DataBank', a);
% 
% 
% 


% or if you want to use structure:
d.selected_Classification_Method_Name = 'Test';   
d.classLabels_from_Net = a;
d.classLabels_from_DataBank = b;
d.selected_Evaluation_Method = 'Confusion_Matrix';
