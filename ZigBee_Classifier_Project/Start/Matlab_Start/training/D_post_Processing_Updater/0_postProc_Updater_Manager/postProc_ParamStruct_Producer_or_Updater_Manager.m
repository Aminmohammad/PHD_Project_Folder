function postProc_Parameters_Structure = postProc_ParamStruct_Producer_or_Updater_Manager ( strategy, varargin )

    %% Section 1: Extraction of Essential Parameters
        if ( strcmp ( strategy, 'general_Parameters' ) == 1 )
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true; 
            inputSet.addParameter( 'selected_Indices_of_Devices_for_postProcessing', [ 1 2 ] ); % [ 1 2 3 4 ... M ];
            inputSet.addParameter( 'selected_DataBank_Methods', [] );    
            inputSet.addParameter( 'selected_Type_of_FingerPrints_for_postProcessing', 'fingerPrint_for_a_Single_Device' ); % 'fingerPrint_for_a_Single_Device' or 'statistics_for_a_Single_Device'
            inputSet.addParameter( 'draw_or_Not', 0 ); % 1: draw -- 0: not    ---> if 0 -> following 3 lines are useless.
            inputSet.addParameter( 'selected_Dimensions_for_Draw', [ ] );             
            inputSet.addParameter( 'axis_Labels', [] ); 
            inputSet.addParameter( 'special_PlotTitle', [] ); 
            inputSet.addParameter( 'do_You_Want_to_Draw_FPPlot_for_Initial_Data', 0 ); 
            inputSet.addParameter( 'do_You_Want_to_Draw_FPPlot_for_postProcessed_Data', 0 ); 
            inputSet.addParameter( 'do_You_Want_to_Edit_DataBankMatrix', 0 );
            inputSet.addParameter( 'number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot', [] ); 
            inputSet.addParameter( 'number_of_Added_Zeros_Between_Devices', [] ); 
            inputSet.addParameter( 'selected_Function_for_Converting_the_MatriceRows_in_FPG_String', [] ); 
            inputSet.addParameter( 'selected_Function_for_Converting_the_MatriceCols_in_FPG_String', [] ); 
            inputSet.addParameter( 'Saving_Address', [] );
            inputSet.addParameter( 'selected_posProc_DataBank_Address_for_Application', [] );
            inputSet.addParameter( 'selected_Devices_Address_for_Application', [] );
            inputSet.addParameter( 'selected_Devices_Indices_for_Application', [] );
            
            inputSet.parse( varargin{:} );

            selected_Indices_of_Devices_for_postProcessing                              = inputSet.Results.selected_Indices_of_Devices_for_postProcessing;
            selected_DataBank_Methods                                                   = inputSet.Results.selected_DataBank_Methods;           
            selected_Type_of_FingerPrints_for_postProcessing                            = inputSet.Results.selected_Type_of_FingerPrints_for_postProcessing;
            draw_or_Not                                                                 = inputSet.Results.draw_or_Not;
            selected_Dimensions_for_Draw                                                = inputSet.Results.selected_Dimensions_for_Draw;
            axis_Labels                                                                 = inputSet.Results.axis_Labels;
            special_PlotTitle                                                           = inputSet.Results.special_PlotTitle;
            do_You_Want_to_Draw_FPPlot_for_Initial_Data                                 = inputSet.Results.do_You_Want_to_Draw_FPPlot_for_Initial_Data;
            do_You_Want_to_Draw_FPPlot_for_postProcessed_Data                           = inputSet.Results.do_You_Want_to_Draw_FPPlot_for_postProcessed_Data;
            do_You_Want_to_Edit_DataBankMatrix                                          = inputSet.Results.do_You_Want_to_Edit_DataBankMatrix;
            number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot                       = inputSet.Results.number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot;
            number_of_Added_Zeros_Between_Devices                                       = inputSet.Results.number_of_Added_Zeros_Between_Devices;
            selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String = inputSet.Results.selected_Function_for_Converting_the_MatriceRows_in_FPG_String;
            selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String = inputSet.Results.selected_Function_for_Converting_the_MatriceCols_in_FPG_String;
            Saving_Address                                                              = inputSet.Results.Saving_Address;
            selected_posProc_DataBank_Address_for_Application                           = inputSet.Results.selected_posProc_DataBank_Address_for_Application;
            selected_Devices_Address_for_Application                                    = inputSet.Results.selected_Devices_Address_for_Application;
            selected_Devices_Indices_for_Application                                    = inputSet.Results.selected_Devices_Indices_for_Application;           

            postProc_Parameters_Structure.selected_Indices_of_Devices_for_postProcessing           = selected_Indices_of_Devices_for_postProcessing;
            postProc_Parameters_Structure.selected_DataBank_Methods                                = selected_DataBank_Methods;
            postProc_Parameters_Structure.selected_Type_of_FingerPrints_for_postProcessing         = selected_Type_of_FingerPrints_for_postProcessing;
            postProc_Parameters_Structure.draw_or_Not                                              = draw_or_Not;
            postProc_Parameters_Structure.selected_Dimensions_for_Draw                             = selected_Dimensions_for_Draw;
            postProc_Parameters_Structure.axis_Labels                                              = axis_Labels;
            postProc_Parameters_Structure.special_PlotTitle                                        = special_PlotTitle;
            postProc_Parameters_Structure.Saving_Address                                           = Saving_Address;
            postProc_Parameters_Structure.selected_posProc_DataBank_Address_for_Application        = selected_posProc_DataBank_Address_for_Application;
            postProc_Parameters_Structure.selected_Devices_Address_for_Application                 = selected_Devices_Address_for_Application;
            postProc_Parameters_Structure.selected_Devices_Indices_for_Application                 = selected_Devices_Indices_for_Application;

            postProc_Parameters_Structure.do_You_Want_to_Draw_FPPlot_for_Initial_Data                                 = do_You_Want_to_Draw_FPPlot_for_Initial_Data;
            postProc_Parameters_Structure.do_You_Want_to_Draw_FPPlot_for_postProcessed_Data                           = do_You_Want_to_Draw_FPPlot_for_postProcessed_Data;
            postProc_Parameters_Structure.do_You_Want_to_Edit_DataBankMatrix_withRespect_to_the_FPPlot                = do_You_Want_to_Edit_DataBankMatrix;
            postProc_Parameters_Structure.number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot                       = number_of_Saved_Bursts_for_a_Single_Device_for_FFPlot;
            postProc_Parameters_Structure.number_of_Added_Zeros_Between_Devices                                       = number_of_Added_Zeros_Between_Devices;
            postProc_Parameters_Structure.selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String = selected_Function_for_Converting_the_MatriceRows_in_FingerPrintGraph_String;
            postProc_Parameters_Structure.selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String = selected_Function_for_Converting_the_MatriceCols_in_FingerPrintGraph_String;
            
        elseif ( strcmp ( strategy, 'special_Parameters' ) == 1 ) 
            index_of_String = strcmp ( varargin, 'selected_postFeatureGeneration_Methods' );
            index_of_nonZeros = find (index_of_String ~= 0);
            index_of_String (1, index_of_nonZeros : index_of_nonZeros + 1) = 1;
            varargin_1 = varargin ( 1, index_of_String == 1 );
            varargin_2 = varargin ( 1, index_of_String == 0 );

            temp_1 = varargin_1( 1, 2);
            selected_postFeatureGeneration_Methods = char( temp_1{:} );
            
            index_of_String   = strcmp ( varargin, 'permutation' );
            index_of_nonZeros = find (index_of_String ~= 0);
            index_of_String (1, index_of_nonZeros : index_of_nonZeros + 1) = 1;
            varargin_1 = varargin ( 1, index_of_String == 1 );
            
            temp_2 = varargin_1( 1, 2);
            permutation = cell2mat (temp_2);
            
            postProc_Parameters_Structure. selected_postFeatureGeneration_Method = strtrim( char ( selected_postFeatureGeneration_Methods ( permutation, : ) ) );
            
            selected_postProc_Function_Parameter_Updater = str2func ( [ char(postProc_Parameters_Structure. selected_postFeatureGeneration_Method) '_Special_Parameter_Updater' ] );
            postProc_Parameters_Structure.special_Structure_of_Parameters_for_postProcessing = selected_postProc_Function_Parameter_Updater ( varargin_2{:} );
            
        end
end



    
    