          function Interface ( varargin )

    %% Section 0: Preliminaries
        % Level 1: Cleaning
            clc;
            clear
            close all;
            warning('off','all')            
            
        % Level 2: Changing Direction to the Root Folder of 'Interface'
            temp_Interface_MFile_Address = which ( 'Interface' );
            index = strfind ( temp_Interface_MFile_Address, 'Interface.m' );
            Interface_MFile_Address = temp_Interface_MFile_Address ( 1 : index - 2 );
            cd( Interface_MFile_Address );
        
current_Folder_Address = pwd;
project_Folder_Name = 'PHD_Project_Folder';
slash_Index = strfind (current_Folder_Address, project_Folder_Name );
selected_DataSet_Address = [ current_Folder_Address( 1, 1 : slash_Index + size (  project_Folder_Name, 2 ) ) 'Resources\2016_07_11_IQ_20Msps_RZUSBSTICK' ];
                
address_of_DataBank_Folder_in_the_Selected_DataSet_Folder = [ selected_DataSet_Address '\DataBank' ];
number_of_Devices_in_the_Original_DataBank  = [ address_of_DataBank_Folder_in_the_Selected_DataSet_Folder '\number_of_Devices' ];            

selected_Devices_Address_for_Application    = [ address_of_DataBank_Folder_in_the_Selected_DataSet_Folder '\DataBank.mat' ];
selected_Devices_Indices_for_Application    = [ 2 3 ]; % for accuracy of this part, the indices of 
                                                             % devices in the data-bank should be the same as
                                                             % their places in the matrix 
            
% Assigning the 'Application_or_Training' 
    application_or_Training = 'Training'; % 'Application' or 'Training'
%     application_or_Training = 'Application';

% Selectio of Last Model for "Application" case
    if ( strcmp ( application_or_Training, 'Application' ) == 1 )
        we_Found_the_Last_Saved_TrainedModel = 0;
        number_of_Folders_that_will_be_Searched = 0;
        temp_Selected_Model_Address_for_Application = [ selected_DataSet_Address '\Results' ];
        
        while we_Found_the_Last_Saved_TrainedModel == 0        
            [ number_of_Folders_that_will_be_Searched, last_Modified_subFolder ] = Latest_Folder_Finder ( temp_Selected_Model_Address_for_Application, number_of_Folders_that_will_be_Searched );
            selected_Model_Address_for_Application                               = [ last_Modified_subFolder '\trained_FaradarsV1_Decision_Tree.mat'];

            if ( exist ( selected_Model_Address_for_Application ) ~= 0 ) %#ok<*EXIST>
                we_Found_the_Last_Saved_TrainedModel = 1;

            else
                number_of_Folders_that_will_be_Searched = number_of_Folders_that_will_be_Searched - 1;

            end

        end
        
    else
        selected_Model_Address_for_Application = [];
        
    end

    
    if ( strcmp ( application_or_Training, 'Application' ) == 1 ) && ...
       ( isempty ( selected_Model_Address_for_Application ) == 1 )
        error ( 'You selected the "Application" as the "Mechanism", but you entered no "Model Address".' );

    end
    
    if ( strcmp ( application_or_Training, 'Application' ) == 1 ) && ...
       ( isempty ( selected_Devices_Address_for_Application ) == 1 )
        error ( 'You selected the "Application" as the "Mechanism", but you entered no "Devices Address for Classification".' );

    end

                        
% inputs
%         selected_preFeatureGeneration_Method                        = { 'FaradarsV1_outlierDet_PreProc', 'FaradarsV2_outlierDet_PreProc' };
%         selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = { 'Skewness', 'Variance' };
%         selected_postFeatureGeneration_Function                     = { 'FaradarsV1_OutlierDet_PostProc', 'WrittenV1_PCA_postProc', 'WrittenV2_SPCA_postProc' };
%         selected_Classification_Method                              = { 'Support_Vector_Machinme', 'MatlabV2_MultiClass_SVM', 'FaradarsV1_Decision_Tree', 'FaradarsV1_NaiveBayesian', 'FaradarsV2_K_Nearest_Neighbors', 'FaradarsV2_Perceptron_Neural_Network', 'WrittenV1_Perceptron_Neural_Network', 'FaradarsV1_RBF_Neural_Network', 'FaradarsV1_Fuzzy_System'};
%         selected_Evaluation_Method                                  = { 'Confusion_Matrix', 'ErrorHist_RegLine_PlotResult', 'ResubLoss', 'Receiver_Operating_Characteristic', 'MS_Error' };
%        
            
