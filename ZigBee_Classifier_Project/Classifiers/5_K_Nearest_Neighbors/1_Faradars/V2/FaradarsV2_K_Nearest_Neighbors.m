function output = FaradarsV2_K_Nearest_Neighbors ( varargin )

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

    %% Section 1: Extraction of Essential Parameters
        % Level 1: Extraction of Input
            inputSet = inputParser();
            inputSet.CaseSensitive = false;
            inputSet.KeepUnmatched = true;
            inputSet.addParameter('input_DataPoints_Matrix', []);    
            inputSet.addParameter('classLabels_from_DataBank', []);
            inputSet.addParameter('special_Structure_of_Parameters_for_Classification', []); 

            inputSet.parse(varargin{:});

            input_DataPoints_Matrix                            = inputSet.Results.input_DataPoints_Matrix;
            classLabels_from_DataBank                          = inputSet.Results.classLabels_from_DataBank;
            special_Structure_of_Parameters_for_Classification = inputSet.Results.special_Structure_of_Parameters_for_Classification;

            number_of_DataPoints             = size( input_DataPoints_Matrix, 2 );
            number_of_DataPoints_Dimensions  = size( input_DataPoints_Matrix, 1 );
            number_of_ClassLabels_Dimensions = size( classLabels_from_DataBank, 1 );
                
                
    %% Section 2: Tarining the Model
        % Level 1: Normalization
            Minimum_of_Datapoints_in_all_Dimensions  = min ( input_DataPoints_Matrix' ); %#ok<*UDIM>
            Maximum_of_Datapoints_in_all_Dimensions  = max ( input_DataPoints_Matrix' );

            Minimum_of_ClassLabels_in_all_Dimensions = min ( classLabels_from_DataBank' );
            Maximum_of_ClassLabels_in_all_Dimensions = max ( classLabels_from_DataBank' );

            for dimension_Index = 1 : number_of_DataPoints_Dimensions
                normalized_DataPoints ( dimension_Index, : ) = Normalize_Fcn ( input_DataPoints_Matrix ( dimension_Index, : ), Minimum_of_Datapoints_in_all_Dimensions ( dimension_Index ), Maximum_of_Datapoints_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
            end

            for dimension_Index = 1 : number_of_ClassLabels_Dimensions
                normalized_ClassLabels ( dimension_Index, : ) = Normalize_Fcn ( classLabels_from_DataBank ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) );
            end

            inputs  = normalized_DataPoints'; % Inputs  matrix is (dxn)
            targets = normalized_ClassLabels'; % Targets Vector is (1xn)
            
    %% Section 3: Training the Model 
        kmax=40;

        knnc=cell(kmax,1);
        cvm=cell(kmax,1);
        ResubLoss=zeros(kmax,1);
        KFoldLoss=zeros(kmax,1);

        for k=1:kmax
            knnc{k}=ClassificationKNN.fit(matrix_of_DataPoints,vertical_Vector_of_Labels,'NumNeighbors',k);
            cvm{k}=crossval(knnc{k});
            ResubLoss(k)=resubLoss(knnc{k});
            KFoldLoss(k)=kfoldLoss(cvm{k});
        end

    %% Section 4: Outputs
        % Level 1: Reforming the 'outputs' in the Range of 'initial ClassLabels'
            for dimension_Index = 1 : number_of_ClassLabels_Dimensions
                reformed_Outputs ( dimension_Index, : ) = Reform_Fcn ( outputs ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
                
            end
            
         % Level 2: Rounding   
            outputs = round ( reformed_Outputs );

         % Level 3: Clamping
            outputs ( outputs > max ( classLabels_from_DataBank ) ) = max ( classLabels_from_DataBank );
            outputs ( outputs < min ( classLabels_from_DataBank ) ) = min ( classLabels_from_DataBank );
         
         % Level 4: Output
            temp_outputs            = outputs;
            output.outputs_Train    = temp_outputs;
            output.outputs_Test     = temp_outputs;


end



