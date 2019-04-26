/*
LSGS Large-scale Gate Sizing MATLAB Toolbox.
Copyright 2008 Siddharth Joshi and Stephen Boyd. 
See the file `copyright' (included in the distribution) 
for full copyright information.
*/

#include "mex.h"
#include "math.h"

void jacobianux(mwSize n, double *Ft, mwIndex *Fti, mwIndex *Ftj, 
                double *x, double *u, double *umax, double p, double *J)
{
    mwSize i,j,k;
    
    for(i=0; i<n; i++) {	
		
        j = Ftj[i];
		if (x[i] - 1 < 0.0001)
			J[i+j] = -u[i]/(x[i]*p*(x[i] - 1));
		else
			J[i+j] = -u[i]/(x[i]*(1-pow(x[i], -p)));
 
        k=0;
        while(Ftj[i+1] - Ftj[i] - k > 0) {
			j = Ftj[i]+k;
			J[i+j+1] = u[i]*(Ft[j]/umax[i]);  
			k++;
		} 
        
	}    
}


/*
jacobianux(Ft, x, u, umax, p1, Ju_x);
input  x, u, umax, p1
output Ju_x
*/
										
void mexFunction( int nlhs, mxArray *plhs[],
                  int nrhs, const mxArray *prhs[])
{
    mwSize n;
    mwIndex *Fti, *Ftj;
    double *Ft, *x, *u, *umax, *p1, *Ju_x;

    Ft      = mxGetPr(prhs[0]);
    x       = mxGetPr(prhs[1]);
    u       = mxGetPr(prhs[2]);
    umax    = mxGetPr(prhs[3]);
    p1      = mxGetPr(prhs[4]);
    Ju_x    = mxGetPr(prhs[5]);
    
    Fti		= mxGetIr(prhs[0]);
	Ftj		= mxGetJc(prhs[0]);
	n		= mxGetM(prhs[0]);

    jacobianux(n, Ft, Fti, Ftj, x, u, umax, p1[0], Ju_x);

}
