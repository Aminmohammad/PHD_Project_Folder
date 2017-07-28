function Saving_and_Closing_Figs ( saving_Folder_Address, do_You_Want_the_Figs_to_be_Saved )
    figHandles = findobj('Type','figure');
    for figure_Index = 1 : size ( figHandles, 1 )
        curent_Figure_Handle = figHandles ( figure_Index, 1 );
        name_of_Current_Figure = get ( gcf, 'Name' );
        space_Indices          = strfind ( name_of_Current_Figure, ' ' );
        name_of_Current_Figure ( 1, space_Indices )= '_';
        backSlash_Indices          = strfind ( name_of_Current_Figure, '\' );
        name_of_Current_Figure ( 1, backSlash_Indices )= '_';
        frontSlash_Indices          = strfind ( name_of_Current_Figure, '/' );
        name_of_Current_Figure ( 1, frontSlash_Indices )= '_';
        if ( do_You_Want_the_Figs_to_be_Saved == 1 )
            fprintf ( 'You Selected to Save (and just Close) the Figures as Figs Files ... !\n' );                
            savefig ( curent_Figure_Handle, [ saving_Folder_Address '\' sprintf( '%s_%d', name_of_Current_Figure, figure_Index ) '.fig' ] )
            
        else
            fprintf ( 'You Selected not to Save (and just Close) the Figures as Figs Files ... !\n' );                

        end

        close ( curent_Figure_Handle )        
    end

end