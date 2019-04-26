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

#if !defined(min)
#define	min(A, B)	((A) < (B) ? (A) : (B))
#endif

void forwardrecursion(mwSize n, double *F, mwIndex *Fi, mwIndex *Fj,
				double *dmin, double *tmin, double *lpathtoin)
{
	mwSize i,j,k,fig;
	for(i=0; i<n; i++) {	
		tmin[i] = 0;
		lpathtoin[i] = 0;
		k=0;
		while(Fj[i+1] - Fj[i] - k > 0) {
			j = Fj[i]+k;
			fig = Fi[j];
			tmin[i] = max(tmin[i], tmin[fig]);
			lpathtoin[i] = max(lpathtoin[i], lpathtoin[fig]);
			k++;
		}
		tmin[i] += dmin[i];
		lpathtoin[i] += 1;
	}
}


void backwardrecursion(mwSize n, double *Ft, mwIndex *Fti, mwIndex *Ftj,
				double *dmin, double T, double *tmax, double *lpathtoout)
{
	mwSize i,j,k,fog;
	for(i=n-1; ; i--) {
		tmax[i] = T;
		lpathtoout[i] = 0;
		k = 0;
		while(Ftj[i+1] - Ftj[i] - k > 0) {
			j = Ftj[i]+k;
			fog = Fti[j];
			tmax[i] = min(tmax[i], tmax[fog]-dmin[fog]);
			lpathtoout[i] = max(lpathtoout[i], lpathtoout[fog]+1);
			k++;			
		}
		if (i==0) break;
	}
}


/*
cslackandlpath(F, Ft, dmin, T, tmin, tmax, lpathtoin, lpathtoout)
input  F, dmin
output tmin, tmax, lpathtoin, lpathtoout
*/
void mexFunction( int nlhs, mxArray *plhs[], 
				  int nrhs, const mxArray *prhs[])
{
	mwSize n;
	mwIndex *Fi, *Fj, *Fti, *Ftj;
	double *F, *Ft, *dmin, *T, *tmin, *tmax, *lpathtoin, *lpathtoout;
	
	F		= mxGetPr(prhs[0]);
	Ft		= mxGetPr(prhs[1]);
	dmin	= mxGetPr(prhs[2]);
	T		= mxGetPr(prhs[3]);
	tmin	= mxGetPr(prhs[4]);
	tmax	= mxGetPr(prhs[5]);
	lpathtoin	= mxGetPr(prhs[6]);
	lpathtoout	= mxGetPr(prhs[7]);

	Fi		= mxGetIr(prhs[0]);
	Fj		= mxGetJc(prhs[0]);
	n		= mxGetM(prhs[0]);
	Fti		= mxGetIr(prhs[1]);
	Ftj		= mxGetJc(prhs[1]);

	forwardrecursion(n, F, Fi, Fj, dmin, tmin, lpathtoin);
	backwardrecursion(n, Ft, Fti, Ftj, dmin, T[0], tmax, lpathtoout);
}
