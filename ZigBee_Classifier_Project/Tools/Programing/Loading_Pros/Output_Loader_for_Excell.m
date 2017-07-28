function accumulated_Set = Output_Loader_for_Excell ( varargin  )

    %% Section  1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            inputSet.addParameter('address_of_Selected_previosly_Saved_Output_Folder', []);    
            inputSet.addParameter('output_Results', []);

            inputSet.parse(varargin{:});

            address_of_Selected_previosly_Saved_Output_Folder                      = inputSet.Results.address_of_Selected_previosly_Saved_Output_Folder;
            output_Results                                                         = inputSet.Results.output_Results;
            
            if        ( isempty( output_Results ) == 1 ) && ( isempty( address_of_Selected_previosly_Saved_Output_Folder ) == 1 )        
                error ( 'Since You Entered no Output-Results, You should Enter at Least the "Address of Selected previosly Saved Output Folder" for "Loading".' );

            elseif    ( isempty( output_Results ) == 1 ) && ( isempty( address_of_Selected_previosly_Saved_Output_Folder ) == 0 )            
                    fprintf ( 'You Entered no "Output-Results". Then, it will be loaded from the Folder you Selected  for "Loading".\n' );
                
            elseif    ( isempty( output_Results ) == 0 )
                    fprintf ( 'You Selected to Use Current "Output-Results" for Loading.\n' );
                                    
            end              
            
        % loading the Contents of a Folder
            if ( isempty( output_Results ) == 1 )
                content_of_Selected_previos_Output_Folder = dir ( address_of_Selected_previosly_Saved_Output_Folder );
                fprintf ( 'Loading the Output Folder Started ... !\n' );  
                for index = 3 : size ( content_of_Selected_previos_Output_Folder, 1 )
                    current_File_Name = content_of_Selected_previos_Output_Folder ( index, 1 ).name;

                    if  ( isempty ( strfind ( current_File_Name, '.mat' ) ) == 0 )

                        copyfile ( [ address_of_Selected_previosly_Saved_Output_Folder '\' current_File_Name ], [ pwd '\' current_File_Name ] );             
    
                        load ( current_File_Name )      % Loading anything other than Figures
                        delete ( [ pwd '\' current_File_Name ] )

                    end

                end
                fprintf ( 'Loading the Output Folder Finished ... !\n' );  
            end
            
            Selected_ParametersSet = [];
            Selected_ResultsSet    = [];
            for index = 1 : size ( output_Results, 1 )
%              'kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk', index                   
                % Level 1: Extraction of Input Parameters
                    current_Parameters_from_DataBase        = output_Results ( index, 1). PM_dataSet_Parameters_Structure;                    
                    selected_Parameters_from_DataBase       = parameter_Extractor ( current_Parameters_from_DataBase, [], index );
% selected_Parameters_from_DataBase
                    current_Parameters_from_preProc         = output_Results ( index, 1). PM_preProc_Parameters_Structure;
                    selected_Parameters_from_preProc        = parameter_Extractor ( current_Parameters_from_preProc, {'matrix_of_DataPoints', 'classLabels_from_DataSet'}, index );              
% selected_Parameters_from_preProc
                    current_Parameters_from_DataBank        = output_Results ( index, 1). PM_dataBank_Parameters_Structure;
                    selected_Parameters_from_DataBank       = parameter_Extractor ( current_Parameters_from_DataBank, {'vertical_Structure_of_all_Devices'}, index );
% selected_Parameters_from_DataBank
                    current_Parameters_from_postProc        = output_Results ( index, 1). PM_postProc_Parameters_Structure;
                    selected_Parameters_from_postProc       = parameter_Extractor ( current_Parameters_from_postProc, {'selected_DataBank_Method_Name', 'matrix_of_DataPoints', 'classLabels_from_DataBank', 'axis_Labels', 'plot_Title', 'selected_Indices_of_Devices'}, index );
% selected_Parameters_from_postProc
                    current_Parameters_from_Classification  = output_Results ( index, 1). PM_classification_Parameters_Structure;
                    selected_Parameters_from_Classification = parameter_Extractor ( current_Parameters_from_Classification, { 'input_DataPoints_Matrix', 'classLabels_from_DataBank', 'selected_Devices_Indices_for_Application' }, index );
% selected_Parameters_from_Classification
                    current_Parameters_from_Evaluation      = output_Results ( index, 1). PM_evaluation_Parameters_Structure;
                    selected_Parameters_from_Evaluation     = parameter_Extractor ( current_Parameters_from_Evaluation, {'selected_Classification_Method_Name', 'classLabels_from_Net', 'classLabels_from_DataBank', ''}, index );
% selected_Parameters_from_Evaluation
                    temp_Selected_ParametersSet = [   selected_Parameters_from_DataBase,       ...
                                                      selected_Parameters_from_preProc,        ...
                                                      selected_Parameters_from_DataBank,       ...
                                                      selected_Parameters_from_postProc,       ...
                                                      selected_Parameters_from_Classification, ...
                                                      selected_Parameters_from_Evaluation ];

                    Selected_ParametersSet      = [ Selected_ParametersSet; temp_Selected_ParametersSet ];

                % Level 2: Extraction of Results
%                     current_Result_from_DataBase         = output_Results ( index, 1). PM_output_Structure_from_DataBase;
%                     current_Result_from_preProc          = output_Results ( index, 1). PM_output_Structure_from_preProcessing;
%                     current_Result_from_DataBank         = output_Results ( index, 1). PM_output_Structure_from_DataBank;
%                     current_Result_from_postProc         = output_Results ( index, 1). PM_output_Structure_from_postProcessing;

%                     current_Result_from_Classification   = output_Results ( index, 1). PM_output_Structure_from_Classification;
%                     selected_Results_from_Classification = parameter_Extractor ( current_Result_from_Classification, { 'trainPerformance', 'testPerformance', 'valPerformance', 'outputs' }, index );
%                                          
                    current_Result_from_Evaluation       = output_Results ( index, 1). PM_output_Structure_from_Evaluation;
                    selected_Results_from_Evaluation     = parameter_Extractor ( current_Result_from_Evaluation, [], 1 );

                    temp_Selected_ResultsSet = selected_Results_from_Evaluation; 
 
                    if ( isempty ( temp_Selected_ResultsSet ) == 1 )
                            temp_Selected_ResultsSet      = {sprintf('No-Output_%d',index); 'No-Output'};                            
                            
                    end                       

                    if ( isempty ( Selected_ResultsSet ) == 0 )

                        titles_of_Selected_ResultsSet      = Selected_ResultsSet ( 1, : );
                        titles_of_temp_Selected_ResultsSet = temp_Selected_ResultsSet ( 1, : );

                        number_of_Rows_for_Selected_ResultsSet    = size ( Selected_ResultsSet, 1 );
                        number_of_Columns_for_Selected_ResultsSet = size ( Selected_ResultsSet, 2 );
                        index_3 = 1;
                        for index_1 = 1 : size ( titles_of_temp_Selected_ResultsSet, 2 )

                            current_title_from_temp_Selected_ResultsSet = titles_of_temp_Selected_ResultsSet ( 1, index_1 );

                            found_Field = 0;
                            for index_2 = 1 : size ( titles_of_Selected_ResultsSet, 2 )

                                current_title_from_Evaluation = titles_of_Selected_ResultsSet (1, index_2 );
                                if ( strcmp ( current_title_from_Evaluation, current_title_from_temp_Selected_ResultsSet ) == 1 )
                                    found_Field = 1;
                                    break;
                                end

                            end

                            if ( found_Field == 1 )
                                Selected_ResultsSet ( number_of_Rows_for_Selected_ResultsSet + 1, index_2 ) = temp_Selected_ResultsSet ( 2, index_1 );

                            else

                                Selected_ResultsSet (                                          1, number_of_Columns_for_Selected_ResultsSet + index_3 ) = temp_Selected_ResultsSet ( 1, index_1 );
                                Selected_ResultsSet ( number_of_Rows_for_Selected_ResultsSet + 1, number_of_Columns_for_Selected_ResultsSet + index_3 ) = temp_Selected_ResultsSet ( 2, index_1 );
                                index_3 = index_3 + 1;

                            end


                        end

                    else
                        Selected_ResultsSet      = temp_Selected_ResultsSet;                            
                            
                    end

            end

            accumulated_Set = [ Selected_ParametersSet Selected_ResultsSet ];

end

function selected_Parameter_Set = parameter_Extractor ( input_Parameter_Set, exceptions, calling_Index )

    exceptions = exceptions ( : );

    selected_Parameter_Set = [];
    
    if ( isstruct ( input_Parameter_Set ) == 1 )
        field_Names = fieldnames ( input_Parameter_Set );
        
    else
        return;
        
    end
    
    for field_Index = 1 : size ( field_Names, 1 )
        current_Field = char ( field_Names ( field_Index, 1 ) );
        found_nonPermitted_Parameter = 0;
        for exception_Index = 1 : size ( exceptions, 1 )
            current_Exception = char ( exceptions ( exception_Index, 1 ) );
            if ( strcmp ( current_Field, current_Exception ) == 1 )
                found_nonPermitted_Parameter = 1;
                break;
                
            end

        end
        
        if ( found_nonPermitted_Parameter == 0 )
            
            if     ( ischar ( input_Parameter_Set.(current_Field) ) == 1 )
                
                if ( calling_Index == 1 )
                    selected_Parameter_Set = [ selected_Parameter_Set {current_Field; sprintf( '%s', input_Parameter_Set.(current_Field) )  }]; %#ok<*AGROW>
                    
                else
                    selected_Parameter_Set = [ selected_Parameter_Set {sprintf( '%s', input_Parameter_Set.(current_Field) )  }];
                    
                    
                end
                
            elseif ( iscell ( input_Parameter_Set.(current_Field) ) == 1 )
                if ( calling_Index == 1 )                  
                    selected_Parameter_Set = [ selected_Parameter_Set {current_Field; sprintf( '%s ', input_Parameter_Set.(current_Field){:} )  }];
                    
                else
                    selected_Parameter_Set = [ selected_Parameter_Set {sprintf( '%s ', input_Parameter_Set.(current_Field){:} ) }];
                    
                    
                end
                
            elseif ( isnumeric(input_Parameter_Set.(current_Field) ) == 1 )  && ( isscalar ( input_Parameter_Set.(current_Field) ) == 1 ) 
                
                if ( calling_Index == 1 )
                    selected_Parameter_Set = [ selected_Parameter_Set {current_Field; sprintf( '%4.4f', input_Parameter_Set.(current_Field) )  }];
                    
                else
                    selected_Parameter_Set = [ selected_Parameter_Set {sprintf( '%4.4f', input_Parameter_Set.(current_Field) )  }];
                    
                    
                end
                
            elseif ( isnumeric(input_Parameter_Set.(current_Field) ) == 1 )  && ( isvector ( input_Parameter_Set.(current_Field) ) == 1 ) && ( isstruct ( input_Parameter_Set.(current_Field) ) == 0 ) && ( size ( input_Parameter_Set.(current_Field), 2 ) <= 5 )
                vector_String = sprintf( '%d ', input_Parameter_Set.(current_Field) );
                vector_String = [ '[' vector_String( :, 1 : end - 1 ) ']' ];
                if ( calling_Index == 1 )
                    selected_Parameter_Set = [ selected_Parameter_Set { current_Field; vector_String }];
                    
                else
                    selected_Parameter_Set = [ selected_Parameter_Set { vector_String }];
                    
                    
                end     
                
            elseif ( isnumeric(input_Parameter_Set.(current_Field) ) == 1 )  && ( ismatrix ( input_Parameter_Set.(current_Field) ) == 1 ) && ( isempty ( input_Parameter_Set.(current_Field) ) == 0 ) && ( isvector ( input_Parameter_Set.(current_Field) ) == 0 ) && ( isstruct ( input_Parameter_Set.(current_Field) ) == 0 ) && ( max ( size ( input_Parameter_Set.(current_Field) ) ) <= 5 )
                matrix = input_Parameter_Set.(current_Field);
                for index = 1 : size ( matrix, 1 )
                
                    if ( index == 1 )
                        matrix_String = sprintf ( '%4.4f ', matrix ( index, : ) );
                        matrix_String = [ matrix_String( 1, 1 : end - 1 ) ';' ];
                        
                    else

                        matrix_String = [ matrix_String ' ' sprintf( '%4.4f ', matrix( index, : ) ) ] ;
                        matrix_String = [ matrix_String( 1, 1 : end - 1 ) ';' ];
                        
                    end
                    
                end
                
                matrix_String = [ '[' matrix_String( :, 1 : end - 1) ']' ];

                if ( calling_Index == 1 )
                    selected_Parameter_Set = [ selected_Parameter_Set {current_Field; matrix_String  }];
                    
                else
                    selected_Parameter_Set = [ selected_Parameter_Set {matrix_String  }];
                    
                    
                end                                     

            end
            
        end


    end

end