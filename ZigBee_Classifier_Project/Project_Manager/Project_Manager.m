classdef Project_Manager
    
    properties
        % Input Properties
            PM_dataSet_Parameters_Structure
            PM_preProc_Parameters_Structure
            PM_dataBank_Parameters_Structure
            PM_postProc_Parameters_Structure
            PM_classification_Parameters_Structure
            PM_evaluation_Parameters_Structure
            PM_permission_Structure
            PM_general_PlotTitle                
            PM_application_or_Training
                
        % Output Properties
            PM_output_Structure_from_DataBase
            PM_output_Structure_from_preProcessing
            PM_output_Structure_from_DataBank
            PM_output_Structure_from_postProcessing
            PM_output_Structure_from_Classification
            PM_output_Structure_from_Evaluation
            PM_matrix_of_FingerPrint_DataBank_for_all_Devices
        
    end
    
    methods        
        function obj = Project_Manager ( dataCollection_Structure )           

                %% Section 1: Extraction of Essential Paramters 
                    dataCollection_Structure_Fields = fieldnames (dataCollection_Structure);
                    for index = 1 : size ( dataCollection_Structure_Fields, 1 )  
                        obj.(sprintf('PM_%s',  char(dataCollection_Structure_Fields(index, 1))) ) = dataCollection_Structure.(char(dataCollection_Structure_Fields(index, 1)));
                        
                    end

                %% Section 2: Calling Functions
                    % Level 1: DataBase
                        if  obj. PM_permission_Structure.do_You_Want_the_DataSet_to_Run == 1
                            obj. PM_dataBank_Parameters_Structure.vertical_Structure_of_all_Devices = obj.Data_Loading ( );
                            obj. PM_output_Structure_from_DataBase                                  = obj.PM_dataBank_Parameters_Structure.vertical_Structure_of_all_Devices;
                            
                        end
            
                    % Level 2: preprocessing 
                        if  obj.PM_permission_Structure.do_You_Want_the_preProc_to_Run == 1
                            obj.PM_output_Structure_from_preProcessing                              = '';
                            
                        end                    
                    
                    % Level 3: DataBank
                        if  obj. PM_permission_Structure.do_You_Want_the_DataBank_to_Run == 1
                            obj. PM_output_Structure_from_DataBank      = obj.FingerPrint_Loading ( );
                            obj. PM_output_Structure_from_DataBank      = obj.PM_output_Structure_from_DataBank. vertical_Structure_of_FingerPrint_DataBank_for_all_Devices;                  

                        end
                
                    % Level 4: postProcessing
                        if  obj.PM_permission_Structure.do_You_Want_the_postProc_to_Run == 1  
                            
                            % Stage 1: Overwriting the 'output_Structure_from_DataBank' by the 'selected_Devices_for_Classification' in the case of 'Application'
                                     % In such case, this 'selected devices' will be post-processed exactly like the 'postProc-DataBank'
                                     
                                        if ( strcmp ( obj.PM_application_or_Training, 'Application' ) == 1 )
                                            
                                            % part 1: Loading the selected device(s) that will be compared to 'selected_postProc_DataBank'.   
                                                selected_Devices_for_Classification_in_the_Case_of_Application         = load ( obj.PM_postProc_Parameters_Structure.selected_Devices_Address_for_Application );
                                                obj.PM_output_Structure_from_DataBank                                  = selected_Devices_for_Classification_in_the_Case_of_Application. vertical_Structure_of_FingerPrint_DataBank_for_all_Devices;
                                                
                                        end
                                        
                                        obj.PM_postProc_Parameters_Structure.selected_Indices_of_Devices = obj.PM_postProc_Parameters_Structure.selected_Indices_of_Devices_for_postProcessing;  
                                        
                                        
                                        

                            % Stage 1: Convert the DataBank Structure to the Matrix
                                [ PM_matrix_of_FingerPrint_DataBank_for_all_Devices, number_of_Bursts_for_all_of_Devices ] = DataBank_Structure_to_DataBank_Matrix_Converter (    obj.PM_output_Structure_from_DataBank,                                                                            ...
                                                                                                                                                                                  obj.PM_postProc_Parameters_Structure.selected_Type_of_FingerPrints_for_postProcessing,                            ...
                                                                                                                                                                                  obj.PM_postProc_Parameters_Structure.selected_Indices_of_Devices,                                                 ...
                                                                                                                                                                                  obj.PM_dataBank_Parameters_Structure.selected_DataSet_Name,                                                       ...
                                                                                                                                                                                  obj.PM_general_PlotTitle,                                                                                         ...   
                                                                                                                                                                                                                                                                                                    ...
                                                                                                                                                                                  obj.PM_postProc_Parameters_Structure.do_You_Want_to_Draw_FPPlot_for_Initial_Data,                                 ...
                                                                                                                                                                                  obj.PM_postProc_Parameters_Structure.selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String, ...
                                                                                                                                                                                  obj.PM_postProc_Parameters_Structure.selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String, ...                                                           
                                                                                                                                                                                  obj.PM_postProc_Parameters_Structure.number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot,                       ...
                                                                                                                                                                                  obj.PM_postProc_Parameters_Structure.number_of_Added_Zeros_Between_Devices,                                       ...
                                                                                                                                                                                  obj.PM_application_or_Training                                                                                    ...
                                                                                                                                                                                 );
                                                                                                                                                                             

                                        % in: 'DataBank_Structure_to_DataBank_Matrix_Converter', the number of classes (Devices) is reduced accordording to the 'selected_Indices_of_Devices_for_postProcessing'.

