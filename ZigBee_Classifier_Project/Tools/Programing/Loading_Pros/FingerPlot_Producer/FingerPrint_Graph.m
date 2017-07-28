function FingerPrint_Graph(fingerprint, indices_of_Seperations_in_X_for_XTickLabels, indices_of_Seperations_in_X_for_Veritcal_Lines, XLabel, YLabel, indices_of_Seperations_in_Y, indices_of_Accumulation_in_Y, general_PlotTitle, special_PlotTitle )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here         
    
    k = figure( 'Name', 'FRDNA Plot', 'NumberTitle', 'off' );

    pcolor(fingerprint);
    shading interp
    colorbar
    colormap(jet)
    set(gca,'XTick',  indices_of_Seperations_in_X_for_XTickLabels )
    set(gca,'XTickLabel', XLabel)
    
    set(gca,'YTick',  1: size ( fingerprint, 1 ))
    set(gca,'YTickLabel', YLabel, 'FontSize',15)
    
    hold on
    
    % Horizonta Reference Lines
        for index = 1 : size ( indices_of_Seperations_in_Y, 1 )
            hline = refline([0 indices_of_Seperations_in_Y( index, 1 )]);
            hline.Color = 'k';
            set( hline, 'LineStyle', ':' )
            set( hline, 'LineWidth',  2 )
        end

        for index = 1 : size ( indices_of_Accumulation_in_Y, 1 )
            hline = refline([0 indices_of_Accumulation_in_Y( index, 1 )]);
            hline.Color = 'g';
            set( hline, 'LineStyle', ':' )
            set( hline, 'LineWidth',  1 )
        end

        for index = 1 : size ( indices_of_Seperations_in_X_for_Veritcal_Lines, 2 ) 
            x_Coordinate = [ indices_of_Seperations_in_X_for_Veritcal_Lines( 1, index ) indices_of_Seperations_in_X_for_Veritcal_Lines( 1, index )];
            y_Coordinate = [ 1, size( fingerprint, 1 )];
            vline = plot ( x_Coordinate, y_Coordinate );
            vline.Color = 'k';
            set( vline, 'LineStyle', ':' )
            set( vline, 'LineWidth',  2 )
        end
        
        if ( isempty ( general_PlotTitle ) == 0 )
            part_1     = sprintf ( '%s', general_PlotTitle (1, : ) );
            part_2     = sprintf ( '%s', general_PlotTitle (2, : ) );
            part_3     = sprintf ( '%s', general_PlotTitle (3, : ) );
            part_4     = [ '(' special_PlotTitle ')' ];
            
            set(0,'DefaultTextInterpreter','none');
            Title   = sprintf ('%s\n%s\n%s\n%s', part_1, part_2, part_3, part_4 );
            suptitle( Title );
            set(0,'DefaultTextInterpreter','tex');

        end
        
    % Setting the all current Figures Invisible              
        set (gcf, 'Visible', 'off')

end

