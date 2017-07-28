classdef Polynomial
    properties
        Coeffs
    end
    
    properties(Dependent=true)
        Degree
    end
    
    methods
        function obj=Polynomial(c)
            if ~exist('c','var')
                c=0;
            end
            obj.Coeffs=c;
        end
        
        function r=FindRoots(obj)
            r=roots(obj.Coeffs);
        end
        
        function n=get.Degree(obj)
            n=numel(obj.Coeffs)-1;
        end
        
        function Plot(obj,Range,N,varargin)
            if ~exist('Range','var')
                Range=[0 1];
            end
            
            if ~exist('N','var')
                N=100;
            end
            
            xmin=min(Range);
            xmax=max(Range);
            x=linspace(xmin,xmax,N);
            y=polyval(obj.Coeffs,x);
            
            plot(x,y,varargin{:});
        end
        
        function D=Deriv(obj)
            c=obj.Coeffs;
            n=numel(c)-1;
            d=c(1:end-1).*(n:-1:1);
            if isempty(d)
                d=0;
            end
            D=Polynomial(d);
        end
        
        function C=plus(obj,B)
            if ~isa(B,'Polynomial')
                if isnumeric(B)
                    B=Polynomial(B);
                end
            end
            
            nA=obj.Degree;
            nB=B.Degree;
            
            cA=obj.Coeffs;
            cB=B.Coeffs;
            
            if nA<nB
                cA=[zeros(1,nB-nA) cA];
            elseif nB<nA
                cB=[zeros(1,nA-nB) cB];
            end
            
            C=Polynomial(cA+cB);
            
        end
        
        function B=uminus(obj)
            B=Polynomial(-(obj.Coeffs));
        end
       
        function C=minus(obj,B)
            C=plus(obj,-B);
        end
    end

    methods(Static=true)
        function SomeFunction()
            disp('Polynomial is a simple basic function.');
        end
    end
        
        
end

