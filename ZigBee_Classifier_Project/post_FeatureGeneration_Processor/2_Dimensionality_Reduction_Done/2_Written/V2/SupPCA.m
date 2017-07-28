function [B,V,U,se2,Sf]=SupPCA(Y,X,r)
% This function fits the SupSVD model:
% X=UV' + E 
% U=YB + F 
% where X is an observed primary data matrix (to be decomposed), U is a latent score
% matrix, V is a loading matrix, E is measurement noise, Y is an observed
% auxiliary supervision matrix, B is a coefficient matrix, and F is a
% random effect matrix.
% It is a generalization of principal component analysis (PCA) or singular
% value decomposition (SVD). It decomposes the primary data matrix X into low-rank
% components, while taking into account potential supervision from any auxiliary
% data Y measured on the same samples.
%
% See more details in 2016 JMVA paper "Supervised singular value decomposition
% and its asymptotic properties" by Gen Li, Dan Yang, Andrew B Nobel and
% Haipeng Shen
%
% Input:
%   Y       n*q (column centered) auxiliary data matrix, rows are samples and columns are variables
%           (must have linearly independent columns to avoid overfitting)
%
%   X       n*p (column centered) primary data matrix, which we want to decompose. 
%           rows are samples (matched with Y) and columns are variables
%
%   r       positive scalar, prespecified rank (r < min(n,p))
%
% Output:
%   B       q*r coefficient matrix of Y on the scores of X, 
%           maybe sparse if gamma=1
%
%   V       p*r loading matrix of X, with orthonormal columns
%
%   U       n*r score matrix of X, conditional expectation of random scores
%
%   se2     scalar, variance of measurement error in the primary data X
%
%   Sf      r*r diagonal covariance matrix, for random effects (see paper)
%
% Note: Essentially, U and V are the most important output for dimension
% reduction purpose as in PCA or SVD. 
%
%
% %%%%%%%%%%%%%%%%%%%%
% Cite: 
% @article{li2015supervised,
%   title={Supervised singular value decomposition and its asymptotic properties},
%   author={Li, Gen and Yang, Dan and Nobel, Andrew B and Shen, Haipeng},
%   journal={Journal of Multivariate Analysis},
%   year={2016},
%   volume={146},
%   pages={7--17}, 
%   publisher={Elsevier}
% }
%
% Contact: Gen Li, PhD
%          Assistant Professor of Biostatistics, Columbia University
%          Email: gl2521@columbia.edu  
%
% CopyRight all reserved
% Last updated: 4/16/2016
% %%%%%%%%%%%%%%%%%%%%%%


[n,p]=size(X);
[n1,q]=size(Y);

% Pre-Check
if (n~=n1)
    error('X does not match Y! exit...');
elseif (r>min(n,p))
    error('Rank is too greedy! exit...');
elseif (rank(Y)~=q)
    error('Columns of Y are linearly dependent! exit...');
elseif max(abs(mean(X,1)))>0.01 || max(abs(mean(Y,1)))>0.01
    error('Columns of X and Y are not centered. exit...');
end;

% SVD start
[U,D,V]=svds(X,r);
U=U*D;
E=X-U*V';
se2=var(E(:));
B=inv(Y'*Y)*Y'*U;
Sf=diag(diag((1/n)*(U-Y*B)'*(U-Y*B)));

temp1=X*V-Y*B; % n*r
temp2=X-Y*B*V'; % n*p
logl=(-n/2)*(log(det(Sf+se2*eye(r)))+(p-r)*log(se2))-...
         (.5/se2)*trace(temp2*temp2')-...
         .5*trace((temp1'*temp1)/(Sf+se2*eye(r)))+...
         (.5/se2)*trace(temp1'*temp1);
rec=[logl];

max_niter=1E5;
convg_thres=1E-6;  
Ldiff=1;
Pdiff=1;
niter=0;

while (niter<=max_niter && (Pdiff>convg_thres))% || Pdiff>convg_thres) )
    % record last iter
    logl_old=logl;
    se2_old=se2;
    Sf_old=Sf;
    V_old=V;
    B_old=B;
    
    % E step
    % some critical values
    Sfinv=inv(Sf);
    weight=inv(eye(r)+se2*Sfinv); % r*r
    cond_Mean=(se2*Y*B*Sfinv + X*V)*weight; % E(U|X), n*r
    cond_Var=Sf*(eye(r)-weight); % cov(U(i)|X), r*r
    cond_quad=n*cond_Var + cond_Mean'*cond_Mean; % E(U'U|X), r*r
    
    % M step
    V=X'*cond_Mean/(cond_quad); % p*r
    se2=(trace(X*(X'-2*V*cond_Mean')) + n*trace(V'*V*cond_Var) + trace(cond_Mean*V'*V*cond_Mean'))/(n*p);
    B=(Y'*Y)\Y'*cond_Mean; % q*r
    Sf=(cond_quad + (Y*B)'*(Y*B)- (Y*B)'*cond_Mean- cond_Mean'*(Y*B) )/n; % r*r
    
    % S step 
    [newV,newSf,~]=svds(V*Sf*V',r);
    Sf=newSf(1:r,1:r);
    B=B*V'*newV(:,1:r);
    V=newV(:,1:r);
    
    % log likelihood
    temp1=X*V-Y*B; % n*r
    temp2=X-Y*B*V'; % n*p
    logl=(-n/2)*(log(det(Sf+se2*eye(r)))+(p-r)*log(se2))-...
         (.5/se2)*trace(temp2*temp2')-...
         .5*trace((temp1'*temp1)/(Sf+se2*eye(r)))+...
         (.5/se2)*trace(temp1'*temp1);
    rec=[rec,logl];
    
    
    % iteration termination
    Ldiff=logl-logl_old; % should be positive
    Pdiff=norm(V-V_old,'fro')^2;
    niter=niter+1;

end;

if niter<max_niter
    disp(['EMS converges at precision ',num2str(convg_thres),' after ',num2str(niter),' iterations.']);
else
    disp(['EMS NOT converge at precision ',num2str(convg_thres),' after ',num2str(max_niter),' iterations!!!']);
end;


% re-order V, and correspondingly B and Sf, U (one simple remedy for the improper order of V)
[~,I]=sort(std(X*V),'descend');
V=V(:,I);
B=B(:,I);
Sf=Sf(I,I);

% correct sign of V for identifiability
% also correct B and Sf
signchange=sign(V(1,:));
V=bsxfun(@times,V,signchange);
B=bsxfun(@times,B,signchange);
Sf=diag(signchange)*Sf*diag(signchange);

% output U
Sfinv=inv(Sf);
weight=inv(eye(r)+se2*Sfinv); % r*r
U=(se2*Y*B*Sfinv + X*V)*weight;

