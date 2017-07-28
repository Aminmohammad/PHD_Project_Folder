function Classification_RegionDevision_Plot ( model,                           ...
                                              inputs,                          ...
                                              classLabels_from_DataBank,       ...
                                              selected_Dimensions_for_Draw     ...
                                              )
                                          
% Input:
%
%   input_DataPoints_Matrix: 
%                    DataPoints
%                __              __
%                |                |
%                |                |            
%    Dimensions  |                |
%                |_              _|

%   classLabels_from_DataBank:
%                 _              _
%                |_              _|

	%% Section 1: Extraction of Initial Parameters
        for index = 1 : size ( selected_Dimensions_for_Draw, 2 )
            dimension = selected_Dimensions_for_Draw ( 1, index );
             if ( size ( inputs, 1 ) < dimension )                                   
                 selected_Dimensions_for_Draw ( index ) = [];

             end
        end
        
        if size ( inputs, 1 ) > size ( inputs, 2 )
            temp_Inputs = inputs';
            
        else
            temp_Inputs = inputs;
            
        end

	%% Section 2: Plotting the Graph
        % Level 1: calculation of meshgrid
        if (size ( temp_Inputs, 1 ) >= 1)
            xMax = max(inputs);
            xMin = min(inputs);
        
            x1Pts = linspace(xMin(1),xMax(1));
            x2Pts = linspace(xMin(2),xMax(2));
            [x1Grid,x2Grid] = meshgrid(x1Pts,x2Pts);

        % Level 2: calculation of 'PosteriorRegion' 
            [~,~,~,PosteriorRegion] = predict(model,[x1Grid(:),x2Grid(:)]);
                % https://www.mathworks.com/help/stats/compactclassificationecoc.predict.html
            
            figure( 'Name', 'Classification RegionDevision Plot', 'NumberTitle', 'off' );
            
        % Level 3: Drawing the Posterior Probability Regions' Contour            
            Z = PosteriorRegion;
            zmin = floor(min(Z(:)));
            zmax = ceil(max(Z(:)));
            zinc = (zmax - zmin) / 40;
            zlevs = zmin : zinc : zmax;
            [ ~, h ] = contourf(x1Grid,x2Grid,...
                               reshape(  max(PosteriorRegion, [],2), size(x1Grid,1), size(x1Grid,2)  ) , ...
                                'ShowText','on' );
                            
            % set(h,'LineColor','none')
            %                 h = colorbar;
            %                 h.YLabel.String = 'Maximum posterior';
            %                 h.YLabel.FontSize = 15;
            
        % Level 4: Plotting 'First' & 'Second' Dimensions of Input            
            hold on
            
            indices_of_Classes = unique ( classLabels_from_DataBank, 'stable' );

            colors = hsv ( size ( indices_of_Classes, 2 ) );
  
            dimension_1_of_Input = temp_Inputs ( selected_Dimensions_for_Draw ( 1, 1 ), : );
            dimension_2_of_Input = temp_Inputs ( selected_Dimensions_for_Draw ( 1, 2 ), : );
            for class_Index = 1 : size ( indices_of_Classes, 2 )
                X = dimension_1_of_Input ( classLabels_from_DataBank == indices_of_Classes ( 1, class_Index ) );
                Y = dimension_2_of_Input ( classLabels_from_DataBank == indices_of_Classes ( 1, class_Index ) );
                
                gh (1, class_Index) = plot ( X, Y, 'o', 'Color', colors ( class_Index, : ), 'MarkerSize', 12 );
                
            end

            title  ('Scatter Plot of Input Data-Points and Maximum Posterior');
            xlabel ('X (Projected DataPoints (1, :))');
            ylabel ('Y (Projected DataPoints (2, :))');
            axis tight
            legend(gh,'Location','Best')
            hold off
                
            
        else
            fprintf ('Since the Input has just one Dimension, it is not possible to draw the PosteriorRegion Graph!')
            
        end