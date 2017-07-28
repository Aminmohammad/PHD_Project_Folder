function output = FaradarsV1_Support_Vector_Machine ( varargin )

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
                                    
%             if        ( isempty( input_DataPoints_Matrix ) == 1 )        
%                 error ( 'You should Enter the "input_DataPoints_Matrix" for Classification in "Faradars_V2_NaiveBayesian".' );
% 
%             elseif    ( isempty( classLabels_from_DataBank ) == 1 )        
%                 error ( 'You should Enter the "classLabels_from_DataBank" for Classification in "Faradars_V2_NaiveBayesian".' );
% 
%             elseif    ( isempty( special_Structure_of_Parameters_for_Classification ) == 1 )        
%                 error ( 'You should Enter the "special_Structure_of_Parameters_for_Classification" for Classification in "Faradars_V2_NaiveBayesian".' );
%                 
%             end    
% 
%             if ( isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'number_of_Hidden_Layer_Neurons' ) ) == 0 )
%                 number_of_Hidden_Layer_Neurons   = special_Structure_of_Parameters_for_Classification.number_of_Hidden_Layer_Neurons;
%                 
%             else
%                 number_of_Hidden_Layer_Neurons = 3;
%                 
%             end
%             
%             if ( isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'show_NetTraining_Window' ) ) == 0 )
%                 show_NetTraining_Window          = special_Structure_of_Parameters_for_Classification.show_NetTraining_Window;
%                 
%             else
%                 show_NetTraining_Window = true;
%                 
%             end
%             
%             if ( isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'Saving_Address' ) ) == 0 )
%                 Saving_Address                   = special_Structure_of_Parameters_for_Classification.Saving_Address;
%                 
%             else
%                 error ( 'You should Enter the "Saving_Address" for Classification in "Faradars_V2_NaiveBayesian".' );
%                 
%             end
            
%             if ( isempty ( isfield ( special_Structure_of_Parameters_for_Classification, 'selected_Saving_Extension' ) ) == 0 )
%                 selected_Saving_Extension        = special_Structure_of_Parameters_for_Classification.selected_Saving_Extension;     
%                 
%             else
%                 selected_Saving_Extension = 'jpg';
%                 
%             end
                
            inputs  = input_DataPoints_Matrix;     % Inputs  matrix is (dxn)
            targets = classLabels_from_DataBank;   % Targets Vector is (1xn) 

        % Level 2: Preparation of Input
            X            = inputs';     % matrix_of_DataPoints        matrix is (nXd)
            Y            = targets';    % hosizontal_Vector_of_Labels Vector is (nx1)            


%% Design SVM (Can be just for any number of classes)
% rng(1);
t = templateSVM('Standardize',1);
Mdl = fitcecoc(X,Y);
isLoss = resubLoss(Mdl);
CVMdl = crossval(Mdl);
kfoldsLoss = kfoldLoss(CVMdl);

outputs = predict ( Mdl, X )

output. outputs = outputs;
output. resbLoss = isLoss;
output. crossVale = kfoldsLoss;


