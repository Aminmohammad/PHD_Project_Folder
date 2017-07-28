function previously_Saved_Figs_Loader ( varargin )

    %% Section  1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive=false;
            inputSet.addParameter( 'address_of_Selected_previosly_Saved_Output_Folder', []);    

            inputSet.parse(varargin{:});

            address_of_Selected_previosly_Saved_Output_Folder                      = inputSet.Results.address_of_Selected_previosly_Saved_Output_Folder;

            if        ( isempty( address_of_Selected_previosly_Saved_Output_Folder ) == 1 )        
                error ( 'You should Enter the "Address of Selected previosly Saved Output Folder" for "Loading".' );

            end              
            
        % loading the Contents of a Folder
            content_of_Selected_previos_Output_Folder = dir ( address_of_Selected_previosly_Saved_Output_Folder );

            for index = 3 : size ( content_of_Selected_previos_Output_Folder, 1 )
                current_File_Name = content_of_Selected_previos_Output_Folder ( index, 1 ).name;

                if      ( isempty ( strfind ( current_File_Name, '.fig' ) ) == 0 )
                    openfig ( [ address_of_Selected_previosly_Saved_Output_Folder '\' current_File_Name ] );   % Loading Fiigures

                elseif  ( isempty ( strfind ( current_File_Name, '.jpg' ) ) == 0 )  || ...
                        ( isempty ( strfind ( current_File_Name, '.jpeg' ) ) == 0 ) || ...
                        ( isempty ( strfind ( current_File_Name, '.png' ) ) == 0 )  || ...
                        ( isempty ( strfind ( current_File_Name, '.tiff' ) ) == 0 ) 
                    
                    temp = imread ( [ address_of_Selected_previosly_Saved_Output_Folder '\' current_File_Name ] );
                    imshow ( temp );
                end

            end


end
