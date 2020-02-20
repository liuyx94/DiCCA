
OVERVIEW
**************************************************************************************
The DiCCAS function implements the dynamic inner canonical correlation 
analysis(DiCCA) algorithm. DiCCA extracts dynamic latent variables from high 
dimensional time series data with a descending order of predictability.

For details of the DiCCA algorithm, please refer to the following papers.
1. Dynamic-Inner Canonical Correlation and Causality Analysis for High Dimensional Time Series Data
2. Efficient Dynamic Latent Variable Analysis for High Dimensional Time Series Data
3. Dynamic Latent Variable Analytics for Process Operations and Control

For any additional questions, please contact yingxian@usc.edu or sjoeqin@outlook.com.


FUNCTION INPUTS & OUTPUTS
**************************************************************************************
Inputs:
   X - Data matrix. Columns of the matrix are variables. Rows of the matrix are samples
   order - Order of the autoregressive model in DiCCA algorithm
   nlv - Number of dynamic latent variable to be extracted

Outputs:
   J - Correlation coefficients between latent variables and their predictions
   W - Matrix of w vectors of all dynamic latent variables
   Beta - Matrix of AR coefficients of all dynamic latent variables
   P - Matrix of loadings of all dynamic latent variables
   R - Matrix which models the relationship between data matrix and dynamic latent
       variables(T = X*R)
   T - Matrix of scores of all dynamic latent variables
   Tpred - Matrix of predicted scores of all dynamic latent variables

   Note: Each column of the J, W, Beta, P, R, T and Tpred corresponds to one dynamic latent
   variable


EXAMPLE
**************************************************************************************
load('data.mat')     ## Load data
data = zscore(data); ## Standardization
order = 10;          ## Input the autoregression order 
nfactor = 10;         ## Input the number of DLVs to be extracted
[J,W,Beta,P,R,T,Tpred] = DiCCAS(data,order,nfactor); ## Apply DiCCA

Two examples are included in the folder. 
1. example_process: Apply DiCCA to extract dynamic features from industrial chemical process data.
2. example_lorenz: Apply DiCCA to extract dynamic features from simulation data of Lorenz system.

Datasets used in the examples are provided in the folder. 


LICENSE INFORMATION:
**************************************************************************************
The software is made available for academic or non-commercial purposes only. 
The license is for a copy of the program for an unlimited term.Individuals 
requesting a license for commercial use must pay for a commercial license.
    USC Stevens Center for Innovation
    University of Southern California
    1150 S. Olive Street, Suite 2300
    Los Angeles, CA 90115, USA
    ATTN: Accounting

DISCLAIMER.  USC MAKES NO EXPRESS OR IMPLIED WARRANTIES, EITHER IN FACT OR BY
OPERATION OF LAW, BY STATUTE OR OTHERWISE, AND USC SPECIFICALLY AND EXPRESSLY 
DISCLAIMS ANY EXPRESS OR IMPLIED WARRANTY OF MERCHANTABILITY OR FITNESS FOR A 
PARTICULAR PURPOSE, VALIDITY OF THE SOFTWARE OR ANY OTHER INTELLECTUAL PROPERTY 
RIGHTS OR NON-INFRINGEMENT OF THE INTELLECTUAL PROPERTY OR OTHER RIGHTS OF ANY 
THIRD PARTY. SOFTWARE IS MADE AVAILABLE AS-IS.

LIMITATION OF LIABILITY.  TO THE MAXIMUM EXTENT PERMITTED BY LAW, IN NO EVENT 
WILL USC BE LIABLE TO ANY USER OF THIS CODE FOR ANY INCIDENTAL, CONSEQUENTIAL, 
EXEMPLARY OR PUNITIVE DAMAGES OF ANY KIND, LOST GOODWILL, LOST PROFITS, LOST 
BUSINESS AND/OR ANY INDIRECT ECONOMIC DAMAGES WHATSOEVER, REGARDLESS OF WHETHER
SUCH DAMAGES ARISE FROM CLAIMS BASED UPON CONTRACT, NEGLIGENCE, TORT (INCLUDING
STRICT LIABILITY OR OTHER LEGAL THEORY), A BREACH OF ANY WARRANTY OR TERM OF THIS
AGREEMENT, AND REGARDLESS OF WHETHER USC WAS ADVISED OR HAD REASON TO KNOW OF THE
POSSIBILITY OF INCURRING SUCH DAMAGES IN ADVANCE.

For commercial license pricing and annual commercial update and support pricing,
please contact:
    Nikolaus Traitler
    USC Stevens Center for Innovation
    University of Southern California
    1150 S. Olive Street, Suite 2300
    Los Angeles, CA 90115, USA
    Tel: +1 213-821-3550
    Fax: +1 213-821-5001
    Email: traitler@usc.edu
