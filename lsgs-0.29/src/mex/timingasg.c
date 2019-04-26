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

void timingasg(mwSize n, double *F, mwIndex *Fi, mwIndex *Fj,
					  double *d, double *t)
{
	mwSize i,j,k,fig;
	for(i=0; i<n; i++) {	
		t[i] = 0;
		k=0;
		while(Fj[i+1] - Fj[i] - k > 0) {
			j = Fj[i]+k;
			fig = Fi[j];
			t[i] = max(t[i], t[fig]);
			k++;
		}
		t[i] += d[i];
	}
}

/*
timingasg(F, d, t) 
input  F, d
output t
*/

void mexFunction( int nlhs, mxArray *plhs[], 
				  int nrhs, const mxArray *prhs[])
{
	mwSize n;
	mwIndex *Fi, *Fj;
	double *F, *Ft, *d, *t;
	
	F		= mxGetPr(prhs[0]);
	d		= mxGetPr(prhs[1]);
	t		= mxGetPr(prhs[2]);

	Fi		= mxGetIr(prhs[0]);
	Fj		= mxGetJc(prhs[0]);
	n		= mxGetM(prhs[0]);

	timingasg(n, F, Fi, Fj, d, t);
}
