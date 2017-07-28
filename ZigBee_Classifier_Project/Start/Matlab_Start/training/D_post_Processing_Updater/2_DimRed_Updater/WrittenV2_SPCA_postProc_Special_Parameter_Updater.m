function postProc_Parameters_Structure = WrittenV2_SPCA_postProc_Special_Parameter_Updater ( varargin )

    %% Section 1: Extraction of Essential Parameters       
        inputSet = inputParser();
        inputSet.CaseSensitive = false;
        inputSet.KeepUnmatched = true; 
        inputSet.addParameter( 'graph_Text_Size', 15 );  
        inputSet.parse( varargin{:} );

        graph_Text_Size = inputSet.Results.graph_Text_Size;
        
        postProc_Parameters_Structure.graph_Text_Size = graph_Text_Size;

end



    
    