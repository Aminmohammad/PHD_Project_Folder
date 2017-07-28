function output = FaradarsV1_NaiveBayesian ( varargin )

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
            
        % Level 2: Naive Bayesian Classifier
            bc = NaiveBayes.fit( inputs, targets );
            outputs = bc.predict( inputs )';         % Outputs

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
            temp_Raw_outputs                           = reformed_Outputs;  
            temp_Rounded_and_Clampd_outputs            = outputs;
            
            output.outputs_Train.raw_Output            = temp_Raw_outputs;
            output.outputs_Train.roundedClamped_Output = temp_Rounded_and_Clampd_outputs;
            
            output.outputs_Test.raw_Output             = temp_Raw_outputs;
            output.outputs_Test.roundedClamped_Output  = temp_Rounded_and_Clampd_outputs;

