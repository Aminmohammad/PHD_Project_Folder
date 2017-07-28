function output = Receiver_Operating_Characteristic( varargin )

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
                                                                              
            [ train_Input, test_Input ] = ROC_Plot_Input_Saver ( input_for_ROC_Plot_Information_Extractor );
            
            if     ( strcmp( application_or_Training, 'Training') == 1 ) && ( strcmp( type_of_Data, '(Test_Data)') == 1)                                                
                ROC_Plot_Information                              = ROC_Plot_Information_Extractor ( train_Input, test_Input );
                negative_Input.negative = ROC_Plot_Information. negative;
                positive_Input.positive = ROC_Plot_Information. positive;

                ROC_Plot_Drawer ( negative_Input )
                ROC_Plot_Drawer ( positive_Input )

            end

            output =[];
            

end