% DataSet Parameters 
    output_from_GUI.dataSet_Parameters.do_You_Want_to_Make_new_DataSet = 0;
    output_from_GUI.dataSet_Parameters.SelectedDataSetName             = '2016_07_11_IQ_20Msps_RZUSBSTICK';
    output_from_GUI.dataSet_Parameters.zero_Conversion_Threshold       = 0.7;
    output_from_GUI.dataSet_Parameters.number_of_subRegions            = 32;    

% preProc Parameters 
    % General Params
        output_from_GUI.general_preProc_Parameters = [];

    % Special Params        
        output_from_GUI.special_preProc_Parameters.selected_preFeatureGeneration_Methods = [];
        
% DataBank Parameters     
    output_from_GUI.dataBank_Parameters.do_You_Want_to_Make_new_DataBank                             = 0; 
    output_from_GUI.dataBank_Parameters.selected_Algorithms_for_Making_FingerPrint_of_a_Single_Burst = {'Mean'};
    output_from_GUI.dataBank_Parameters.strategy_of_Formation_of_a_Single_Burst_Statistics_Matrix    = {'all_Statistics_of_all_Characteristics_in_Just_One_Column'};    % 'all_Statistics_of_the_Same_Characteristics_in_Just_One_Row' or 'each_Statistics_of_Characteristics_in_Seperate_Rows' or 'all_Statistics_of_all_Characteristics_in_Just_One_Column'                                                                 
    output_from_GUI.dataBank_Parameters.vertical_Cell_of_Characteristics_Names                       = {'Amplitude_Element', 'Phase_Element','Frequency_Element'};
    output_from_GUI.dataBank_Parameters.vertical_Cell_of_Statistics_Names                            = {'Skewness', 'Variance', 'Kurtosis', 'Mean'};
                                           
% postProc Parameters    
    % General Params
        output_from_GUI.general_postProc_Parameters.selected_Indices_of_Devices_for_postProcessing   = [ 1 2 3 4 ];                                 ... [ 1 2 3 4 ... M ];  
        output_from_GUI.general_postProc_Parameters.selected_Type_of_FingerPrints_for_postProcessing = 'statistics_for_a_Single_Device';            ... 'fingerPrint_for_a_Single_Device' or 'statistics_for_a_Single_Device'
        output_from_GUI.general_postProc_Parameters.draw_or_Not                                      = 1;                                           ... '1' or '0' (double)  ---> if 0 -> following 3 lines are useless.
        output_from_GUI.general_postProc_Parameters.selected_Dimensions_for_Draw                     = [ 1 2 3 4 ];                                     ... This factor reaaly assigns the Dimension of Drawing                                    
        output_from_GUI.general_postProc_Parameters.axis_Labels                                      = { 'X-Amplitude', 'Y-Phase', 'Z-Frequency' };
        output_from_GUI.general_postProc_Parameters.special_PlotTitle                                = [];
        
        output_from_GUI.general_postProc_Parameters.do_You_Want_to_Draw_FPPlot_for_Initial_Data                    = 1;
        output_from_GUI.general_postProc_Parameters.do_You_Want_to_Draw_FPPlot_for_postProcessed_Data              = 1;        
        output_from_GUI.general_postProc_Parameters.do_You_Want_to_Edit_DataBankMatrix_withRespect_to_the_FPPlot   = 0;        
        output_from_GUI.general_postProc_Parameters.number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot          = [ 1, 159; % Start, End (1st Device)
                                                                                                                       1, 159; % Start, End (2nd Device)
                                                                                                                       1, 150; % Start, End (3rd Device)
                                                                                                                       1, 159; % Start, End (4th Device)
                                                                                                                      ];
                                                                                                                  
        output_from_GUI.general_postProc_Parameters.number_of_Added_Zeros_Between_Devices                          = 10;
        output_from_GUI.general_postProc_Parameters.number_of_Added_Zeros_Between_Devices                          = 10;
        output_from_GUI.general_postProc_Parameters.selected_Function_for_Converting_the_MatriceRows_in_FPG_String = 'skewness';
        output_from_GUI.general_postProc_Parameters.selected_Function_for_Converting_the_MatriceCols_in_FPG_String = 'mean';   % Not Used Yet
        output_from_GUI.general_postProc_Parameters.selected_Devices_Address_for_Application                       = selected_Devices_Address_for_Application;
        output_from_GUI.general_postProc_Parameters.selected_Devices_Indices_for_Application                       = selected_Devices_Indices_for_Application;

    % Special Params 
        output_from_GUI.special_postProc_Parameters.selected_postFeatureGeneration_Methods = { 'WrittenV2_SPCA_postProc' };
            
        % for 'FaradarsV1_OutlierDet_PostProc':
            output_from_GUI.special_postProc_Parameters.decision_Alpha = 20;
                
        % for 'WrittenV1_PCA_postProc':
            output_from_GUI.special_postProc_Parameters.graph_Text_Size = 10;
                             
