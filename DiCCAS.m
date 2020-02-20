function [J, W, Beta, P, R, T, Tpred] = DiCCAS(X, order, nlv)
% DICCAS:
%   This function extract dynamic latent variables from high dimensional 
%   time series data. The most predictable dynamics are extracted first.
%
% INPUTS:
%   X - Data matrix. Columns of the matrix are variables. Rows of the
%       matrix are samples
%   order - Order of the autoregressive model in DiCCA algorithm
%   nlv - Number of dynamic latent variables
%
% OUTPUTS:
%   J - Correlation coefficients between latent variables and their predictions
%   W - Matrix of w vectors of all dynamic latent variables
%   Beta - Matrix of AR coefficients of all dynamic latent variables
%   P - Matrix of loadings of all dynamic latent variables
%   R - Matrix which models the relationship between data matrix and dynamic latent
%       variables(T = X*R)
%   T - Matrix of scores of all dynamic latent variables
%   Tpred - Predicted scores of all dynamic latent variables
%   Note: Each column of the J, W, Beta, P, R and T and Tpred corresponds to one dynamic latent variable
%
% LICENSE INFORMATION:
%   The software is made available for academic or non-commercial purposes only. 
%   The license is for a copy of the program for an unlimited term. Individuals 
%   requesting a license for commercial use must pay for a commercial license.
%       USC Stevens Center for Innovation
%       University of Southern California
%       1150 S. Olive Street, Suite 2300
%       Los Angeles, CA 90115, USA
%       ATTN: Accounting
%   DISCLAIMER:  
%   USC MAKES NO EXPRESS OR IMPLIED WARRANTIES, EITHER IN FACT OR BY OPERATION 
%   OF LAW, BY STATUTE OR OTHERWISE, AND USC SPECIFICALLY AND EXPRESSLY DISCLAIMS 
%   ANY EXPRESS OR IMPLIED WARRANTY OF MERCHANTABILITY OR FITNESS FOR A PARTICULAR
%   PURPOSE, VALIDITY OF THE SOFTWARE OR ANY OTHER INTELLECTUAL PROPERTY RIGHTS OR
%   NON-INFRINGEMENT OF THE INTELLECTUAL PROPERTY OR OTHER RIGHTS OF ANY THIRD PARTY.
%   SOFTWARE IS MADE AVAILABLE AS-IS.
%   LIMITATION OF LIABILITY:  
%   TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT WILL USC BE LIABLE TO ANY 
%   USER OF THIS CODE FOR ANY INCIDENTAL, CONSEQUENTIAL, EXEMPLARY OR PUNITIVE DAMAGES
%   OF ANY KIND, LOST GOODWILL, LOST PROFITS, LOST BUSINESS AND/OR ANY INDIRECT ECONOMIC
%   DAMAGES WHATSOEVER, REGARDLESS OF WHETHER SUCH DAMAGES ARISE FROM CLAIMS BASED UPON
%   CONTRACT, NEGLIGENCE, TORT (INCLUDING STRICT LIABILITY OR OTHER LEGAL THEORY), 
%   A BREACH OF ANY WARRANTY OR TERM OF THIS AGREEMENT, AND REGARDLESS OF WHETHER USC
%   WAS ADVISED OR HAD REASON TO KNOW OF THE POSSIBILITY OF INCURRING SUCH DAMAGES IN ADVANCE.
%   For commercial license pricing and annual commercial update and support pricing, please contact:
%   Nikolaus Traitler
%   USC Stevens Center for Innovation
%   University of Southern California
%   1150 S. Olive Street, Suite 2300
%   Los Angeles, CA 90115, USA
%   Tel: +1 213-821-3550
%   Fax: +1 213-821-5001
%   Email: traitler@usc.edu

[Ns, nv] = size(X);
T = zeros(Ns,nlv);
Tpred = zeros(Ns-order,nlv);
W = zeros(nv,nlv);
P = W;
Beta = zeros(order,nlv);
J = zeros(1,nlv);
for k = 1:nlv
    beta = zeros(order,1);
    beta(1,1) = 1;
    jold = 0;
    eps = 1;
    [~,Ds,Vs] = svd(X(order+1:end,:)'*X(order+1:end,:));
    nr = rank(Ds);
    Vs = Vs(:,1:nr);
    invDs = Ds(1:nr,1:nr)^(-0.5);
    U = X*Vs*invDs;
    Us = U(order+1:end,:);
    Ubig = zeros(Ns-order,order*nr);
    for i = 1:order
        Ubig(:,(i-1)*nr+1:i*nr) = U(order+1-i:end-i,:);
    end
    while eps > 0.00001
        Utild = Us - Ubig*kron(beta,eye(nr));
        [wu,~] = svds(Utild'*Utild,1,'sm');
        t = U*wu;
        ts = t(order+1:end);
        Ts = zeros(Ns-order,order);
        for i = 1:order
            Ts(:,i) = t(order+1-i:end-i);
        end
        beta = (Ts'*Ts)\(Ts'*ts);
        tpred = Ts*beta;
        j = corr(ts,tpred);
        eps = j-jold;
        jold = j;
    end
    w = Vs*invDs*wu;
    p = (X(order+1:end,:)'*ts)/(ts'*ts);
    X = X-t*p';
    T(:,k) = t;
    Tpred(:,k) = tpred;
    W(:,k) = w;
    P(:,k) = p;
    Beta(:,k) = beta;
    J(:,k) = j;
end
R = W/(P'*W);
end
