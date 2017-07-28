function selected_projected_DataBank_Matrix_for_Output = WrittenV1_PCA_postProc ( varargin )

% Inputs:
%           matrix_of_DataPoints (Matrix):
%
%                              DataPoints
%                           __              __
%                           |                |
%                           |                |            
%              Dimensions   |                |
%                           |_              _|



%           classLabels_from_DataSet (Vector):
%
%                                 Labels
%                           __              __
%                           |_               _|                                   
%
%                                    or                            
%                                  __  __
%                                  |    |
%                                  |    |            
%                          Labels  |    |
%                                  |_  _|
   %% Section 0: Preliminaries

    %% Section  1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            inputSet.addParameter('selected_Indices_of_Devices_for_postProcessing', '');
            inputSet.addParameter('selected_Type_of_FingerPrints_for_postProcessing', '');                            
            inputSet.addParameter('draw_or_Not', 1 );     
            inputSet.addParameter('selected_Dimensions_for_Draw', [ 1 2 ] );
            inputSet.addParameter('axis_Labels', 1 ); 
            inputSet.addParameter('special_PlotTitle', [] );            
            inputSet.addParameter('general_PlotTitle', [] );                        

            inputSet.addParameter('matrix_of_DataPoints', []);
            inputSet.addParameter('classLabels_from_DataBank', []);             

            inputSet.addParameter('special_Structure_of_Parameters_for_postProcessing', []);              
            inputSet.parse(varargin{:});

            selected_Indices_of_Devices_for_postProcessing                                           = inputSet.Results.selected_Indices_of_Devices_for_postProcessing;
            selected_Type_of_FingerPrints_for_postProcessing                                         = inputSet.Results.selected_Type_of_FingerPrints_for_postProcessing;
            do_you_Want_to_Draw_Raw_and_Projected_DataPoints_in_a_two_or_three_Dimensional_Plot      = inputSet.Results.draw_or_Not;            
            selected_Dimensions_for_Draw                                                             = inputSet.Results.selected_Dimensions_for_Draw;
            axis_Labels                                                                              = inputSet.Results.axis_Labels;
            special_PlotTitle                                                                        = inputSet.Results.special_PlotTitle;
            general_PlotTitle                                                                        = inputSet.Results.general_PlotTitle;
            
            matrix_of_DataPoints                                                                     = inputSet.Results.matrix_of_DataPoints;
            classLabels_from_DataBank                                                                = inputSet.Results.classLabels_from_DataBank;

            special_Structure_of_Parameters_for_postProcessing                                       = inputSet.Results.special_Structure_of_Parameters_for_postProcessing;
            
          
            if        ( isempty( matrix_of_DataPoints ) == 1 )        
                error ( 'You should Enter the "matrix of DataPoints" for "Outlier Detection".' );

            elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels from DataBank" for "Outlier Detection".' );
            
            end  

            if ( isempty ( special_Structure_of_Parameters_for_postProcessing ) == 0 && isempty ( isfield ( special_Structure_of_Parameters_for_postProcessing, 'graph_Text_Size' ) ) == 0 )
                graph_Text_Size   = special_Structure_of_Parameters_for_postProcessing.graph_Text_Size;
                
            else 
                graph_Text_Size = .07;
                
            end        
            
        % Level 2: Converting the 'classLabels_from_DataSet' to 'Horizontal Vactors'
            classLabels_from_DataBank    = classLabels_from_DataBank ( : )';
               
        % Level 3: Converting the 'selected_Dimensions_for_Draw' to 'Horizontal Vactors'
            selected_Dimensions_for_Draw = selected_Dimensions_for_Draw ( : )';
            
        % Level 4: Checking if each of 'selected_Dimensions_of_Components_for_Draw'    
                %  is bigger than the number of dimensions of 'matrix_of_DataPoints'
                    if ( max ( selected_Dimensions_for_Draw ) > size ( matrix_of_DataPoints, 1 ) )
                        fprintf ( 'none of "selected Dimensions of Components for Draw" can not be bigger than "Row-Number" of "matrix_of_DataPoints" which is Dimension-Number (P).\n' )
                        fprintf ( 'Then we reduced "selected Dimensions of DataPoints for Draw" to "1:%d (p)" \n', size ( matrix_of_DataPoints, 1 ) )
                        selected_Dimensions_for_Draw = 1 : size ( matrix_of_DataPoints, 1 ); %#ok<*NASGU>
          
                    end
       
    %% Section  2: Calculation of PCA                    
        % Level 1: Centerizing each Dimension by reducing the mean of 
                   % DataPoints from it                   
                        % Stge 1: claculating the mean of dimenstions ( rows )
                            mean_Vertical_Vector = mean ( matrix_of_DataPoints, 2 );

                        % Stge 2: reducing the mean of dimenstions ( rows )
                            centerized_Matrix_of_DataPoints = matrix_of_DataPoints - repmat ( mean_Vertical_Vector, 1, size ( matrix_of_DataPoints, 2 ) );

        % Level 2: Calculating the 'SVD' and 'PCA' for all Classes'
            [ V, projected_DataPoints, S ] = pca ( centerized_Matrix_of_DataPoints' );

            % Correction the size of V vector for Demonstration
                for V__Column_index = 1 : size ( V, 2 )
                    V( :, V__Column_index ) = 5 * sqrt( S( V__Column_index ) ) * V( :, V__Column_index );

                end

        % Level 3: Seperation of 'PCA' projected_Dimensions for each Class                
            different_Classes    = unique (classLabels_from_DataBank, 'stable');
            legend_of_Starting_and_Ending_Indices_of_all_Classes = [];
            for class_Index = 1 : size ( different_Classes, 2 )
                current_Class_Indices = ( classLabels_from_DataBank == different_Classes( 1, class_Index ) );
                current_Class_Indices = find ( current_Class_Indices ~= 0 );
                starting_and_Ending_Indices_of_all_Classes ( class_Index, : ) = [current_Class_Indices(1, 1 ) current_Class_Indices(1, end )];

                temp = [ 'ClassLabel (' num2str(class_Index) ') = ' num2str( different_Classes ( 1, class_Index ) ) ' : ' num2str(starting_and_Ending_Indices_of_all_Classes( class_Index, 1 )) '->' num2str(starting_and_Ending_Indices_of_all_Classes( class_Index, 2 )) ];
                
                legend_of_Starting_and_Ending_Indices_of_all_Classes = [ legend_of_Starting_and_Ending_Indices_of_all_Classes, '-' temp ];
                
            end
            legend_of_Starting_and_Ending_Indices_of_all_Classes = legend_of_Starting_and_Ending_Indices_of_all_Classes ( 1, 2 : end );
            
            projected_DataPoints = projected_DataPoints';
%             projected_DataPoints = projected_DataPoints + repmat ( mean_Vertical_Vector, 1, size ( matrix_of_DataPoints, 2 ) );

            for class_Index = 1 : length ( different_Classes )
                labels = ( different_Classes( 1, class_Index )== classLabels_from_DataBank );
                Structure_of_projected_dataPoints.( ['projected_DataPoints_of_Class_' num2str(class_Index) ]) = projected_DataPoints ( :, labels );

            end

    %% Section  3: We do not plot 'Scatter Plot' for 'projected_DataPoints' with more than 3 Dimensions
    size ( projected_DataPoints )
    temp_Projected_DataPoints = projected_DataPoints;
    projected_DataPoints = projected_DataPoints ( 1: 3, : );
        if ( size ( projected_DataPoints, 1 ) > 3 ) 
            
            selected_projected_DataBank_Matrix_for_Output = [ projected_DataPoints(1:200, :); classLabels_from_DataBank ];
            
            % Level 1: Drawing the 'Projection Plot'
                if ( do_you_Want_to_Draw_Raw_and_Projected_DataPoints_in_a_two_or_three_Dimensional_Plot )   &&  ( size ( selected_projected_DataBank_Matrix_for_Output, 1 ) <= 10 )
                    num1 = size ( selected_projected_DataBank_Matrix_for_Output, 1 ) - 1 + size ( selected_Dimensions_for_Draw, 2 );
                    num2 = size ( different_Classes, 2 );
                    colors_for_DataPoints = hsv( max ( num1, num2 ) );
                    colors_for_Lines      = hsv( size ( V, 2 ) );

                    common_Elements_for_Projection_Plot = {    'figure_Hanle',                                         figure,                                                                                    ...
                                                               'selected_Dimensions_for_Draw',                         selected_Dimensions_for_Draw,                                                              ...
                                                               'matrix_of_DataPoints',                                 matrix_of_DataPoints,                                                                      ...
                                                               'projected_DataPoints',                                 selected_projected_DataBank_Matrix_for_Output(1:end-1, :),                                 ...
                                                               'legend_of_Starting_and_Ending_Indices_of_all_Classes', legend_of_Starting_and_Ending_Indices_of_all_Classes,                                      ...
                                                               'colors_for_DataPoints',                                colors_for_DataPoints,                                                                     ...
                                                               'starting_and_Ending_Indices_of_all_Classes',           starting_and_Ending_Indices_of_all_Classes,                                                ...
                                                               'axis_Labels',                                          axis_Labels,                                                                               ...
                                                               'graph_Text_Size',                                      graph_Text_Size,                                                                           ...                                       
                                                           };  
                                                       
                    % Stage 1: 'Pure Data'
                        projection_Data_Paramters = [  {'strategy', 'Drawing_Pure_DataPoints'}, ...
                              common_Elements_for_Projection_Plot,     ...
                             ];
                                                       
                        Projection_Plot (  projection_Data_Paramters{:}  )               
                    
                        
                    % Stage 2: 'Projection Data'
                        projection_Data_Paramters = [  {'strategy', 'Drawing_Projected_DataPoints'}, ...
                              common_Elements_for_Projection_Plot,     ...
                             ];
                                                       
                        Projection_Plot (  projection_Data_Paramters{:}  )               
                    
                end

            return;

        end
        
        
    %% Section  4: Plot            
            if ( do_you_Want_to_Draw_Raw_and_Projected_DataPoints_in_a_two_or_three_Dimensional_Plot )
                num1 = size ( projected_DataPoints, 1 ) + size ( selected_Dimensions_for_Draw, 2 );
                num2 = size ( different_Classes, 2 );
                colors_for_DataPoints = hsv( max ( num1, num2 ) );
                colors_for_Lines      = hsv( size ( V, 2 ) );
                
                if   ( size ( selected_Dimensions_for_Draw, 2 ) <= 3 )
                    
                    figure_1_Name = 'WrittenV1 PCA PostProc, Scatter Plot';
                    fig_1 = figure('Name', figure_1_Name,'NumberTitle','off');

                    figure_2_Name = 'WrittenV1 PCA PostProc, Projection Plot';
                    fig_2 = figure('Name', figure_2_Name,'NumberTitle','off');

                    % 2-D case for 'selected_Dimensions_for_Draw'
                        if   ( size ( selected_Dimensions_for_Draw, 2 ) == 2 )

                            Two_Dimensional_Draw (  fig_1,                                                ...
                                                    fig_2,                                                ...
                                                    matrix_of_DataPoints,                                 ...
                                                    classLabels_from_DataBank,                            ...
                                                    selected_Dimensions_for_Draw,                         ...
                                                    V,                                                    ...
                                                    projected_DataPoints,                                 ...
                                                    different_Classes,                                    ...
                                                    starting_and_Ending_Indices_of_all_Classes,           ...
                                                    legend_of_Starting_and_Ending_Indices_of_all_Classes, ...
                                                    colors_for_DataPoints,                                ...
                                                    colors_for_Lines,                                     ...
                                                    axis_Labels,                                          ...
                                                    graph_Text_Size)
         
                    % 3-D case for 'selected_Dimensions_for_Draw'                                    
                        elseif ( size ( selected_Dimensions_for_Draw, 2 ) == 3 ) 

                              Three_Dimensional_Draw (  fig_1,                                                ...
                                                        fig_2,                                                ...
                                                        matrix_of_DataPoints,                                 ...
                                                        classLabels_from_DataBank,                            ...
                                                        selected_Dimensions_for_Draw,                         ...
                                                        V,                                                    ...
                                                        projected_DataPoints,                                 ...
                                                        different_Classes,                                    ...
                                                        starting_and_Ending_Indices_of_all_Classes,           ...
                                                        legend_of_Starting_and_Ending_Indices_of_all_Classes, ...
                                                        colors_for_DataPoints,                                ...
                                                        colors_for_Lines,                                     ...
                                                        axis_Labels,                                          ...
                                                        graph_Text_Size)
                        end


                        for index  = 1 : 2                            
                            if ( index == 1 )
                                figure ( fig_1 );
                                
                            else
                                figure ( fig_2 );
                                
                            end
                                                    
                            if ( isempty ( general_PlotTitle ) == 0 )
                                part_1  = sprintf ( '%s', general_PlotTitle (1, : ) );
                                part_2  = sprintf ( '%s', general_PlotTitle (2, : ) );
                                part_3  = sprintf ( '%s', general_PlotTitle (3, : ) );

                                Title   = sprintf ('%s\n%s\n%s', part_1, part_2, part_3 );                                
                                set(0,'DefaultTextInterpreter','none');
                                suptitle( Title  );

                            else


                            end   
                        end

                else
                    fprintf ( 'The Plot for Data-Points with more than 3 Selected Dimensions can not be shown ... !!!\n' );

                end



            end
            
            projected_DataPoints = temp_Projected_DataPoints;
            
    %% Section  5: Making the "output" Ready
        % Level 1: Capturing the 'User's' Preffered Dimension
            prompt = {'Selected Dimension(s) for Output projected DataPoints ( Default: full projected Data-Points. ):'};
            dlg_title = 'selected Projection Dimension Indices';
            num_lines = 1;
            defaultans = {'[ 1 2 ]'};
            Options.WindowStyle = 'normal';
            answer = inputdlg(prompt, dlg_title, num_lines, defaultans, Options );

            answer = char (answer );
            selected_Projection_Dimension_Indices_2_Cell    = regexp( answer, '(?<Year>\d{2})', 'match');
            selected_Projection_Dimension_Indices_2         = str2double(selected_Projection_Dimension_Indices_2_Cell);

            for index = 1 : size( selected_Projection_Dimension_Indices_2_Cell , 2)
                starting_index = strfind ( answer, char(selected_Projection_Dimension_Indices_2_Cell ( 1, index )) );
                answer ( starting_index : starting_index - 1 + length ( char ( selected_Projection_Dimension_Indices_2_Cell ( 1, index ) ) ) ) = [];
                
            end
            selected_Projection_Dimension_Indices_1         = str2double(regexp( char(answer), '(?<Year>\d{1})', 'match'));

            selected_Projection_Dimension_Indices = [ selected_Projection_Dimension_Indices_1  selected_Projection_Dimension_Indices_2 ];

        % Level 2: Making the output Ready
            if ( isempty ( selected_Projection_Dimension_Indices ) == 1 )
                selected_Projection_Dimension_Indices = 1 : size ( projected_DataPoints, 1 );

            end

            if ( max ( selected_Projection_Dimension_Indices ) > size ( projected_DataPoints, 1 ) )
                indices = selected_Projection_Dimension_Indices > size ( projected_DataPoints, 1 );
                selected_Projection_Dimension_Indices ( indices ) = [];
                
                fprintf ( 'none of "selected Projection Dimension Indices" can not be bigger than "Row-Number" of "matrix_of_DataPoints" which is Dimension-Number (P = %d).\n', size ( projected_DataPoints, 1 ) )
                fprintf ( 'Then we reduced "Maximum Projection Indices" to "%d" \n', max (selected_Projection_Dimension_Indices) )
                fprintf ( 'in "WrittenV1_PCA_postProc" Function. \n' )
                
            end

            selected_Projection_Dimension_Indices = unique ( selected_Projection_Dimension_Indices, 'stable' );

            selected_projected_DataBank_Matrix_for_Output = projected_DataPoints ( selected_Projection_Dimension_Indices, : );
            selected_projected_DataBank_Matrix_for_Output = [ selected_projected_DataBank_Matrix_for_Output; classLabels_from_DataBank ];
            
            % Changing the Title of Figures
                selected_Projection_Indices_Text = sprintf ( '%d ', selected_Projection_Dimension_Indices );
                selected_Projection_Indices_Text = [ 'Selected Output Projection Dims. for DB by User: ' '[ ' selected_Projection_Indices_Text(1, 1: end-1) ' ]' ];

                new_Figure_1_Name = [ figure_1_Name '--' selected_Projection_Indices_Text ];
                set( fig_1, 'Name', new_Figure_1_Name, 'NumberTitle', 'off')
                
                new_Figure_2_Name = [ figure_2_Name '--' selected_Projection_Indices_Text ];
                set( fig_2, 'Name', new_Figure_2_Name, 'NumberTitle', 'off')

end