% Classification Parameters    
    % General Params                                                                                            
        output_from_GUI.general_Classification_Parameters.selected_Saving_Extension                      = 'jpg';  
        
        % Training Case                                     
            output_from_GUI.general_Classification_Parameters.number_of_Devices_in_the_Original_DataBank = number_of_Devices_in_the_Original_DataBank;
            
            output_from_GUI.general_Classification_Parameters.do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices = 1;
                        % In you put "do_You_Want_the_Training_and_Test_be_Done_Based_on_Special_Devices" = 1; 
                        % In this case the "training_Percentage" will be from selected devices, not from all.
                        % Also "validation_Percentage" and "validation_Percentage" will have the sace condition.
                            
                if     ( output_from_GUI.general_Classification_Parameters.do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices == 1 )
                    output_from_GUI.general_Classification_Parameters.training_Percentage                        = .7; 
                    output_from_GUI.general_Classification_Parameters.validation_Percentage                      = 0;  %  Not used yet
                    output_from_GUI.general_Classification_Parameters.test_Percentage                            = .5;
                    
                    % Following device_Numbers should be selected from "selected_Indices_of_Devices_for_postProcessing"            
                        output_from_GUI.general_Classification_Parameters.selected_Devices_for_Training   = [ 2 3 ];  % Just important for "do_You_Want_the_Training_and_Test_be_Done_Based_on_Special_Devices = 1"
                        output_from_GUI.general_Classification_Parameters.selected_Devices_for_Validation = [];           % Just important for "do_You_Want_the_Training_and_Test_be_Done_Based_on_Special_Devices = 1"
                        output_from_GUI.general_Classification_Parameters.selected_Devices_for_Test       = [ 1 2 ];  % Just important for "do_You_Want_the_Training_and_Test_be_Done_Based_on_Special_Devices = 1"
                                    
                elseif ( output_from_GUI.general_Classification_Parameters.do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices == 0 )    
                    output_from_GUI.general_Classification_Parameters.training_Percentage                        = .7; 
                    output_from_GUI.general_Classification_Parameters.validation_Percentage                      = 0;  %  Not used yet
                    output_from_GUI.general_Classification_Parameters.test_Percentage                            = 1 - [output_from_GUI.general_Classification_Parameters.training_Percentage] + [output_from_GUI.general_Classification_Parameters.validation_Percentage];                                     
                    
                    % Following parameters are just useful for "selected_Indices_of_Devices_for_postProcessing = 1"            
                        output_from_GUI.general_Classification_Parameters.selected_Devices_for_Training   = [];  
                        output_from_GUI.general_Classification_Parameters.selected_Devices_for_Validation = [];     
                        output_from_GUI.general_Classification_Parameters.selected_Devices_for_Test       = [];       
                         
                    
                end
         
        % Application Case    
            output_from_GUI.general_Classification_Parameters.selected_Model_Address_for_Application     = selected_Model_Address_for_Application;

    % Special Params                                                              
        output_from_GUI.special_Classification_Parameters.selected_Classification_Methods = { 'FaradarsV1_Decision_Tree' };
        
% Evaluation Parameters  
    % General Params
        output_from_GUI.general_Evaluation_Parameters = [];
        
	% Special Params  
        output_from_GUI.special_Evaluation_Parameters.selected_Evaluation_Methods = { 'Receiver_Operating_Characteristic' };
        
