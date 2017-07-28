%             clc
%             a = randi ([ -1 4], 1, 10)';
%             b = randi ([ min(a) 3], 1, 10)';
clc
close all
    data=load('fisheriris');

    X=data.meas';

Y = [ ones(1,50)  2*ones(1,50)  3*ones(1,50) ];


% [ vertical_Structure_of_Selected_nonOutlier_DataPoints_for_Currrent_Class, vertical_Structure_of_Selected_Outlier_DataPoints_for_Currrent_Class ] = FaradarsV1_outlierDet_PostProc( 'selected_Classification_Method_Name', 'Test',  ...    
%                                                                                                                                                                                     'classLabels_from_DataSet', Y, ...
%                                                                                                                                                                                     'matrix_of_DataPoints', X, ...
%                                                                                                                                                                                     'draw_or_Not', 1,...
%                                                                                                                                                                                     'selected_Dimensions_for_Draw', [1 3 4], ...
%                                                                                                                                                                                     'decision_Alpha', 5, ...
%                                                                                                                                                                                     'axis_Labels', { 'X', 'Y', 'Z' }, ...
%                                                                                                                                                                                     'plot_Title', 'Test');
% 
% 

                                                                                                                                                                                
% % or if you want to use structure:
% a.selected_Classification_Method_Name = 'Test';   
% a.classLabels_from_DataSet = Y;
% a.matrix_of_DataPoints = X;
% a.draw_or_Not = 1;
% a.selected_Dimensions_for_Draw = [1 3 4];
% a.decision_Alpha =  5;
% a.axis_Labels = { 'X', 'Y', 'Z' };
% a.plot_Title =  'Test';
% a.selected_postFeatureGeneration_Function = 'FaradarsV1_outlierDet_PreProc';
% post_FeatureGeneration_Processor_Manager(a)

