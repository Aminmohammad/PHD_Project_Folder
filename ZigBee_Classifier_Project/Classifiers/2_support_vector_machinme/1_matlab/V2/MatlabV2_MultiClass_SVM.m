function output = MatlabV2_MultiClass_SVM ( varargin )                              

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
            inputSet.addParameter('general_Plot_Title', []); 

            inputSet.parse(varargin{:});

            input_DataPoints_Matrix                            = inputSet.Results.input_DataPoints_Matrix;
            classLabels_from_DataBank                          = inputSet.Results.classLabels_from_DataBank;
            special_Structure_of_Parameters_for_Classification = inputSet.Results.special_Structure_of_Parameters_for_Classification;
            general_Plot_Title                                 = inputSet.Results.general_Plot_Title;

            number_of_DataPoints             = size( input_DataPoints_Matrix, 2 );
            number_of_DataPoints_Dimensions  = size( input_DataPoints_Matrix, 1 );
            number_of_ClassLabels_Dimensions = size( classLabels_from_DataBank, 1 );
                                    
            if        ( isempty( input_DataPoints_Matrix ) == 1 )        
                error ( 'You should Enter the "input_DataPoints_Matrix" for Classification in "MatlabV2 MultiClass SVM".' );

            elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
                error ( 'You should Enter the "classLabels_from_DataBank" for Classification in "MatlabV2 MultiClass SVM".' );

            end              

            
            if ( isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'selected_Dimensions_for_Draw' ) ) == 0 )
                selected_Dimensions_for_Draw                   = special_Structure_of_Parameters_for_Classification.selected_Dimensions_for_Draw;
                
            else
                selected_Dimensions_for_Draw = 1: size ( input_DataPoints_Matrix, 1 );
                                            
            end 

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

            inputs  = normalized_DataPoints';
            targets = normalized_ClassLabels';

       % Level 2: Training the Model     
% clc
% close all
% load fisheriris
% inputs = meas(:,3:4);
% tagerts = species;       

       % Level 2: Training the Model
           t = templateSVM('Standardize',1,'KernelFunction','gaussian');
%            model = fitcecoc(inputs,targets,'Coding','onevsall','Learners',t,...
                %'FitPosterior',1, 'Prior','uniform','Verbose',2);
                
               model = fitcecoc(inputs,targets,'Learners',t, ...
                'Coding','onevsall', 'FitPosterior', 1, 'Prior','uniform','Verbose',2);

       % Level 3: Show the Table of Infos
             %  [label,~,~,Posterior] = resubPredict(Mdl,'Verbose',1);
             %  Mdl.BinaryLoss

             %  idx = randsample(size(inputs,1),10,1);
             %  Mdl.ClassNames
             %  table(tagerts(idx),label(idx),Posterior(idx,:),...
             %  'VariableNames',{'TrueLabel','PredLabel','Posterior'})


       % Level 3: Plotting the Results
            Classification_RegionDevision_Plot (  model,                           ...
                                                  inputs,                          ...
                                                  classLabels_from_DataBank,       ...
                                                  selected_Dimensions_for_Draw     ...
                                                  )
                                   
    %% Section 4: Outputs
        outputs = predict( model, inputs )';        

        % Level 1: transposing the 'outputs', if essential.            
            if ( size ( outputs, 1 ) > size ( outputs, 2 ) )
                outputs = outputs';
                
            end
            
        % Level 2: Reforming the 'outputs' in the Range of 'initial ClassLabels'
            for dimension_Index = 1 : number_of_ClassLabels_Dimensions
                reformed_Outputs ( dimension_Index, : ) = Reform_Fcn ( outputs ( dimension_Index, : ), Minimum_of_ClassLabels_in_all_Dimensions ( dimension_Index ), Maximum_of_ClassLabels_in_all_Dimensions ( dimension_Index ) ); %#ok<*AGROW>
                
            end
            
        % Level 3: Rounding   
            outputs = round ( reformed_Outputs );

        % Level 4: Clamping
            outputs ( outputs > max ( classLabels_from_DataBank ) ) = max ( classLabels_from_DataBank );
            outputs ( outputs < min ( classLabels_from_DataBank ) ) = min ( classLabels_from_DataBank );
         
        % Level 5: Output 
            temp_Raw_outputs                           = reformed_Outputs;  
            temp_Rounded_and_Clampd_outputs            = outputs;
            
            output.outputs_Train.raw_Output            = temp_Raw_outputs;
            output.outputs_Train.roundedClamped_Output = temp_Rounded_and_Clampd_outputs;
            
            output.outputs_Test.raw_Output             = temp_Raw_outputs;
            output.outputs_Test.roundedClamped_Output  = temp_Rounded_and_Clampd_outputs;
                                
CodingMat = model.CodingMatrix
            
end