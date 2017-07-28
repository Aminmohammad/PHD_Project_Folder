function output = FaradarsV1_Fuzzy_System ( varargin )

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
temp_Input_DataPoints_Matrix = input_DataPoints_Matrix;
            classLabels_from_DataBank                          = inputSet.Results.classLabels_from_DataBank;
            special_Structure_of_Parameters_for_Classification = inputSet.Results.special_Structure_of_Parameters_for_Classification;
                                    
input_DataPoints_Matrix = input_DataPoints_Matrix (1, : );            
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
            x            = inputs';     % matrix_of_DataPoints        matrix is (nXd)
            y            = targets';    % hosizontal_Vector_of_Labels Vector is (nx1)            


    %% 1: Create Membership Functions
        nA=20;
        A=CreateMembershipFunctions(x,nA,'gaussmf');

        % for 2 inputs
            % nA1=20;
            % A1=CreateMembershipFunctions(x,nA2,'gaussmf');

            % nA2=20;
            % A2=CreateMembershipFunctions(x,nA2,'gaussmf');

        nB=10;
        B=CreateMembershipFunctions(y,nB,'gaussmf');
P=40;
    %% 2: Create Rules Matrix
        S=zeros(nA,nB);
        % for 2 inputs
            % S=zeros(nA1, nA2, nB);

    %% 3: Calculate Rank (score) of Rules
        for ai=1:nA
            amf=A{ai,1};
            aparam=A{ai,2};

            for bi=1:nB
                bmf=B{bi,1};
                bparam=B{bi,2};

                s=zeros(1,P);
                for p=1:P
                    s(p)=feval(amf,x(p),aparam)*feval(bmf,y(p),bparam); % score of each pattern
                end

                S(ai,bi)=max(s);
                % or: S(ai,bi)=sum(s);

            end
        end

    %% 4: Delete Extra Rules
        % in each 'row' (for a specific A), nearest 'S' to 1 is correct
            [~, ind]=max(S,[],2); % [] for comparison

            Rules=[(1:nA)' ind];

            Rules(:,3)=1; % column end-1 of Rules is always 1
            Rules(:,4)=1; % column end of Rules is always 1


    %% 5: Create FIS
        fis=newfis('Lookup Table FIS','mamdani');

        fis=addvar(fis,'input','x',[min(x) max(x)]);
        for ai=1:nA
            fis=addmf(fis,'input',1,['A' num2str(ai)],A{ai,1},A{ai,2});
        end

        fis=addvar(fis,'output','y',[min(y) max(y)]);
        for bi=1:nB
            fis=addmf(fis,'output',1,['B' num2str(bi)],B{bi,1},B{bi,2});
        end

        fis=addrule(fis,Rules);

    %% Test FIS

        % fuzzy(fis);
test_Data = temp_Input_DataPoints_Matrix ( 2, : ) ;

inputs  = test_Data;     % Inputs  matrix is (dxn)
targets = classLabels_from_DataBank;   % Targets Vector is (1xn) 

        % Level 2: Preparation of Input
            xx            = inputs';     % matrix_of_DataPoints        matrix is (nXd)
            yy            = targets';    % hosizontal_Vector_of_Labels Vector is (nx1)            

            
            
        yyhat=evalfis(test_Data,fis);

        ee=yy-yyhat;

        figure;

        subplot(2,2,[1 2]);
        plot(xx,yy,'b');
        hold on;
        plot(xx,yyhat,'r');
        xlabel('x');
        ylabel('y');
        legend('Target Values','Output Values');

        subplot(2,2,3);
        plot(xx,ee);
        xlabel('x');
        ylabel('e');

        subplot(2,2,4);
        histfit(ee,100);
        
        
        output.outputs =  yyhat;


