function output = MS_Error( varargin )

% This function is copied from 'resubLoss'
   % output.mean_Square_Error_Value
   
   
	%% Section 0: Preliminaries

    %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;   
            inputSet.KeepUnmatched = true; 
            inputSet.addParameter('classLabels_from_Net', []);
            inputSet.addParameter('classLabels_from_Original_or_ReducedForApplication_DataBank', []);         
            
            inputSet.parse(varargin{:});

            classLabels_from_Net                                        = inputSet.Results.classLabels_from_Net;
            classLabels_from_Original_or_ReducedForApplication_DataBank = inputSet.Results.classLabels_from_Original_or_ReducedForApplication_DataBank;
            
            if    ( isempty( classLabels_from_Net ) == 1 )        
                error ( 'You should Enter the "classLabels from Net" for evaluation of "Mean Squared Error".' );

            elseif    ( isempty( classLabels_from_Original_or_ReducedForApplication_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for evaluation of "Mean Squared Error".' );

            end          
            
        % Level 2: Converting the 'classLabels_from_Net' and 'classLabels_from_Original_or_ReducedForApplication_DataBank' to 'Horizontal Vactors'            
            classLabels_from_Original_or_ReducedForApplication_DataBank = classLabels_from_Original_or_ReducedForApplication_DataBank ( : )';

    %% Section 2: Calculation of MSE
    	if ( isstruct ( classLabels_from_Net ) == 1 ) %#ok<*ALIGN>
            
            temp_classLabels_from_Net = classLabels_from_Net;
            
            field_Names = fieldnames ( classLabels_from_Net ); 
            for field_Index = 1 : size ( field_Names, 1 )
                 
                current_Field_Name        = char ( field_Names ( field_Index, 1 ) );
                classLabels_from_Net      = [temp_classLabels_from_Net.( current_Field_Name )];
                classLabels_from_Net      = classLabels_from_Net ( : )';

                if ( numel ( classLabels_from_Net ) ~= numel ( classLabels_from_Original_or_ReducedForApplication_DataBank ) )
                    continue;
                
                end
            
                underline_Index    = strfind( current_Field_Name, '_' );
                current_Field_Name = current_Field_Name ( 1, 1 : underline_Index (1,1) - 1 );

                saving_FieldName = [ 'mean_Squared_Error_Value' '_for_' upper(current_Field_Name(1,1)) current_Field_Name(1,2:end) ];

                mean_Squared_Error_Value        = (1/size ( classLabels_from_Net, 2 )) * sum ( ( classLabels_from_Net - classLabels_from_Original_or_ReducedForApplication_DataBank ).^ 2 );
                output.(saving_FieldName) = mean_Squared_Error_Value;

            end
            
    	else  % for: 'ErrorHist_RegLine_PlotResult'
            mean_Squared_Error_Value       = (1/size ( classLabels_from_Net, 2 )) * sum ( ( classLabels_from_Net - classLabels_from_Original_or_ReducedForApplication_DataBank ).^ 2 );
            output.mean_Square_Error_Value = mean_Squared_Error_Value;
            
        end
        
end

