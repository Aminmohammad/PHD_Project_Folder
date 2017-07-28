%             clc
%             a = randi ([ -1 4], 1, 10)';
%             b = randi ([ min(a) 3], 1, 10)';
% clc
close all
clear all

    N=1000;

    C1=[0 0  0 0];
    SIGMA1=[4 1 1 1
            1 3 1 1
            1 1 2 1
            1 1 1 5];
    X1=mvnrnd(C1,SIGMA1,N)';

    C2=[4 5 6  7];
    SIGMA2=[4 1 1 1
            1 3 1 1
            1 1 2 1
            1 1 1 5];
    X2=mvnrnd(C2,SIGMA2,N)';
    
    C3=[9 10 11 14];
    SIGMA3=[4 1 1 1
            1 3 1 1
            1 1 2 1
            1 1 1 5];
    X3=mvnrnd(C3,SIGMA3,N)';


    X=[X1 X2 X3 ];

    
    
    Y = [ ones(1,N)  2*ones(1,N) 3*ones(1,N) ];
    
% data=load('fisheriris');
% X = data.meas';
% Y = [ ones(1,50)  2*ones(1,50) 3*ones(1,50) ];

[ vertical_Structure_of_Raw_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes, vertical_Structure_of_DimReduced_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes ] = FaradarsV2_DimRed_PostProc( 'classLabels_from_DataBank', Y, ...
                                                                                                                                                                                                                'matrix_of_DataPoints', X, ...
                                                                                                                                                                                                                'draw_or_Not', 1,...                                                                                                                                                                                                            
                                                                                                                                                                                                                'selected_Components_for_Draw', [1 2 3 4 ], ...           max(selected_Components_for_Draw)               <= row_Num(X)
                                                                                                                                                                                                                'selected_Dimensions_of_Components', [1 2 ], ...          max(selected_Dimensions_of_Components)          <= row_Num(X)
                                                                                                                                                                                                                'selected_Dimensions_of_Components_for_Draw', [1 2 3], ...  max(selected_Dimensions_of_Components_for_Draw) <= row_Num(X)
                                                                                                                                                                                                                'axis_Labels', { 'X', 'Y', 'Z' }, ...
                                                                                                                                                                                                                'plot_Title', 'Test');


% How to use 'vertical_Structure_of_DimReduced_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes':
% ex.: if 'selected_Dimensions_of_Components' = [ 1 2 ]
% figure
% for index = 1: 3
%    a = [vertical_Structure_of_DimReduced_Seperated_Mapped_DataPoints_to_PCA_Space_for_all_Classes( index, 1 ).dimReduced_Mapped_DataPoint_for_a_Single_Class];
% 
%    plot ( a( : , 1 ), a ( :, 2 ), 'o' )
%    hold on
% end
                            