% Plot Permission Parameters    
    output_from_GUI.run_Permission_Parameters.run_Permission_Vector = [ 0 1 1 1 1 ];
    
% Saving Permission Parameters (Graphic Management)
    output_from_GUI.saving_Permission_Parameters.saving_Permission_Vector = [ 1 0 1 0 0 0 0 ];
    
% Entering the 'Deleting' Address   
    output_from_GUI.addresses.cell_of_Deleting_ResultsFolder = 'D:\PHD_Project_Folder\Resources\2016_07_11_IQ_20Msps_RZUSBSTICK\Results\04_Jan_2017_09_13_46_(FaradarsV2_Perceptron_Neural_Network)';

        % Level 1: Adding Essential Parameters    
            if ( isempty ( Persistent_Variable_Saver ( [], 'Reading' )  ) == 1 )
                fprintf ( 'Adding all sub-Folders under the "PHD Project Folder" Started ... .\n' )            
                Path_Adder ( 'PHD_Project_Folder' ) 
                Persistent_Variable_Saver ( 1, 'Writing' );
                fprintf ( 'Adding all sub-Folders under the "PHD Project Folder" Finished .\n' )

            else
                fprintf ( 'Adding all sub-Folders under the "PHD Project Folder" by-Passed .\n' )

            end
            
    %% Section 1: Data Collection    
        % Level 1: DataSet Parameters            
            dataSet_Input_Arguments = { 'do_You_Want_to_Make_new_DataSet', output_from_GUI.dataSet_Parameters.do_You_Want_to_Make_new_DataSet,                    ...
                                        'SelectedDataSetName',             output_from_GUI.dataSet_Parameters.SelectedDataSetName,                                ...    
                                        'zero_Conversion_Threshold',       output_from_GUI.dataSet_Parameters.zero_Conversion_Threshold,                          ...
                                        'number_of_subRegion',             output_from_GUI.dataSet_Parameters.number_of_subRegions,                                                 ...
                                       };                       
        % Level 2: preProc Parameters                                    
            general_preProc_Input_Arguments  = { '', output_from_GUI.general_preProc_Parameters };
            
            special_preProc_Input_Arguments = structure_toCell_Converter( output_from_GUI.special_preProc_Parameters );
            
        % Level 3: DataBank Parameters 
            dataBank_Input_Arguments = {  'do_You_Want_to_Make_new_DataBank',                          output_from_GUI.dataBank_Parameters.do_You_Want_to_Make_new_DataBank, ...                                            
                                          'selected_DataBank_Methods',                                 output_from_GUI.dataBank_Parameters.selected_Algorithms_for_Making_FingerPrint_of_a_Single_Burst, ...                                            
                                          'strategy_of_Formation_of_a_Single_Burst_Statistics_Matrix', output_from_GUI.dataBank_Parameters.strategy_of_Formation_of_a_Single_Burst_Statistics_Matrix, ...
                                          'selected_DataSet_Name',                                     output_from_GUI.dataSet_Parameters.SelectedDataSetName, ... 
                                          'vertical_Cell_of_Characteristics_Names',                    output_from_GUI.dataBank_Parameters.vertical_Cell_of_Characteristics_Names, ... 
                                          'vertical_Cell_of_Statistics_Names',                         output_from_GUI.dataBank_Parameters.vertical_Cell_of_Statistics_Names, ...

                                       };
                  
        % Level 4: postProc Parameters 
            general_postProc_Input_Arguments = {    'selected_Indices_of_Devices_for_postProcessing',                 output_from_GUI.general_postProc_Parameters.selected_Indices_of_Devices_for_postProcessing,                 ... [ 1 2 3 4 ... M ];
                                                    'selected_DataBank_Methods',                                      output_from_GUI.dataBank_Parameters.selected_Algorithms_for_Making_FingerPrint_of_a_Single_Burst,           ...        
                                                    'selected_Type_of_FingerPrints_for_postProcessing',               output_from_GUI.general_postProc_Parameters.selected_Type_of_FingerPrints_for_postProcessing,               ... 'fingerPrint_for_a_Single_Device' or 'statistics_for_a_Single_Device'
                                                    'draw_or_Not',                                                    output_from_GUI.general_postProc_Parameters.draw_or_Not,                                                    ... '1' or '0' (double)  ---> if 0 -> following 3 lines are useless.
                                                    'selected_Dimensions_for_Draw',                                   output_from_GUI.general_postProc_Parameters.selected_Dimensions_for_Draw,                                   ... This factor reaaly assigns the Dimension of Drawing                                           
                                                    'axis_Labels',                                                    output_from_GUI.general_postProc_Parameters.axis_Labels,                                                    ...
                                                    'special_PlotTitle',                                              output_from_GUI.general_postProc_Parameters.special_PlotTitle,                                              ...                
                                                    'do_You_Want_to_Draw_FPPlot_for_Initial_Data',                    output_from_GUI.general_postProc_Parameters.do_You_Want_to_Draw_FPPlot_for_Initial_Data,                    ...
                                                    'do_You_Want_to_Draw_FPPlot_for_postProcessed_Data',              output_from_GUI.general_postProc_Parameters.do_You_Want_to_Draw_FPPlot_for_postProcessed_Data,              ...
                                                    'do_You_Want_to_Edit_DataBankMatrix',                             output_from_GUI.general_postProc_Parameters.do_You_Want_to_Edit_DataBankMatrix_withRespect_to_the_FPPlot,   ...
                                                    'number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot',          output_from_GUI.general_postProc_Parameters.number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot,          ...                
                                                    'number_of_Added_Zeros_Between_Devices',                          output_from_GUI.general_postProc_Parameters.number_of_Added_Zeros_Between_Devices,                          ...                
                                                    'selected_Function_for_Converting_the_MatriceRows_in_FPG_String', output_from_GUI.general_postProc_Parameters.selected_Function_for_Converting_the_MatriceRows_in_FPG_String, ...                
                                                    'selected_Function_for_Converting_the_MatriceCols_in_FPG_String', output_from_GUI.general_postProc_Parameters.selected_Function_for_Converting_the_MatriceCols_in_FPG_String, ... 
                                                    'selected_Devices_Address_for_Application',                       output_from_GUI.general_postProc_Parameters.selected_Devices_Address_for_Application,                       ...
                                                    'selected_Devices_Indices_for_Application',                       output_from_GUI.general_postProc_Parameters.selected_Devices_Indices_for_Application,                       ...
                                               };
            
            special_postProc_Input_Arguments = structure_toCell_Converter( output_from_GUI.special_postProc_Parameters );
            %    special_postProc_Input_Arguments = {  'decision_Alpha', 20, ...                                                         
            %                                          'selected_postFeatureGeneration_Methods', ??? };
                                                    ... selected_postFeatureGeneration_Methods = { 'FaradarsV1_OutlierDet_PostProc', 'WrittenV1_PCA_postProc' };                        
        % Level 5: Classification Parameters  
            general_Classification_Input_Arguments = {  'selected_Saving_Extension',                                    output_from_GUI.general_Classification_Parameters.selected_Saving_Extension,                       ... 
                                                        'selected_Dimensions_for_Draw',                                 [ output_from_GUI.general_postProc_Parameters.selected_Dimensions_for_Draw ],                      ...                                                                   
                                                        'training_Percentage',                                          [output_from_GUI.general_Classification_Parameters.training_Percentage],                           ...
                                                        'validation_Percentage',                                        [output_from_GUI.general_Classification_Parameters.validation_Percentage],                         ...
                                                        'test_Percentage',                                              [output_from_GUI.general_Classification_Parameters.test_Percentage],                               ...                                                        
                                                        'selected_Model_Address_for_Application',                       output_from_GUI.general_Classification_Parameters.selected_Model_Address_for_Application,          ...        
                                                        'number_of_Devices_in_the_Original_DataBank',                   output_from_GUI.general_Classification_Parameters.number_of_Devices_in_the_Original_DataBank,      ...
                                                        'do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices', output_from_GUI.general_Classification_Parameters.do_You_Want_the_Training_or_Test_be_Based_on_Special_Devices,                      ...
                                                        'selected_Devices_for_Training',                                output_from_GUI.general_Classification_Parameters.selected_Devices_for_Training,                   ...
                                                        'selected_Devices_for_Validation',                              output_from_GUI.general_Classification_Parameters.selected_Devices_for_Validation,                 ...
                                                        'selected_Devices_for_Test',                                    output_from_GUI.general_Classification_Parameters.selected_Devices_for_Test,                       ...
        
                                                        };

            special_Classification_Input_Arguments = structure_toCell_Converter ( output_from_GUI.special_Classification_Parameters );
            %    special_Classification_Input_Arguments = {  'decision_Alpha', 20, ...                                                         
            %                                                'selected_Classification_Methods', ??? };
                                                          ... selected_Classification_Methods = { 'Support_Vector_Machinme', 'MatlabV2_MultiClass_SVM', 'FaradarsV1_Decision_Tree', 'FaradarsV1_NaiveBayesian', 'FaradarsV2_K_Nearest_Neighbors', 'FaradarsV2_Perceptron_Neural_Network', 'WrittenV1_Perceptron_Neural_Network', 'FaradarsV1_RBF_Neural_Network', 'FaradarsV1_Fuzzy_System'};
                                                              
        % Level 6: Evaluation Parameters     
            general_Evaluation_Input_Arguments = { 'number_of_Devices_in_the_DataBank',  };
            
            special_Evaluation_Input_Arguments = structure_toCell_Converter ( output_from_GUI.special_Evaluation_Parameters );
            %    evaluation_Input_Arguments = {  'selected_Evaluation_Methods', ???,   ...                                             
                                              ... selected_Evaluation_Methods = { 'Confusion_Matrix', 'ErrorHist_RegLine_PlotResult', 'ResubLoss', 'Plot_Receiver_Operating_Characteristic', 'MS_Error' };                                         
            %                                 }
       
        % Level 7: Plot Permission Parameters                                        
            run_Permissions_Input_Arguments = { 'run_Permission_Vector', [output_from_GUI.run_Permission_Parameters.run_Permission_Vector] };
            
        % Level 8: Saving Permission Parameters (Graphic Management)
            saving_Permissions_Input_Arguments = { 'saving_Permission_Vector', [output_from_GUI.saving_Permission_Parameters.saving_Permission_Vector] };                  
                            
        % Level 9: Permutations
            selected_preFeatureGeneration_Methods_ColNum  = size ( Selected_Methods_Extractor ( 'selected_preFeatureGeneration_Methods',  special_preProc_Input_Arguments ),         2 );
            selected_DataBank_Methods_ColNum              = size ( Selected_Methods_Extractor ( 'selected_DataBank_Methods',              dataBank_Input_Arguments ),                2 );
            selected_postFeatureGeneration_Methods_ColNum = size ( Selected_Methods_Extractor ( 'selected_postFeatureGeneration_Methods', special_postProc_Input_Arguments ),        2 );
            selected_Classification_Methods_ColNum        = size ( Selected_Methods_Extractor ( 'selected_Classification_Methods',        special_Classification_Input_Arguments ),  2 );
            selected_Evaluation_Methods_ColNum            = size ( Selected_Methods_Extractor ( 'selected_Evaluation_Methods',            special_Evaluation_Input_Arguments ),      2 );

            selected_preFeatureGeneration_Methods_Vector  = 1 : selected_preFeatureGeneration_Methods_ColNum; 
            selected_DataBank_Methods_Vector              = 1 : selected_DataBank_Methods_ColNum; 
            selected_postFeatureGeneration_Methods_Vector = 1 : selected_postFeatureGeneration_Methods_ColNum; 
            selected_Classification_Methods_Vector        = 1 : selected_Classification_Methods_ColNum; 
            selected_Evaluation_Methods_Vector            = 1 : selected_Evaluation_Methods_ColNum; 
 
            % permutations: [ pre_Process ( if not empty), DataBank, post_Process, Classification, Evaluation   ]
            if     ( strcmp( application_or_Training, 'Training' ) == 1 ) && ( isempty ( selected_preFeatureGeneration_Methods_Vector ) == 0 )
                permutations = struc ( selected_preFeatureGeneration_Methods_Vector,  ...
                                       selected_DataBank_Methods_Vector,              ...
                                       selected_postFeatureGeneration_Methods_Vector, ...
                                       selected_Classification_Methods_Vector,        ...
                                       selected_Evaluation_Methods_Vector );
                                   
            elseif ( strcmp( application_or_Training, 'Training' ) == 1 ) && ( isempty ( selected_preFeatureGeneration_Methods_Vector ) == 1 )
                permutations = struc ( selected_DataBank_Methods_Vector,              ...
                                       selected_postFeatureGeneration_Methods_Vector, ...
                                       selected_Classification_Methods_Vector,        ...
                                       selected_Evaluation_Methods_Vector );
                                   
            elseif ( strcmp( application_or_Training, 'Application' ) == 1 ) 
                permutations = struc (  1,              ...
                                        1, ...
                                        selected_Classification_Methods_Vector,        ...
                                        selected_Evaluation_Methods_Vector );
                
            end                                   

        % Level 10: Making the 'Saving & 'Loading' & 'Deleting' Addresses
            selected_Classification_Methods = Selected_Methods_Extractor('selected_Classification_Methods', special_Classification_Input_Arguments);
                                        
            saving_Folder_Address = Making_the_Target_Folder(    Selected_Methods_Extractor('SelectedDataSetName', dataSet_Input_Arguments ),      selected_Classification_Methods,         1 );
            addresses = { 'saving_Folder_Address',  saving_Folder_Address,                                                                                      ...
                          'loading_Folder_Address', saving_Folder_Address,                                                                                      ...                     
                          'cell_of_Addresses_for_Deleting', output_from_GUI.addresses.cell_of_Deleting_ResultsFolder };                       
                          % cell_of_Addresses_for_Deleting = cell_of_Address_of_Output_Folders_from_Results_Folder_for_Deleting
                          
            general_Classification_Input_Arguments = [ 'Saving_Address',   saving_Folder_Address, ...
                                                       general_Classification_Input_Arguments
                                                     ];
                                                 
            general_postProc_Input_Arguments = [ 'Saving_Address',   saving_Folder_Address, ...
                                                 general_postProc_Input_Arguments
                                               ];

    %% Section 2: Calling the Start
        % Level 1: Running the Program   
            Start_Training(                                                                                       ...                
                         ... Stage 1: DataSet Parameters                                                           
                                'dataSet_Input_Arguments', dataSet_Input_Arguments,                                 ...
                                                                                                                    ...
                         ... Stage 2: preProc Parameters                                                          
                                'general_preProc_Input_Arguments', general_preProc_Input_Arguments,                 ...
                                'special_preProc_Input_Arguments', special_preProc_Input_Arguments,                 ...
                                                                                                                    ...
                         ... Stage 3: DataBank Parameters                                                          
                                'dataBank_Input_Arguments', dataBank_Input_Arguments,                               ...          
                                                                                                                    ...
                         ... Stage 4: postProc Parameters                                                          
                                'general_postProc_Input_Arguments', general_postProc_Input_Arguments,               ...                         
                                'special_postProc_Input_Arguments', special_postProc_Input_Arguments,               ...                       
                                                                                                                    ...
                         ... Stage 5: Classification Parameters                                                    
                                'general_Classification_Input_Arguments', general_Classification_Input_Arguments,   ...
                                'special_Classification_Input_Arguments', special_Classification_Input_Arguments,   ...
                                                                                                                    ...
                         ... Stage 6: Evaluation Parameters                                                       
                                'general_Evaluation_Input_Arguments', general_Evaluation_Input_Arguments,           ...
                                'special_Evaluation_Input_Arguments', special_Evaluation_Input_Arguments,           ...
                                                                                                                    ...
                         ... Stage 7: Plot Permission Parameters                                                  
                                'run_Permissions_Input_Arguments', run_Permissions_Input_Arguments,               ...                    
                                                                                                                    ...
                         ... Level 8: Saving Permission Parameters (Graphic Management)                            
                                'saving_Permissions_Input_Arguments', saving_Permissions_Input_Arguments,           ...
                                                                                                                    ...
                         ... Stage 9: Permutations                                                                 
                                'permutations', permutations,                                                       ...
                                                                                                                    ...
                         ... Stage 10: 'Saving & 'Loading' & 'Deleting' Addresses                             
                                'addresses', addresses,                                                             ...
                                                                                                                    ...
                         ... Stage 11: 'Saving & 'Loading' & 'Deleting' Addresses                             
                                'application_or_Training', application_or_Training                                  ...                                                                                       ...                                
                          ); %#ok<*COMNL>
                                
        