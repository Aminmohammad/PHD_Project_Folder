function Matrix_for_DB_after_postProc_FingerPrintPlot_Producer_Manager ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot,   ...
                                                                         selected_Indices_of_Devices_for_postProcessing,              ...
                                                                         number_of_Bursts_for_all_of_Devices,                         ...
                                                                         general_PlotTitle,                                           ...
                                                                         selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String, ...
                                                                         selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String, ...
                                                                                                                                      ...
                                                                         number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot,       ...
                                                                         number_of_Added_Zeros_Between_Devices,                       ...
                                                                         do_You_Want_to_Edit_DataBankMatrix_withRespect_to_the_FPPlot ...
                                                                         )                               

    %% Section 0: Extraction of Essential Inputs
        func_for_Rows_String                                                                 = selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String;
        func_for_Rows                                                                        = str2func ( func_for_Rows_String );
        
%         func_for_Cols_String                                                                 = selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String;
%         func_for_Cols                                                               = str2func ( func_for_Cols_String );
        
        initial_Component_Index = 80;

    %% Section 2: Lading the 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot' && 'YLabel'               
        matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot = [ zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 111: initial_Component_Index + 120, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 101: initial_Component_Index + 110, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 91:  initial_Component_Index + 100, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...                                                                     
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 81:  initial_Component_Index + 90, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 71:  initial_Component_Index + 80, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 61:  initial_Component_Index + 70, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ... 
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 51:  initial_Component_Index + 60, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 41:  initial_Component_Index + 50, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 31:  initial_Component_Index + 40, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 21:  initial_Component_Index + 30, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 11:  initial_Component_Index + 20, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ) ); ...
                                                                      func_for_Rows(matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( initial_Component_Index + 1 :  initial_Component_Index + 10, : )); ...
                                                                      zeros( 1, size( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 2 ))];

    % Normalizing 'matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot_AmplitudeBased'
        for row_Index = 1 : size ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, 1 )

            if ( any ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( row_Index, : ) ) ~= 0 )

                minimum_Value = min ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( row_Index, : ) );
                if ( minimum_Value < 0 )
                    matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( row_Index, : ) + abs ( minimum_Value );

                end

                maximum_Value = max ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( row_Index, : ) );
                matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( row_Index, : ) = matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot( row_Index, : ) / maximum_Value;
            end
        end                                                                  
                                                                  
        YLabel = {  ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 111, initial_Component_Index + 120 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 101, initial_Component_Index + 110 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 91,  initial_Component_Index + 100 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 81,  initial_Component_Index + 90 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 71,  initial_Component_Index + 80 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 61,  initial_Component_Index + 70 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 51,  initial_Component_Index + 60 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 41,  initial_Component_Index + 50 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 31,  initial_Component_Index + 40 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 21,  initial_Component_Index + 30 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 11,  initial_Component_Index + 20 );
                    ' ';
                    sprintf('%s(Comps_{%d}_:_{%d})', func_for_Rows_String, initial_Component_Index + 1,   initial_Component_Index + 10 );
                    ' ';
                    };   

                [ matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, XLabel, indices_of_Seperations_in_X_for_XTickLabels, indices_of_Seperations_in_X_for_Veritcal_Lines, indices_of_Seperations_in_Y, indices_of_Accumulation_in_Y ] = Zero_Adder_and_XLabel_YLabelndices_Extractor (   matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, ...
                                                                                                                                                                                                                                                                                                 selected_Indices_of_Devices_for_postProcessing,            ...
                                                                                                                                                                                                                                                                                                 number_of_Bursts_for_all_of_Devices,                       ...
                                                                                                                                                                                                                                                                                                 YLabel,                                                    ...
                                                                                                                                                                                                                                                                                                 number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot,     ...
                                                                                                                                                                                                                                                                                                 number_of_Added_Zeros_Between_Devices                      ...
                                                                                                                                                                                                                                                                                                 );

        % Plotting the Graph
            FingerPrint_Graph ( matrix_of_FingerPrint_DataBank_for_all_Devices_for_FPPlot, indices_of_Seperations_in_X_for_XTickLabels, indices_of_Seperations_in_X_for_Veritcal_Lines, XLabel, YLabel, indices_of_Seperations_in_Y, indices_of_Accumulation_in_Y, general_PlotTitle, 'Data FingerPrint After PostProcessing' )

            
        % Stage 4: Editing the 'obj.PM_output_Structure_from_postProcessing' with respect to the 'RFDNA FingerPrint Plot'                                 
            if ( do_You_Want_to_Edit_DataBankMatrix_withRespect_to_the_FPPlot  == 1 )
                % To Do

            end            

end