do_you_want_to_overwrite_the_DataBank = 0;                           
if ( do_you_want_to_overwrite_the_DataBank == 1 )                                
    data    = load('fisheriris');
    input_DataPoints_Matrix = data.meas;
    input_DataPoints_Matrix = input_DataPoints_Matrix';  
    temp = ( 1/3 ) * ( input_DataPoints_Matrix ( :, 1 : 50 ) + input_DataPoints_Matrix ( :, 51 : 100 ) + input_DataPoints_Matrix ( :, 101 : 150 )   );
    input_DataPoints_Matrix = [ input_DataPoints_Matrix, temp ];
    PM_matrix_of_FingerPrint_DataBank_for_all_Devices = [ input_DataPoints_Matrix; [ ones(1,50) 2*ones(1,50) 3*ones(1,50) 4*ones(1,50) ]  ];    % 5 X 200
    
    new_ClassLabels = [obj.PM_postProc_Parameters_Structure.selected_Indices_of_Devices_for_postProcessing];
    PM_matrix_of_FingerPrint_DataBank_for_all_Devices = PM_matrix_of_FingerPrint_DataBank_for_all_Devices ( :, 1 : size ( new_ClassLabels, 2 ) * 50 );
    temp_2 = [];
    for index = 1 : size ( new_ClassLabels, 2 )
        indices = ( PM_matrix_of_FingerPrint_DataBank_for_all_Devices ( end, : ) == new_ClassLabels ( 1, index ) );
        temp_1 ( 1, 1 : sum ( indices ) ) = new_ClassLabels ( 1, index );
        temp_2 = [ temp_2, temp_1 ];

    end
    PM_matrix_of_FingerPrint_DataBank_for_all_Devices (end, : ) = temp_2;
    
end


