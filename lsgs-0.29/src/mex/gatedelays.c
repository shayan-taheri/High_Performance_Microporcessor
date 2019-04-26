/*
LSGS Large-scale Gate Sizing MATLAB Toolbox.
Copyright 2008 Siddharth Joshi and Stephen Boyd. 
See the file `copyright' (included in the distribution) 
for full copyright information.
*/

#include "mex.h"

#if !defined(min)
#define	min(A, B)	((A) < (B) ? (A) : (B))
#endif

void gatedelays(mwSize n, double *F, mwIndex *Fi, mwIndex *Fj,
				double *dmin, double *t, double *u)
{
	mwSize i,j,k,fig;
	for(i=0; i<n; i++) {	
		u[i] = t[i]-dmin[i];
		k=0;
		while(Fj[i+1] - Fj[i] - k > 0) {
			j = Fj[i]+k;
			fig = Fi[j];
			u[i] = min(u[i], t[i] - t[fig] - dmin[i]);
			k++;
		}
	}
}


/*
gatedelays(F, dmin, t, u)
input  F, dmin, t
output u
*/
void mexFunction( int nlhs, mxArray *plhs[], 
				  int nrhs, const mxArray *prhs[])
{
	mwSize n;
	mwIndex *Fi, *Fj;
	double *F, *t, *dmin, *u;
	
	F		= mxGetPr(prhs[0]);
	dmin	= mxGetPr(prhs[1]);
	t		= mxGetPr(prhs[2]);
	u		= mxGetPr(prhs[3]);

	Fi		= mxGetIr(prhs[0]);
	Fj		= mxGetJc(prhs[0]);
	n		= mxGetM(prhs[0]);

	gatedelays(n, F, Fi, Fj, dmin, t, u);
}
