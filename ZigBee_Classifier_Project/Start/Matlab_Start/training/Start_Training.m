function Start_Training ( varargin )


    %% Section 0: Extraction of Essential Variables  
        inputSet = inputParser();
        inputSet.CaseSensitive = false; 
        inputSet.KeepUnmatched = true; 
        inputSet.addParameter( 'dataSet_Input_Arguments', [] );
        
        inputSet.addParameter( 'general_preProc_Input_Arguments', [] );
        inputSet.addParameter( 'special_preProc_Input_Arguments', [] );
        
        inputSet.addParameter( 'dataBank_Input_Arguments', [] );
        
        inputSet.addParameter( 'general_postProc_Input_Arguments', [] );
        inputSet.addParameter( 'special_postProc_Input_Arguments', [] );
        
        inputSet.addParameter( 'general_Classification_Input_Arguments', [] );
        inputSet.addParameter( 'special_Classification_Input_Arguments', [] );
        
        inputSet.addParameter( 'general_Evaluation_Input_Arguments', [] );
        inputSet.addParameter( 'special_Evaluation_Input_Arguments', [] );        
        
        inputSet.addParameter( 'run_Permissions_Input_Arguments', [] );
        
        inputSet.addParameter( 'saving_Permissions_Input_Arguments', [] );
        
        inputSet.addParameter( 'permutations', [] );
        
        inputSet.addParameter( 'addresses', [] );
        
        inputSet.addParameter( 'application_or_Training', [] );        
        
        inputSet.parse( varargin{:} );

        dataSet_Input_Arguments  = inputSet.Results.dataSet_Input_Arguments;
        
        general_preProc_Input_Arguments = inputSet.Results.general_preProc_Input_Arguments;
        special_preProc_Input_Arguments = inputSet.Results.special_preProc_Input_Arguments;
        
        dataBank_Input_Arguments  = inputSet.Results.dataBank_Input_Arguments;
      
        general_postProc_Input_Arguments = inputSet.Results.general_postProc_Input_Arguments;
        special_postProc_Input_Arguments = inputSet.Results.special_postProc_Input_Arguments;
        
        general_Classification_Input_Arguments = inputSet.Results.general_Classification_Input_Arguments;
        special_Classification_Input_Arguments = inputSet.Results.special_Classification_Input_Arguments;
        
        general_Evaluation_Input_Arguments = inputSet.Results.general_Evaluation_Input_Arguments;
        special_Evaluation_Input_Arguments = inputSet.Results.special_Evaluation_Input_Arguments;
        
        run_Permissions_Input_Arguments  = inputSet.Results.run_Permissions_Input_Arguments;
        
        saving_Permissions_Input_Arguments  = inputSet.Results.saving_Permissions_Input_Arguments;
        
        permutations  = inputSet.Results.permutations; % permutations: [ pre_Process( if not empty), DataBank, post_Process, Classification, Evaluation   ]
        addresses     = inputSet.Results.addresses;  
        
        application_or_Training     = inputSet.Results.application_or_Training;
        
                                           
    %% Section 1: Start of Saving the Content of Command Window to the 'CommandInfos.txt' 
        saving_Folder_Address_Index = strcmp ( addresses, 'saving_Folder_Address' );
        saving_Folder_Address_Index = find ( saving_Folder_Address_Index ~= 0 );
        diary([ char( addresses( 1, saving_Folder_Address_Index + 1 ) ) '\CommandInfos.txt']);                                                        
        
    %% Section 2: Running the Program
        for permutation_Index = 1 : size ( permutations, 1 )

            % Level 1: DataSet Update     
                dataSet_Parameters_Structure  = DataSet_ParamStruct_Producer_or_Updater_Manager( dataSet_Input_Arguments{:} );

            % Level 2: preProc Update 
                general_preProc_Parameters_Structure = preProc_ParamStruct_Producer_or_Updater_Manager ( 'general_Parameters', general_preProc_Input_Arguments {:} );
                new_Special_preProc_Input_Arguments  = [];
                new_Special_preProc_Input_Arguments  = [ special_preProc_Input_Arguments, { 'permutation', permutations( permutation_Index, end - 2 ) } ];                     
                special_preProc_Parameters_Structure = preProc_ParamStruct_Producer_or_Updater_Manager ( 'special_Parameters', new_Special_preProc_Input_Arguments{:} );
                
                % Concatinating 'general_preProc_Parameters_Structure' and 'special_preProc_Parameters_Structure'
                    if ( isempty ( general_preProc_Parameters_Structure ) == 0 ) && isempty ( special_preProc_Parameters_Structure ) == 0
                        field_Names                  = [fieldnames(general_preProc_Parameters_Structure); fieldnames(special_preProc_Parameters_Structure)];
                        preProc_Parameters_Structure = cell2struct([struct2cell(general_preProc_Parameters_Structure); struct2cell(special_preProc_Parameters_Structure)], field_Names, 1);                                
                        
                    else
                        preProc_Parameters_Structure = special_preProc_Parameters_Structure;
                        
                    end
                
            % Level 3: DataBank Update 
                dataBank_Parameters_Structure = DataBank_ParamStruct_Producer_or_Updater_Manager ( dataBank_Input_Arguments {:} );

            % Leve4 : postProc Update    
                general_postProc_Parameters_Structure = postProc_ParamStruct_Producer_or_Updater_Manager ( 'general_Parameters', general_postProc_Input_Arguments{:} );
                new_Special_postProc_Input_Arguments  = [];
                new_Special_postProc_Input_Arguments  = [ special_postProc_Input_Arguments, { 'permutation', permutations( permutation_Index, end - 2 ) } ];                     
                special_postProc_Parameters_Structure = postProc_ParamStruct_Producer_or_Updater_Manager ( 'special_Parameters', new_Special_postProc_Input_Arguments{:} );
                
                % Concatinating 'general_postProc_Parameters_Structure' and 'special_postProc_Parameters_Structure'
                    field_Names                   = [fieldnames(general_postProc_Parameters_Structure); fieldnames(special_postProc_Parameters_Structure)];
                    postProc_Parameters_Structure = cell2struct([struct2cell(general_postProc_Parameters_Structure); struct2cell(special_postProc_Parameters_Structure)], field_Names, 1);                
 
            % Level 5: Classification Update               
                general_Classification_Parameters_Structure = Classification_ParamStruct_Producer_or_Updater_Manager ( 'general_Parameters', general_Classification_Input_Arguments{:} );
                new_Special_Classification_Input_Arguments  = [];
                new_Special_Classification_Input_Arguments  = [ special_Classification_Input_Arguments, { 'permutation', permutations( permutation_Index, end - 1 ) } ];                     
                special_Classification_Parameters_Structure = Classification_ParamStruct_Producer_or_Updater_Manager ( 'special_Parameters', new_Special_Classification_Input_Arguments{:} );
                
                % Concatinating 'general_Classification_Parameters_Structure' and 'special_Classification_Parameters_Structure'
                    field_Names                         = [fieldnames(general_Classification_Parameters_Structure); fieldnames(special_Classification_Parameters_Structure)];
                    classification_Parameters_Structure = cell2struct([struct2cell(general_Classification_Parameters_Structure); struct2cell(special_Classification_Parameters_Structure)], field_Names, 1);                

            % Level 6: Evaluation Update  
                general_Evaluation_Parameters_Structure = Evaluation_ParamStruct_Producer_or_Updater_Manager ( 'general_Parameters', general_Evaluation_Input_Arguments {:} );
                new_Special_Evaluation_Input_Arguments  = [];
                new_Special_Evaluation_Input_Arguments  = [ special_Evaluation_Input_Arguments, { 'permutation', permutations( permutation_Index, end ) } ];                
                special_Evaluation_Parameters_Structure = Evaluation_ParamStruct_Producer_or_Updater_Manager ( 'special_Parameters', new_Special_Evaluation_Input_Arguments {:} );

                % Concatinating 'general_Evaluation_Parameters_Structure' and 'special_Evaluation_Parameters_Structure'
                    if ( isempty ( general_Evaluation_Parameters_Structure ) == 0 ) && isempty ( special_Evaluation_Parameters_Structure ) == 0
                        field_Names                   = [fieldnames(general_Evaluation_Parameters_Structure); fieldnames(special_Evaluation_Parameters_Structure)];
                        evaluation_Parameters_Structure = cell2struct([struct2cell(general_Evaluation_Parameters_Structure); struct2cell(special_Evaluation_Parameters_Structure)], field_Names, 1);                                
                        
                    else
                        evaluation_Parameters_Structure = special_Evaluation_Parameters_Structure;
                    end               

            % Level 7: General PlotTitle Parameters                                           
                general_PlotTitle_Input_Arguments = {  'dataSet_Parameters_Structure',                         dataSet_Parameters_Structure,                         ... 
                                                       'preProc_Parameters_Structure',                         preProc_Parameters_Structure,                         ...
                                                       'dataBank_Parameters_Structure',                        dataBank_Parameters_Structure,                        ...
                                                       'postProc_Parameters_Structure',                        postProc_Parameters_Structure,                        ...
                                                       'classification_Parameters_Structure',                  classification_Parameters_Structure,                  ...
                                                       'evaluation_Parameters_Structure',                      evaluation_Parameters_Structure,                      ...
                                                        }; 
                                                    
                general_PlotTitle = General_PlotTitle_Producer_or_Updater_Manager ( general_PlotTitle_Input_Arguments {:} );

                % Removing the field 'selected_Evaluation_Methods_for_GeneralPlotTitle'
                % from 'evaluation_Parameters_Structure'
                    if (  isfield ( evaluation_Parameters_Structure, 'selected_Evaluation_Methods_for_GeneralPlotTitle' ) == 1 )
                        evaluation_Parameters_Structure = rmfield ( evaluation_Parameters_Structure, 'selected_Evaluation_Methods_for_GeneralPlotTitle' );
                        
                    end
              
            % Level 8: Managing the Run -->> We dont want the Classification Run, for different evaluation mechanisms
                if ( ( permutations (permutation_Index, end ) > 1 ) &&  (strcmp ( application_or_Training, 'Training' ) == 1 ) )     ...
                                                                      ||                                                             ...                                             
                   ( ( permutation_Index > 1 ) && (strcmp ( application_or_Training, 'Application' ) == 1 ) )
               
                    run_Permissions_Input_Arguments = [ run_Permissions_Input_Arguments,  ...
                                                   { 'output_Results', output_Results }
                                                   ];
                    permission_Structure = PermissionStructure_Producer_or_Updater_Manager ( 'update_for_Evaluation', run_Permissions_Input_Arguments{:} );
                    
                    dataCollection_Structure.output_Structure_from_Classification                              = output_Results ( permutation_Index - 1, 1 ).PM_output_Structure_from_Classification;
                    dataCollection_Structure.matrix_of_FingerPrint_DataBank_for_all_Devices                    = output_Results ( permutation_Index - 1, 1 ).PM_matrix_of_FingerPrint_DataBank_for_all_Devices;
                    
                elseif ( permutation_Index == 1 ) && (strcmp ( application_or_Training, 'Application' ) == 1 ) 
