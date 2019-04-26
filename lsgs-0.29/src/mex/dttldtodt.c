/*
LSGS Large-scale Gate Sizing MATLAB Toolbox.
Copyright 2008 Siddharth Joshi and Stephen Boyd. 
See the file `copyright' (included in the distribution) 
for full copyright information.
*/

#include "mex.h"
#include "math.h"

void dttldtodt(mwSize n, double* dttld, double *PO, double *dt)
{
	mwSize i,j=0,k=0;

	for(i=0; i<n; i++) {
		if(i == (int)PO[k]-1){
			dt[i] = 0;
			k++;
		}
		else {
			dt[i] = dttld[j];
			j++;
		}
	}
	
}


void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    mwSize n;
    double *dt, *PO, *dttld;

    dttld   = mxGetPr(prhs[0]);
    PO      = mxGetPr(prhs[1]);
    dt      = mxGetPr(prhs[2]);
    
	n		= mxGetM(prhs[2]);

    dttldtodt(n, dttld, PO, dt);
}
