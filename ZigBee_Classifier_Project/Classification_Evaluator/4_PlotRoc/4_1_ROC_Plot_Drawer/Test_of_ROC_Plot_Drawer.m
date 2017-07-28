    % For Test: 
        clc
        clear
        close all
        number_of_cases = 3;
        for i = 1 : number_of_cases
            number_of_Points = 10;
            negative_Input.negative(1,i).reference_Device_Index                       = randsample (10, 1);
            negative_Input.negative(1,i).testing_Device_Index                         = randsample (10, 1);
            negative_Input.negative(1,i).x_Values                                     = sort(rand (1, number_of_Points));
            negative_Input.negative(1,i).y_Values                                     = sort(unifrnd (.8,1, 1, number_of_Points));
            negative_Input.negative(1,i).thresholds                                   = sort(rand (1, number_of_Points ), 'descend');
            negative_Input.negative(1,i).reference_Device_probabilities               = sort(rand (1, 80));
            negative_Input.negative(1,i).testing_Device_probabilities                 = sort(rand (1, 80));

            positive_Input.positive(1,i).reference_Device_Index                       = [negative_Input.negative(1,i).reference_Device_Index];
            positive_Input.positive(1,i).testing_Device_Index                         = [negative_Input.negative(1,i).testing_Device_Index];
            positive_Input.positive(1,i).x_Values                                     = sort(rand (1, number_of_Points));
            positive_Input.positive(1,i).y_Values                                     = sort(unifrnd (.8,1, 1, number_of_Points));
            positive_Input.positive(1,i).thresholds                                   = sort(rand (1, number_of_Points) , 'descend');
            positive_Input.positive(1,i).reference_Device_probabilities               = [negative_Input.negative(1,i).reference_Device_probabilities];
            positive_Input.positive(1,i).testing_Device_probabilities                 = [negative_Input.negative(1,i).testing_Device_probabilities];
        end
        ROC_Plot_Drawer ( negative_Input )
        ROC_Plot_Drawer ( positive_Input )
   