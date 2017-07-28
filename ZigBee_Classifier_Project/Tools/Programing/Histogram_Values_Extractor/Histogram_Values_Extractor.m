function output = Histogram_Values_Extractor ( input, number_of_Points, title_Sentence, xlabel_Sentence, ylabel_Sentence, selected_Figure_Name )

    %% Section : Management of Input Arguments          
        if ( nargin < 1 ) 
            error (' Number of inputs are less than essential. ');

        end

    %% Section 1: Extraction of Input Parameters
        if ( isvector ( input ) == 0 )            
            error (' Input Should be a Horizontal/Vertical Vector. ');
            
        end
    
    %% Section 2: Handle of Histogram
        figure;
        figure_Handler = histfit ( input, number_of_Points ); 
        set(gcf, 'NumberTitle', 'off', 'Name', selected_Figure_Name)
        title  ( title_Sentence );
        xlabel ( xlabel_Sentence );
        ylabel ( ylabel_Sentence );
        
    %% Section 4: Extracting the Parameters of the 'Histogram' and 'Fitted Curve'
        x_hist      = get ( figure_Handler(1), 'XData' ); 
        y_hist      = get ( figure_Handler(1), 'YData' );
        y_Sum_Value =  sum(y_hist);
        y_hist      = y_hist / y_Sum_Value;
        
        x_dist = get ( figure_Handler(2), 'XData' ); 
        y_dist = get ( figure_Handler(2), 'YData' );
        y_dist = y_dist / y_Sum_Value;
        
        output.x_hist = x_hist;
        output.y_hist = y_hist;
        output.y_Sum  = y_Sum_Value;
        
        output.x_dist = x_dist;
        output.y_dist = y_dist;        
        close ( gcf )


        