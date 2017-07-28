function postProc_Parameters_Structure = FaradarsV1_OutlierDet_PostProc_Special_Parameter_Updater ( varargin )

    %% Section 1: Extraction of Essential Parameters       
        inputSet = inputParser();
        inputSet.CaseSensitive = false;
        inputSet.KeepUnmatched = true; 
        inputSet.addParameter( 'decision_Alpha', 20 );  
        inputSet.parse( varargin{:} );

        decision_Alpha   = inputSet.Results.decision_Alpha;
        postProc_Parameters_Structure.decision_Alpha   = decision_Alpha;
     
end



    
    