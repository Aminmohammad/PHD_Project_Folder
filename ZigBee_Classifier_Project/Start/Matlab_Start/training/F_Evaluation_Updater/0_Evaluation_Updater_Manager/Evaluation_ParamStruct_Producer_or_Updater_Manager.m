function evaluation_Parameters_Structure = Evaluation_ParamStruct_Producer_or_Updater_Manager ( strategy, varargin )

    %% Section 1: Extraction of Essential Parameters
        if ( strcmp ( strategy, 'general_Parameters' ) == 1 )
            evaluation_Parameters_Structure = [];
            
        elseif ( strcmp ( strategy, 'special_Parameters' ) == 1 ) 
            index_of_String   = strcmp ( varargin, 'selected_Evaluation_Methods' );
            index_of_nonZeros = find (index_of_String ~= 0);
            index_of_String (1, index_of_nonZeros : index_of_nonZeros + 1) = 1;
            varargin_1 = varargin ( 1, index_of_String == 1 );
            
            temp_1 = varargin_1( 1, 2);
            selected_Evaluation_Methods = char( temp_1 {:} );
            
            index_of_String   = strcmp ( varargin, 'permutation' );
            index_of_nonZeros = find (index_of_String ~= 0);
            index_of_String (1, index_of_nonZeros : index_of_nonZeros + 1) = 1;
            varargin_1 = varargin ( 1, index_of_String == 1 );

            temp_2 = varargin_1( 1, 2);
            permutation = cell2mat (temp_2);
            
            evaluation_Parameters_Structure.selected_Evaluation_Method                       = strtrim( char ( selected_Evaluation_Methods ( permutation, : ) ) );
            evaluation_Parameters_Structure.selected_Evaluation_Methods_for_GeneralPlotTitle = temp_1; 
            
%             varargin_2 = varargin ( 1, index_of_String == 0 );
%             selected_Evaluation_Function_Parameter_Updater = str2func ( [ [evaluation_Parameters_Structure.selected_Classification_Method] '_Special_Parameter_Updater' ] );
%             evaluation_Parameters_Structure.special_Structure_of_Parameters_for_Evaluation = selected_Evaluation_Function_Parameter_Updater ( varargin_2{:} );
              
        end

        
end

    
    