%                                     run_Permissions_Input_Arguments = [ run_Permissions_Input_Arguments,  ...
%                                                                    { 'output_Results', output_Results }
%                                                                    ];
                                    permission_Structure = PermissionStructure_Producer_or_Updater_Manager ( 'update_for_Initialization_in_Application', run_Permissions_Input_Arguments{:} );
                    
%                                     dataCollection_Structure.output_Structure_from_Classification                              = output_Results ( permutation_Index - 1, 1 ).PM_output_Structure_from_Classification;
%                                     dataCollection_Structure.matrix_of_FingerPrint_DataBank_for_all_Devices                    = output_Results ( permutation_Index - 1, 1 ).PM_matrix_of_FingerPrint_DataBank_for_all_Devices;

                else
                    permission_Structure = PermissionStructure_Producer_or_Updater_Manager ( 'initialization', run_Permissions_Input_Arguments {:} );
                    
                    if ( exist('dataCollection_Structure', 'var') == 1 )
                        if ( isfield ( dataCollection_Structure, 'output_Structure_from_Classification' ) == 1 )
                            dataCollection_Structure = rmfield ( dataCollection_Structure, 'output_Structure_from_Classification' );

                        end

                        if ( isfield ( dataCollection_Structure, 'matrix_of_FingerPrint_DataBank_for_all_Devices' ) == 1 )
                            dataCollection_Structure = rmfield ( dataCollection_Structure, 'matrix_of_FingerPrint_DataBank_for_all_Devices' );

                        end

                    end                    
                    
                end
