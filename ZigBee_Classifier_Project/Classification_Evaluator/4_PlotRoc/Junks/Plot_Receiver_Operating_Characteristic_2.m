function output = Plot_Receiver_Operating_Characteristic_2( varargin )

    %% Section 0: Preliminaries
    
    %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
           inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true; 
            inputSet.addParameter('classLabels_from_Net', []);
            inputSet.addParameter('classLabels_from_Original_or_ReducedForApplication_DataBank', []);  
            inputSet.addParameter('number_of_Devices_from_Original_DataBank', []);
            inputSet.addParameter('number_of_Bursts_for_Classified_Devices', []);
            inputSet.addParameter('selected_Indices_of_Devices', []);
            inputSet.addParameter('type_of_Data', []);  
            inputSet.addParameter('general_PlotTitle', []);        
            inputSet.addParameter('application_or_Training', []);
            inputSet.addParameter('scores', []);
            
            inputSet.parse(varargin{:});

            classLabels_from_Net                                        = inputSet.Results.classLabels_from_Net;
            classLabels_from_Original_or_ReducedForApplication_DataBank = inputSet.Results.classLabels_from_Original_or_ReducedForApplication_DataBank;
            number_of_Devices_from_Original_DataBank                    = inputSet.Results.number_of_Devices_from_Original_DataBank;
            general_PlotTitle                                           = inputSet.Results.general_PlotTitle;
            type_of_Data                                                = inputSet.Results.type_of_Data;
            application_or_Training                                     = inputSet.Results.application_or_Training;
            selected_Indices_of_Devices                                 = inputSet.Results.selected_Indices_of_Devices;
            number_of_Bursts_for_Classified_Devices                     = inputSet.Results.number_of_Bursts_for_Classified_Devices;
            scores                                                      = inputSet.Results.scores;
           
            if    ( isempty( classLabels_from_Net ) == 1 )        
                error ( 'You should Enter the "classLabels from Net" for evaluation of "Confusion Matrix".' );

            elseif    ( isempty( classLabels_from_Original_or_ReducedForApplication_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for evaluation of "Confusion Matrix".' );

            end               
        
        % Level 2: Converting the 'classLabels_from_Net' and 'classLabels_from_Original_or_ReducedForApplication_DataBank' to 'Horizontal Vactors'
            classLabels_from_Net      = [classLabels_from_Net.roundedClamped_Output];
            classLabels_from_Net      = classLabels_from_Net ( : )';                                             
            classLabels_from_Original_or_ReducedForApplication_DataBank = classLabels_from_Original_or_ReducedForApplication_DataBank ( : )';             
            
            input_for_ROC_Plot_Information_Extractor. application_or_Training                                     = application_or_Training;
            input_for_ROC_Plot_Information_Extractor. type_of_Data                                                = type_of_Data;
            input_for_ROC_Plot_Information_Extractor. selected_Indices_of_Devices                                 = selected_Indices_of_Devices;
            input_for_ROC_Plot_Information_Extractor. number_of_Bursts_for_Classified_Devices                     = number_of_Bursts_for_Classified_Devices;
            input_for_ROC_Plot_Information_Extractor. classLabels_from_Original_or_ReducedForApplication_DataBank = classLabels_from_Original_or_ReducedForApplication_DataBank;
            input_for_ROC_Plot_Information_Extractor. scores                                                      = scores;
                                                                              
            ROC_Plot_Input_Saver ( input_for_ROC_Plot_Information_Extractor )
            
            output =[];
%             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     Reference_Device_Label              = 1;
% training_Scores = training_Scores (2, (training_Scores(2,:) == 1) )
% testing_Scores = testing_Scores (1,testing_Scores(1,:) ==0 )
% 
%                                     output_1 = False_Negative_Rate_Calculator_for_One_Reference_Device ('true_Labels_of_Testing_DataPoints', ones ( 1, size ( testing_Scores , 2 ) ), ...
%                                                                                                       'probabilities_of_Testing_DataPoins', testing_Scores )
% 
%                                     thresholds_for_True_or_False_Negative_Rates = output_1.thresholds_for_True_or_False_Negative_Rates;
% 
%                                     output_2 = True_Negative_Rate_Calculator_for_One_Reference_Device ( 'true_Labels_of_Testing_DataPoints', ones ( 1, size ( training_Scores, 2 ) ), ...
%                                                                                                       'probabilities_of_Testing_DataPoins',  training_Scores, ...
%                                                                                                       'thresholds_for_True_or_False_Negative_Rates', thresholds_for_True_or_False_Negative_Rates, ...
%                                                                                                       'Reference_Device_Label', Reference_Device_Label )
% output_1. false_Negative_Rates_of_Classifications_for_all_Thresholds
% output_2. true_Negative_Rates_of_Classifications_for_all_Thresholds
% 
% color ='blue';
% spoofind_Device = 4;
% spoofed_Device = 3;
% display_Name = sprintf('Spoofing Device: %d & Spoofed Device: %d', spoofind_Device, spoofed_Device);
%                                     [ x, sorting_Indices ] = sort (output_1. false_Negative_Rates_of_Classifications_for_all_Thresholds)                                                             
%                                     temp                      = output_2. true_Negative_Rates_of_Classifications_for_all_Thresholds;
%                                     y = temp (1, sorting_Indices)
% 
%                                     figure
%                                     h = plot (x, y, 'color', color, 'DisplayName', display_Name)
%                                     set(gca,'XLim',[-.01 1.01])
%                                     set(gca,'YLim',[-.01 1.01])
%                                     hold on
%                                     stem(x(1,1), y(1,1), 'Marker', 'none', 'color', color)
%                                     hold off
%                                     grid on;
%                                     
%                                     title ( 'ROC plot')
%                                     xlabel ('False Negative Rate (P(FA))')
%                                     ylabel ('True Negative Rate (P(D))')
% %                                     legend (h)
                                    
             %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            
            

end































































































            
            
            
            
           