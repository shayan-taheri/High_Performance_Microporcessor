/*
LSGS Large-scale Gate Sizing MATLAB Toolbox.
Copyright 2008 Siddharth Joshi and Stephen Boyd. 
See the file `copyright' (included in the distribution) 
for full copyright information.
*/


#include "mex.h"
#include "math.h"

void jacobianut(mwSize n, double *F, mwIndex *Fi, mwIndex *Fj, 
                double *dmin, double *u, double *t, double p, double *J)
{
    mwSize i,j,k,fig;
    double sum, temp;

    for(i=0; i<n; i++) {
        
		j = Fj[i];
		if (Fj[i+1] - Fj[i] == 0) {
			J[i+j] = 1;
		}

		else if (Fj[i+1] - Fj[i] == 1) {
			J[i+j] = -1;
			J[i+j+1] = 1;
		}

		else {
			k = 0;
			sum = 0;
			temp = -pow(u[i], p+1);
			while(Fj[i+1] - Fj[i] - k > 0) {
				fig = Fi[j+k];
				J[i+j+k] = temp*pow(t[i]-t[fig]-dmin[i], -p-1);
				sum += J[i+j+k];
				k++;
			}
			J[i+j+k] = -sum;
        }       
	}    
}


/*
jacobianut(F, dmin, u, t, p2, Ju_t);
input  F, dmin, u, t, p2
output Ju_t
*/
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    mwSize n;
    mwIndex *Fi, *Fj;
    double *F, *dmin, *u, *t, *p2, *Ju_t;

    F       = mxGetPr(prhs[0]);
    dmin    = mxGetPr(prhs[1]);
    u       = mxGetPr(prhs[2]);
    t	    = mxGetPr(prhs[3]);
    p2      = mxGetPr(prhs[4]);
    Ju_t    = mxGetPr(prhs[5]);
    
    Fi		= mxGetIr(prhs[0]);
	Fj		= mxGetJc(prhs[0]);
	n		= mxGetM(prhs[0]);

    jacobianut(n, F, Fi, Fj, dmin, u, t, p2[0], Ju_t);
}
