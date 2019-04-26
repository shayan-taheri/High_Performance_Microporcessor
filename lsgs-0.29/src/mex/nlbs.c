/*
LSGS Large-scale Gate Sizing MATLAB Toolbox.
Copyright 2008 Siddharth Joshi and Stephen Boyd. 
See the file `copyright' (included in the distribution) 
for full copyright information.
*/

#include "mex.h"

#if !defined(max)
#define	max(A, B)	((A) > (B) ? (A) : (B))
#endif
									
void nlbs(mwSize n, double *Ft, mwIndex *Fti, mwIndex *Ftj,
		  double *g, double *u, double *x)
{
	mwSize i,j,k,fog;
	double t;
	
	for(i=n-1; ; i--) {		
		t = g[i];		
		k = 0;
		while(Ftj[i+1] - Ftj[i] - k > 0) {
			j = Ftj[i]+k;
			fog = Fti[j];
			t += Ft[j]*x[fog];
			k++;
			
		}		
		x[i] = max(1, t/u[i]);

		if (i==0) break;

	}
}

/*
nlbs(Ft, g, u, x)
input  Ft, g, u
output x 
*/
void mexFunction( int nlhs, mxArray *plhs[], 
				  int nrhs, const mxArray *prhs[])
{
	mwSize n;
	mwIndex *Fti, *Ftj;
	double *Ft, *g, *u, *x;
	
	Ft		= mxGetPr(prhs[0]);
	g		= mxGetPr(prhs[1]);
	u		= mxGetPr(prhs[2]);
	x		= mxGetPr(prhs[3]);

	Fti		= mxGetIr(prhs[0]);
	Ftj		= mxGetJc(prhs[0]);
	n		= mxGetM(prhs[0]);

	nlbs(n, Ft, Fti, Ftj, g, u, x);
}