% figure ('Name', 'Before')                               
% a = PM_matrix_of_FingerPrint_DataBank_for_all_Devices ( 1 : end - 1, : );
% % a = a(1:40,:);
% Y = tsne(a');
% gscatter(Y(:,1),Y(:,2),PM_matrix_of_FingerPrint_DataBank_for_all_Devices ( end, : )')
% 

                            % Stage 2: postProcessing   
                                obj.PM_postProc_Parameters_Structure.matrix_of_DataPoints                   = PM_matrix_of_FingerPrint_DataBank_for_all_Devices ( 1 : end - 1, : );
                                obj.PM_postProc_Parameters_Structure.classLabels_from_DataBank              = PM_matrix_of_FingerPrint_DataBank_for_all_Devices (         end, : );

                                
asdsadsa                                
                                
                                obj.PM_matrix_of_FingerPrint_DataBank_for_all_Devices                       = obj.postProc_Caller ();
                                obj.PM_output_Structure_from_postProcessing                                 = obj.PM_matrix_of_FingerPrint_DataBank_for_all_Devices;                                

                            % Stage 3: Reduction of Devices for the case of "Application"
                                if ( strcmp ( obj.PM_application_or_Training, 'Application' ) == 1 )                                    
                                    obj.PM_postProc_Parameters_Structure.selected_Indices_of_Devices = obj.PM_postProc_Parameters_Structure.selected_Devices_Indices_for_Application;
                                    number_of_Bursts_for_all_of_Devices                              = number_of_Bursts_for_all_of_Devices ( [obj.PM_postProc_Parameters_Structure.selected_Indices_of_Devices] );
                                    
                                end


% figure ('Name', 'After')                                 
% a = [obj.PM_matrix_of_FingerPrint_DataBank_for_all_Devices];
% % a = a(1:40,:);
% Y = tsne(a','Algorithm','barneshut','NumPCAComponents',50,'NumDimensions',3);
% gscatter(Y(:,1),Y(:,2),Y(:,3),[obj.PM_postProc_Parameters_Structure.classLabels_from_DataBank]')
                           
                            % Stage 4: Plotting the 'FingerPrintPlot' for postProcessing DataBank  
                                if ( [obj.PM_postProc_Parameters_Structure.do_You_Want_to_Draw_FPPlot_for_postProcessed_Data]  == 1 ) %#ok<*BDSCA>
                                    Matrix_for_DB_after_postProc_FingerPrintPlot_Producer_Manager ( [obj.PM_matrix_of_FingerPrint_DataBank_for_all_Devices],                                                                        ...
                                                                                                    [obj.PM_postProc_Parameters_Structure.selected_Indices_of_Devices],	                                        ...
                                                                                                    number_of_Bursts_for_all_of_Devices,                                                                                            ...
                                                                                                    [obj.PM_general_PlotTitle],                                                                                                     ... 
                                                                                                                                                                                                                                    ...
                                                                                                    obj.PM_postProc_Parameters_Structure.selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String,               ...
                                                                                                    obj.PM_postProc_Parameters_Structure.selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String,               ...
                                                                                                                                                                                                                                    ...
                                                                                                    [obj.PM_postProc_Parameters_Structure.number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot],                                   ...
                                                                                                    obj.PM_postProc_Parameters_Structure.number_of_Added_Zeros_Between_Devices,                                                     ...
                                                                                                    [obj.PM_postProc_Parameters_Structure.do_You_Want_to_Edit_DataBankMatrix_withRespect_to_the_FPPlot]                             ...
                                                                                                  ) 
                                end                                                                                                                                
                        
                        end

                    % Level 5: Classification                     
                        if  obj.PM_permission_Structure.do_You_Want_the_Classification_to_Run == 1
                            obj.PM_classification_Parameters_Structure. selected_Devices_Indices_for_Application = obj.PM_postProc_Parameters_Structure.selected_Indices_of_Devices;
                            obj.PM_classification_Parameters_Structure. input_DataPoints_Matrix                  = obj.PM_matrix_of_FingerPrint_DataBank_for_all_Devices ( 1 : end - 1, : );
                            obj.PM_classification_Parameters_Structure. classLabels_from_DataBank                = obj.PM_matrix_of_FingerPrint_DataBank_for_all_Devices (         end, : );
                            obj.PM_output_Structure_from_Classification                                          = obj.Classification_Caller ();

                        end

                    % Level 6: Evaluation
                        if   ( obj.PM_permission_Structure.do_You_Want_the_Evaluation_to_Run == 1 ) 
                            %  && ( ( strcmp ( [obj.PM_application_or_Training], 'Application' ) == 0 ) ... 
                            %  &&   ( exist ( Class_Labels_for_Classified_Devices ) == 1 ) )                            
                                
                                
                            % Stage 2: Running the Evaluation            
                                list_of_Different_Types_of_Data = { 'Train', 'Validation', 'Test', 'all_Data' };

                                temp = [];
                                for dataTyp_Index = 1 : numel ( list_of_Different_Types_of_Data )

                                    current_DataType = char ( list_of_Different_Types_of_Data ( 1, dataTyp_Index ) );

                                    target_Classification_Field_for_Outputs = [ 'outputs_' current_DataType ];

                                    if ( isfield ( obj.PM_output_Structure_from_Classification, target_Classification_Field_for_Outputs ) == 1 )
                                        obj.PM_evaluation_Parameters_Structure. classLabels_from_Net                                        = obj.PM_output_Structure_from_Classification.( [ 'outputs_' current_DataType ] );
                                        obj.PM_evaluation_Parameters_Structure. type_of_Data                                                = [ '(' current_DataType '_Data)' ];
                                        obj.PM_evaluation_Parameters_Structure. classLabels_from_Original_or_ReducedForApplication_DataBank = [ obj.PM_output_Structure_from_Classification.( [ 'outputs_' current_DataType ] ).('classLabels_from_DataBank') ];                                      
                                        
                                        obj.PM_evaluation_Parameters_Structure. number_of_Bursts_for_Classified_Devices                     = [ obj.PM_output_Structure_from_Classification.( [ 'outputs_' current_DataType ] ).('number_of_Bursts') ];
                                        obj.PM_evaluation_Parameters_Structure. selected_Indices_of_Devices                                 = [ obj.PM_output_Structure_from_Classification.( [ 'outputs_' current_DataType ] ).('selected_Indices_of_Devices') ];                                        
                                        obj.PM_evaluation_Parameters_Structure. number_of_Devices_from_Original_DataBank                    = obj.PM_output_Structure_from_Classification.( [ 'outputs_' current_DataType ] ). number_of_Devices_in_the_Original_DataBank;
                                        obj.PM_evaluation_Parameters_Structure. scores                                                      = obj.PM_output_Structure_from_Classification.( [ 'outputs_' current_DataType ] ). scores;

                                        temp                = obj.Evaluation_Caller ();
                                        if ( isstruct ( temp ) == 1 )
                                            list_of_Field_Names = fieldnames ( temp );
                                            for fild_Name_Index = 1 : size ( list_of_Field_Names, 1 )
                                                current_Field   = char ( list_of_Field_Names ( fild_Name_Index, 1 ) );
                                                new_Field       = [current_Field '_' current_DataType];
                                                obj.PM_output_Structure_from_Evaluation.(new_Field) = [ temp.(current_Field) ];

                                            end

                                        end
                                        obj.PM_evaluation_Parameters_Structure = rmfield (obj.PM_evaluation_Parameters_Structure, 'type_of_Data');

                                    end

                                end
                                
                        % elseif ( obj.PM_permission_Structure.do_You_Want_the_Evaluation_to_Run == 1 ) 
                            %  && ( ( strcmp ( [obj.PM_application_or_Training], 'Application' ) == 1 ) ... 
                            %  &&   ( exist ( Class_Labels_for_Classified_Devices ) == 0 ) )
                                % To Dooooooooooooooooooooooooooooooooooo
                        end
    
        end
        
        function loaded_DataSet = Data_Loading( obj )
            temp_Obj                          = Data_Loading_Manager ( obj.PM_dataSet_Parameters_Structure );
            vertical_Structure_of_all_Devices = temp_Obj.DataSet_Maker_or_Loader_Caller ();
            loaded_DataSet                    = vertical_Structure_of_all_Devices.vertical_Structure_of_all_Devices;
            
        end
        
        function preProc_Output     = preProc_Caller ( obj )
            temp_Obj                = pre_FeatureGeneration_Processor_Manager ( obj.PM_preProc_Parameters_Structure );
            preProc_Output          = temp_Obj.function_Caller ();
            
        end         
        
        function loaded_DataBank = FingerPrint_Loading ( obj )
            temp_Obj             = FingerPrint_Production_Manager ( obj.PM_dataBank_Parameters_Structure );            
            loaded_DataBank      = temp_Obj.FingerPrint_for_Multi_Devices_Caller;

        end        
        
        function postProc_Output     = postProc_Caller ( obj )
            obj.PM_postProc_Parameters_Structure.general_PlotTitle    = obj.PM_general_PlotTitle;
            temp_Obj                                                  = post_FeatureGeneration_Processor_Manager ( obj.PM_postProc_Parameters_Structure );
            postProc_Output                                           = temp_Obj.function_Caller ();
            
        end        
        
        function classification_Output = Classification_Caller ( obj )
            obj.PM_classification_Parameters_Structure.general_PlotTitle       = obj.PM_general_PlotTitle;
            obj.PM_classification_Parameters_Structure.application_or_Training = obj.PM_application_or_Training;                                        
            temp_Obj                                                           = Classification_Manager ( obj.PM_classification_Parameters_Structure );
            classification_Output                                              = temp_Obj.function_Caller ();
            
        end
        
        function evaluation_Output     = Evaluation_Caller ( obj )            
            obj.PM_evaluation_Parameters_Structure.application_or_Training                     = obj.PM_application_or_Training;
            obj.PM_evaluation_Parameters_Structure.general_PlotTitle                           = obj.PM_general_PlotTitle;
            temp_Obj                                                                           = Evaluation_Manager ( obj.PM_evaluation_Parameters_Structure );
            evaluation_Output                                                                  = temp_Obj.function_Caller ();
            
        end                
        
    end
    
end

