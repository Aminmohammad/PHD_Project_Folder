
    %% Section 0: Preliminaries
        % Level 1: Cleaning
            clc;
            clear
            close all;

        % Level 2: Adding Essential Parameters                           
            Add_Pather ( 'PHD_Project_Folder' ) 

    %% Section 1: Extraction of Initial Parameters
        % Level 1: DataSet
            dataSet_Parameters_Structure. do_You_Want_to_Make_new_DataSet = 0;
            dataSet_Parameters_Structure. SelectedDataSetName             = '2016_07_11_IQ_20Msps_RZUSBSTICK';
            dataSet_Parameters_Structure. zero_Conversion_Threshold       = .7;

        % Level 2: preProcess            
            preProc_Parameters_Structure.selected_DataBase_Method_Name                                 = '';   
            preProc_Parameters_Structure.special_Structure_of_Parameters_for_preProcessing             = [];           
            preProc_Parameters_Structure.selected_preFeatureGeneration_Method                          = '';            

        % Level 3: DataBank
            dataBank_Parameters_Structure. do_You_Want_to_Make_new_DataBank                            = 0;
            dataBank_Parameters_Structure. selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = '';
            dataBank_Parameters_Structure. selected_DataBank_Name                                      = dataSet_Parameters_Structure. SelectedDataSetName;
            dataBank_Parameters_Structure. vertical_Cell_of_Instantaneous_Elements_Names               = {'Amplitude_Element', 'Phase_Element','Frequency_Element'};
            dataBank_Parameters_Structure. vertical_Cell_of_Statistics_Names                           = {'Skewness', 'Variance', 'Kurtosis', 'Mean'};
            dataBank_Parameters_Structure. Vertical_Structure_of_all_Devices                           = [];

        % Level 4: postProcess
            postProc_Parameters_Structure.selected_Indices_of_Devices_for_postProcessing                = [ 1 2 3 4 ];   % [ 1 2 3 4 ... M ];     
            postProc_Parameters_Structure.selected_DataBank_Method_Name                                = dataBank_Parameters_Structure. selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst;   
            postProc_Parameters_Structure.classLabels_from_DataBank                                    = [];
            postProc_Parameters_Structure.matrix_of_DataPoints                                         = [];
            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing           = [];           
            postProc_Parameters_Structure.selected_postFeatureGeneration_Method                        = '';
            postProc_Parameters_Structure.selected_Type_of_FingerPrints_for_postProcessing             = 'fingerPrint_for_a_Single_Device';       % 'fingerPrint_for_a_Single_Device' or 'statistics_for_a_Single_Device'

        % Level 5: Classification
            classification_Parameters_Structure. input_DataPoints_Matrix                               = [];
            classification_Parameters_Structure. classLabels_from_DataBank                             = [];
            classification_Parameters_Structure. special_Structure_of_Parameters_for_Classification    = [];
            classification_Parameters_Structure. selected_Classification_Method                        = '';

        % Level 6: Evaluation
            evaluation_Parameters_Structure. selected_Classification_Method_Name                       = classification_Parameters_Structure. selected_Classification_Method;
            evaluation_Parameters_Structure. classLabels_from_Net                                      = [];
            evaluation_Parameters_Structure. selected_Evaluation_Method                                = '';
            evaluation_Parameters_Structure. classLabels_from_DataBank                                 = [];
            evaluation_Parameters_Structure. number_of_Classes                                         = 4;
            evaluation_Parameters_Structure. subplot_Resize_Percentage                                 = 0.8;            

        % Level 7: Permission for Running
            permission_Vector = [ 0 1 1 1 1 ];
            permission_Structure. do_You_Want_the_DataSet_to_Run                                       = 1;
            permission_Structure. do_You_Want_the_preProc_to_Run                                       = permission_Vector (1, 1);
            permission_Structure. do_You_Want_the_DataBank_to_Run                                      = permission_Vector (1, 2);
            permission_Structure. do_You_Want_the_postProc_to_Run                                      = permission_Vector (1, 3);
            permission_Structure. do_You_Want_the_Classification_to_Run                                = permission_Vector (1, 4);
            permission_Structure. do_You_Want_the_Evaluation_to_Run                                    = permission_Vector (1, 5);

            if ( permission_Vector (1, 3) == 1 )
                 permission_Structure. do_You_Want_the_DataBank_to_Run                                 = 1;

            end

            if ( permission_Vector (1, 4) == 1 )
                permission_Structure. do_You_Want_the_DataBank_to_Run                                  = 1;

            end

            if ( permission_Vector (1, 5) == 1 )
                permission_Structure. do_You_Want_the_DataBank_to_Run                                  = 1;
                permission_Structure. do_You_Want_the_Classification_to_Run                            = 1;

            end 
            
            copy_of_Permission_Structure = permission_Structure;

        % Level 8: Management of Sweeping the Different Modes    
            %         selected_preFeatureGeneration_Method                        = { 'FaradarsV1_outlierDet_PreProc', 'FaradarsV2_outlierDet_PreProc' };
            %         selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = { 'Skewness', 'Variance' };
            %         selected_postFeatureGeneration_Function                     = { 'FaradarsV1_OutlierDet_PostProc', 'WrittenV1_PCA_postProc' };
            %         selected_Classification_Method                              = { 'Support_Vector_Machinme', 'MatlabV2_MultiClass_SVM', 'FaradarsV1_Decision_Tree', 'FaradarsV1_NaiveBayesian', 'FaradarsV2_K_Nearest_Neighbors', 'FaradarsV2_Perceptron_Neural_Network', 'WrittenV1_Perceptron_Neural_Network', 'FaradarsV1_RBF_Neural_Network', 'FaradarsV1_Fuzzy_System'};
            %         selected_Evaluation_Method                                  = { 'Confusion_Matrix', 'ErrorHist_RegLine_PlotResult', 'ResubLoss', 'Plot_Receiver_Operating_Characteristic', 'MS_Error' };
            %         

            selected_preFeatureGeneration_Method                        = { '' };
            selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst = { 'Mean' }; % used in: 'Calculation_of_Statistics_for_all_Bursts.m'
                                                                                                                          % item will be useless.
            selected_postFeatureGeneration_Function                     = { 'WrittenV1_PCA_postProc' };
            selected_Classification_Method                              = { 'MatlabV2_MultiClass_SVM' };
            selected_Evaluation_Method                                  = { 'Confusion_Matrix', 'ErrorHist_RegLine_PlotResult', 'ResubLoss', 'Plot_Receiver_Operating_Characteristic', 'MS_Error' };            

            selected_preFeatureGeneration_Method_ColNum                         = size ( selected_preFeatureGeneration_Method, 2 );
            selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst_ColNum  = size ( selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst, 2 );
            selected_postFeatureGeneration_Function_ColNum                      = size ( selected_postFeatureGeneration_Function, 2 );
            selected_Classification_Method_ColNum                               = size ( selected_Classification_Method, 2 );
            selected_Evaluation_Method_ColNum                                   = size ( selected_Evaluation_Method, 2 );

            selected_preFeatureGeneration_Method_Vector                        = 1 : selected_preFeatureGeneration_Method_ColNum; 
            selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst_Vector = 1 : selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst_ColNum; 
            selected_postFeatureGeneration_Function_Vector                     = 1 : selected_postFeatureGeneration_Function_ColNum; 
            selected_Classification_Method_Vector                              = 1 : selected_Classification_Method_ColNum; 
            selected_Evaluation_Method_Vector                                  = 1 : selected_Evaluation_Method_ColNum; 

            
            permutations = struc (  selected_preFeatureGeneration_Method_Vector,                        ...
                                    selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst_Vector, ...
                                    selected_postFeatureGeneration_Function_Vector,                     ...
                                    selected_Classification_Method_Vector,                              ...
                                    selected_Evaluation_Method_Vector);

            if ( selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst_ColNum > 1 )
                dataBank_Parameters_Structure. do_You_Want_to_Make_new_DataBank = 1;

            end

        % Level 9: Folders for Deleting
            cell_of_Address_of_Output_Folders_from_Results_Folder_for_Deleting = { 'D:\PHD_Project_Folder\Resources\2016_07_11_IQ_20Msps_RZUSBSTICK\Results\04_Jan_2017_09_13_46_(FaradarsV2_Perceptron_Neural_Network)' };
                    
        % Level 10: Saving Graphic Management
            do_You_Want_the_Figs_to_be_Saved                                          = 1;
            do_You_Want_to_Save_the_Current_Output_as_a_MATFile                       = 1;
            do_You_Want_to_Write_the_Current_Output_as_a_ExcellFile                   = 1;
            do_You_Want_to_Write_the_Previously_Saved_Output_MATFile_as_a_ExcellFile  = 0;
            do_You_Want_to_Load_previosly_Saved_Figs                                  = 1;
            do_You_Want_to_Load_previosly_Saved_ExcellFile                            = 1;
            do_You_Want_to_Delete_Output_Folders_from_Results_Folder                  = 0;
            
            do_You_Want_the_Figs_to_be_Saved                                          = 1;
            do_You_Want_to_Save_the_Current_Output_as_a_MATFile                       = 0;
            do_You_Want_to_Write_the_Current_Output_as_a_ExcellFile                   = 1;
            do_You_Want_to_Write_the_Previously_Saved_Output_MATFile_as_a_ExcellFile  = 0;
            do_You_Want_to_Load_previosly_Saved_Figs                                  = 0;
            do_You_Want_to_Load_previosly_Saved_ExcellFile                            = 0;
            do_You_Want_to_Delete_Output_Folders_from_Results_Folder                  = 0;
            
        % Level 11: Making the 'Saving & Loading Folder' Address
            selected_Target_Folder_Name = dataSet_Parameters_Structure. SelectedDataSetName;
            saving_Folder_Address  = Making_the_Target_Folder ( selected_Target_Folder_Name, selected_Classification_Method );
            loading_Folder_Address = saving_Folder_Address;            

    %% Section 2: Running the Program
        for permutation_Index = 1 : size ( permutations, 1 )

            % Level 1: preProc Update
                preProc_Parameters_Structure.selected_preFeatureGeneration_Method                                                           = char ( selected_preFeatureGeneration_Method ( 1, permutations ( permutation_Index, 1 ) ) );
            
            % Level 2: DataBank Update                
                dataBank_Parameters_Structure.selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst                                    = char ( selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst ( 1, permutations ( permutation_Index, 2 ) ) );
                
            % Level 3: postProc Update                
                postProc_Parameters_Structure.selected_postFeatureGeneration_Method                                                           = char ( selected_postFeatureGeneration_Function ( 1, permutations ( permutation_Index, 3 ) ) );
                postProc_Parameters_Structure.selected_DataBank_Method_Name                                                                   = char ( dataBank_Parameters_Structure. selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst );      

                switch postProc_Parameters_Structure.selected_postFeatureGeneration_Method
                        case 'FaradarsV1_OutlierDet_PostProc'                           
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.decision_Alpha                   = 20;
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw     = [ 1 2 3 ];  % must be lower than "size (DataPoints, 1) - 1"
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.draw_or_Not                      = 1;
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.axis_Labels                      = { 'X-Amplitude', 'Y-Phase', 'Z-Frequency' };
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.special_Plot_Title               = '';
                            
                        case 'WrittenV1_PCA_postProc'                           
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.decision_Alpha                        = 20;
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw          = [ 1 2 3 ]; % must be lower than "size (classLabels_from_DataBank, 1)"
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.draw_or_Not                           = 1;
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.axis_Labels                           = { 'X-Amplitude', 'Y-Phase', 'Z-Frequency' };
                            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.special_Plot_Title                    = '';

                end

            % Level 4: Classification Update
                classification_Parameters_Structure.selected_Classification_Method                                                            = char ( selected_Classification_Method ( 1, permutations ( permutation_Index, 4 ) ) );
                
                switch classification_Parameters_Structure.selected_Classification_Method

                    case 'FaradarsV1_Support_Vector_Machine'                           
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.Saving_Address                 = [];
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw   = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
                            
                    case 'MatlabV2_MultiClass_SVM'                           
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.number_of_Hidden_Layer_Neurons = [];
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw   = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
                                                 
                    case 'FaradarsV1_Decision_Tree'                           
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.Saving_Address                 = saving_Folder_Address;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Saving_Extension      = 'jpg';
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw   = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
                        
                    case 'Faradars_V1_NaiveBayesian'                           
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification                                = []; 
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw   = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
   
                    case 'FaradarsV2_K_Nearest_Neighbors'                           
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification                                = []; 
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw   = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
                        
                    case 'FaradarsV2_Perceptron_Neural_Network' 
                        number_of_Hidden_Layer_Neurons = [ 5 5 5 ];
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.number_of_Hidden_Layer_Neurons = number_of_Hidden_Layer_Neurons;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.show_NetTraining_Window        = true;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.Saving_Address                 = saving_Folder_Address;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Saving_Extension      = 'jpg';
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw   = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
                        
                    case 'WrittenV1_Perceptron_Neural_Network'   
                        number_of_Hidden_Layer_Neurons = [ 5 5 5 1 ];
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.number_of_Hidden_Layer_Neurons = number_of_Hidden_Layer_Neurons;
                        number_of_Hidden_Layer_Neurons = number_of_Hidden_Layer_Neurons (:)';
                        for index = 1 : size ( number_of_Hidden_Layer_Neurons, 2 )
                            hiddenLayer_Type_of_Neturons ( 1, index ) = { 'tansig' };
                        end
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.hiddenLayer_Type_of_Neturons    = hiddenLayer_Type_of_Neturons;
                        
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.training_Probability = .8;

                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.GA_Parameters_Structure. maximum_Iteration = 100;                       
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.GA_Parameters_Structure. population_Size   = 400;                            
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.GA_Parameters_Structure. p_CrossOver       = .8;                                   
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.GA_Parameters_Structure. p_Mutation        = .1;                                    
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.GA_Parameters_Structure. deviation         = 20;                                     
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.GA_Parameters_Structure. ranking_Policy    = 'Descend';
                        
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.Saving_Address                             = saving_Folder_Address;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Saving_Extension                  = 'jpg';                        
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw   = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
                                  
                    case 'FaradarsV1_RBF_Neural_Network' 
                        numberMAx_of_Hidden_Layer_Neurons = 1000;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.numberMAx_of_Hidden_Layer_Neurons = numberMAx_of_Hidden_Layer_Neurons;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.show_NetTraining_Window           = true;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.Saving_Address                    = saving_Folder_Address;
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Saving_Extension         = 'jpg';
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw      = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
                                                
                    case 'FaradarsV1_Fuzzy_System'                           
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.number_of_Hidden_Layer_Neurons = [];
                        classification_Parameters_Structure.special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw   = [ postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing.selected_Dimensions_for_Draw ];
                                                
                end
                
            % Level 5: Evaluation Update                
                evaluation_Parameters_Structure. selected_Evaluation_Method                                                                   = char ( selected_Evaluation_Method ( 1, permutations ( permutation_Index, 5 ) ) );
                evaluation_Parameters_Structure. selected_Classification_Method_Name                                                          = char ( classification_Parameters_Structure. selected_Classification_Method );

            % Level 6: General PlotTitle                   
                part_1 = [  'preFeature Method: '                                                                              , ...
                            preProc_Parameters_Structure.selected_preFeatureGeneration_Method ' -- '                           , ...
                            'FingerPrint Method: '                                                                             , ...
                            dataBank_Parameters_Structure.selected_Algorithm_for_Making_FingerPrint_of_a_Single_Burst ' -- '   ];
                        
                part_2 = [  'postFeature Method: '                                                                             , ...
                            postProc_Parameters_Structure.selected_postFeatureGeneration_Method, ' -- '                        ];
                        
                temp = [];        
                for index = 1 : size ( selected_Evaluation_Method, 2 ) 
                    temp = [ temp sprintf( '%s, ', char(selected_Evaluation_Method ( 1, index )))];
                    
                end
                temp = temp (1, 1 : end - 2 );
                
                part_3 = [  'Class. Method: '                                                                                  , ...
                            classification_Parameters_Structure.selected_Classification_Method, ' -- '                         , ...
                            'Eval. Method(s): '                                                                                   , ...
                            temp, '.'                                   , ...
                            ];   

                if size ( part_1, 2 ) >= size ( part_2, 2 )
                    difference            = size ( part_1, 2 ) - size ( part_2, 2 );
                    left_Space            = floor ( difference/ 2 );
                    right_Space           = difference - left_Space;
                    additional_Left_Part  = repmat ( ' ', 1, left_Space );
                    additional_Right_Part = repmat ( ' ', 1, right_Space );

                    part_2                = [ additional_Left_Part part_2 additional_Right_Part ];

                else
                    difference            = size ( part_2, 2 ) - size ( part_1, 2 );
                    left_Space            = floor ( difference/ 2 );
                    right_Space           = difference - left_Space;
                    additional_Left_Part  = repmat ( ' ', 1, left_Space );
                    additional_Right_Part = repmat ( ' ', 1, right_Space );
                    part_1                = [ additional_Left_Part part_1 additional_Right_Part ];

                end
                
                part_2 = [ part_1; part_2 ];
                
                if size ( part_3, 2 ) >= size ( part_2, 2 )
                    difference            = size ( part_3, 2 ) - size ( part_2, 2 );
                    left_Space            = floor ( difference/ 2 );
                    right_Space           = difference - left_Space;
                    additional_Left_Part  = repmat ( ' ', 2, left_Space );
                    additional_Right_Part = repmat ( ' ', 2, right_Space );

                    part_2                = [ additional_Left_Part part_2 additional_Right_Part ];

                else
                    difference            = size ( part_2, 2 ) - size ( part_3, 2 );
                    left_Space            = floor ( difference/ 2 );
                    right_Space           = difference - left_Space;
                    additional_Left_Part  = repmat ( ' ', 1, left_Space );
                    additional_Right_Part = repmat ( ' ', 1, right_Space );
                    part_3                = [ additional_Left_Part part_3 additional_Right_Part ]; %#ok<*AGROW>

                end                
                general_PlotTitle = [ part_2; part_3 ];               
                    
            % Level 7: Managing the Run -->> We dont want the Classification Run, for different evaluation mechanisms
                if ( permutations (permutation_Index, end ) > 1 )
                    permission_Structure. do_You_Want_the_DataSet_to_Run                                       = 0;
                    permission_Structure. do_You_Want_the_preProc_to_Run                                       = 0;
                    permission_Structure. do_You_Want_the_DataBank_to_Run                                      = 0;
                    permission_Structure. do_You_Want_the_postProc_to_Run                                      = 0;
                    permission_Structure. do_You_Want_the_Classification_to_Run                                = 0;
                    permission_Structure. do_You_Want_the_Evaluation_to_Run                                    = permission_Vector (1, 5);
                    
                    permission_Structure. do_You_Want_the_Evaluation_to_Run                                    = permission_Vector (1, 5);
                    
                    dataCollection_Structure.output_Structure_from_Classification                              = output_Results ( permutation_Index - 1, 1 ).PM_output_Structure_from_Classification;
                    dataCollection_Structure.matrix_of_FingerPrint_DataBank_for_all_Devices                    = output_Results ( permutation_Index - 1, 1 ).PM_matrix_of_FingerPrint_DataBank_for_all_Devices;
                    
                else
                    permission_Structure = copy_of_Permission_Structure;
                    if ( exist('dataCollection_Structure', 'var') == 1 )
                        if ( isfield ( dataCollection_Structure, 'output_Structure_from_Classification' ) == 1 )
                            dataCollection_Structure = rmfield ( dataCollection_Structure, 'output_Structure_from_Classification' );

                        end

                        if ( isfield ( dataCollection_Structure, 'matrix_of_FingerPrint_DataBank_for_all_Devices' ) == 1 )
                            dataCollection_Structure = rmfield ( dataCollection_Structure, 'matrix_of_FingerPrint_DataBank_for_all_Devices' );

                        end

                    end                    
                    
                end
                
            % Level 8: Accumulation of Data
                dataCollection_Structure.dataSet_Parameters_Structure                                                                         = dataSet_Parameters_Structure;
                dataCollection_Structure.preProc_Parameters_Structure                                                                         = preProc_Parameters_Structure;
                dataCollection_Structure.dataBank_Parameters_Structure                                                                        = dataBank_Parameters_Structure;
                dataCollection_Structure.postProc_Parameters_Structure                                                                        = postProc_Parameters_Structure;
                dataCollection_Structure.classification_Parameters_Structure                                                                  = classification_Parameters_Structure;
                dataCollection_Structure.evaluation_Parameters_Structure                                                                      = evaluation_Parameters_Structure;
                dataCollection_Structure.permission_Structure                                                                                 = permission_Structure;
                dataCollection_Structure.general_Plot_Title                                                                                   = general_PlotTitle;
                
            % Level 9: Running Classification for all Selected Conditions           
                output_Results ( permutation_Index, 1 )                                                                                       = Project_Manager ( dataCollection_Structure );   %#ok<*SAGROW>

        end                                       

    %% Section 3: Saving the Outputs as 'Figs' and 'MATFile'                
        % Level 1: Closing GUIs rather than Figs
            % Part 1: Closing GUIs
                fprintf ( '\n\nProgram is halted until you "Press a Keyboard Button" on the last figure. By this work, all figures will be closed ... !\n' );
                figHandles = findobj('Type','figure');
                if ( isempty ( figHandles ) == 0 )
                    waitforbuttonpress
                    
                end
                nntraintool('close');
                
            % Part 2: Saving and Closing Figures 
                Saving_and_Closing_Figs ( saving_Folder_Address, do_You_Want_the_Figs_to_be_Saved );
                
        % Level 2: Saving the Output to the 'Mat File'
           if ( do_You_Want_to_Save_the_Current_Output_as_a_MATFile == 1 )
               fprintf ( '\n\nStarted to Save the Output as a MAT File ... !\n' );

               name_of_Saving_File = 'output.mat';           
               file_that_Should_be_Saved = output_Results;
               Saving_the_Output_to_the_MATFile ( saving_Folder_Address, file_that_Should_be_Saved, name_of_Saving_File );              
               fprintf ( 'Saving the Output as a MAT File Finished.\n' );
               
           else
                fprintf ( 'You Selected not to Save the Output as a MAT File ... !\n' );                
                                         
           end

    %% Writing the Current Output as 'Excell File'
        if ( do_You_Want_to_Write_the_Current_Output_as_a_ExcellFile == 1 )                              
           fprintf ( 'Started to Write the current Output as a Excell File ... !\n' );                                                                                    
           accumulated_Set                                   = Output_Loader_for_Excell (  'address_of_Selected_previosly_Saved_Output_Folder', [], ...
                                                                                           'output_Results',                                    output_Results                             );
                                                                                                  
           address_of_Selected_previosly_Saved_Output_Folder = saving_Folder_Address;
           Write_to_Excell_File ( accumulated_Set, address_of_Selected_previosly_Saved_Output_Folder, 'OutputResults.xlsx' )                           
           fprintf ( 'Writing the current Output as a Excell File Finished.\n' );
           
        else
           fprintf ( 'You Selected not to Write the current Output as a Excell File ... !\n' );                
                               
        end 
        
    %% Writing the previously Saved Output MATFile as 'Excell File'
        if ( do_You_Want_to_Write_the_Previously_Saved_Output_MATFile_as_a_ExcellFile == 1 )                              
           fprintf ( 'Started to Write the previously Saved Output MAT File as a Excell File ... !\n' );                
           address_of_Selected_previosly_Saved_Output_Folder = saving_Folder_Address;                                                                       
           accumulated_Set                                   = Output_Loader_for_Excell (  'address_of_Selected_previosly_Saved_Output_Folder', address_of_Selected_previosly_Saved_Output_Folder, ...
                                                                                           'output_Results',                                    []                             );
                                                                                                        
           Write_to_Excell_File ( accumulated_Set, address_of_Selected_previosly_Saved_Output_Folder, 'OutputResults.xlsx' )                           
           fprintf ( 'Writing the previously Saved Output MAT File as a Excell File Finished.\n' );
           
        else
           fprintf ( 'You Selected not to Write the previously Saved Output as a Excell File ... !\n' );                
                               
        end 
        
    %% Loading the previous Figs
        if ( do_You_Want_to_Load_previosly_Saved_Figs == 1 )                              
           fprintf ( 'Started to Load the previously Saved Figs ... !\n' );              
           address_of_Selected_previosly_Saved_Output_Folder = loading_Folder_Address;                                                                       
           previously_Saved_Figs_Loader (  'address_of_Selected_previosly_Saved_Output_Folder', address_of_Selected_previosly_Saved_Output_Folder );
           fprintf ( 'Loading the previously Saved Figs Finished. \n' );  
           
        else
           fprintf ( 'You Selected not to Load the previously Saved Fig File ... !\n' );                
                    
        end         
                                      
    %% Loading the previous 'Excell File'
        if ( do_You_Want_to_Load_previosly_Saved_ExcellFile == 1 )                              
           fprintf ( 'Started to Load the previously Saved Excell File ... !\n' );              
           address_of_Selected_previosly_Saved_Output_Folder = loading_Folder_Address;                                                                                 
           winopen([ address_of_Selected_previosly_Saved_Output_Folder '\' 'OutputResults.xlsx' ])                                    
           fprintf ( 'Loading the previously Saved Excell File Finished. \n' );  
           
        else
           fprintf ( 'You Selected not to Load the previously Saved Excell File ... !\n' );                
            
        end 
        
    %% Deleting the previous Saved Folder Containing  the Output Files ( '*.fig', '*.mat', '*.xlsx' ) from Results Folder
        if ( do_You_Want_to_Delete_Output_Folders_from_Results_Folder == 1 )                              
           fprintf ( 'Started to Delete the previously Saved Output Folder ... !\n' );                                                                                           
           Deleting_the_Saved_Output_Folders_from_Results ( cell_of_Address_of_Output_Folders_from_Results_Folder_for_Deleting );                                
           fprintf ( 'Deleting the previously Saved Output Folder Finished. \n' );  

        end 
                                                                   