%                permission_Structure
            % Level 9: Accumulation of Data
                dataCollection_Structure.dataSet_Parameters_Structure         = dataSet_Parameters_Structure;
                dataCollection_Structure.preProc_Parameters_Structure         = preProc_Parameters_Structure;
                dataCollection_Structure.dataBank_Parameters_Structure        = dataBank_Parameters_Structure;
                dataCollection_Structure.postProc_Parameters_Structure        = postProc_Parameters_Structure;
                dataCollection_Structure.classification_Parameters_Structure  = classification_Parameters_Structure;
                dataCollection_Structure.evaluation_Parameters_Structure      = evaluation_Parameters_Structure;
                dataCollection_Structure.permission_Structure                 = permission_Structure;
                dataCollection_Structure.general_PlotTitle                    = general_PlotTitle;
                dataCollection_Structure.application_or_Training              = application_or_Training;
                
            % Level 10: Running Classification for all Selected Conditions           
                output_Results ( permutation_Index, 1 )                       = Project_Manager ( dataCollection_Structure );   %#ok<*SAGROW>

        end                                       
     
    %% Section 2: Setting the Invisible Figures Visible         
        figHandles = findobj('Type', 'figure');
        for fig_Index = 1 : numel ( figHandles )
            set ( figHandles ( fig_Index ), 'Visible', 'on' )

        end   

    %% Section 3: Saving 
        % Level 1: Saving the Outputs as 'Figs' and 'MATFile'
            varargin = [ saving_Permissions_Input_Arguments, ...
                         addresses,                          ...
                         { 'output_Results', output_Results }   ];

            Output_of_Start_Saver_or_Closer ( varargin {:} );
        
        % Level 2: End of Saving the Content of Command Window to the 'CommandInfos.txt' 
            diary('off');   

