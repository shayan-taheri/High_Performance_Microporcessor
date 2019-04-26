/*
LSGS Large-scale Gate Sizing MATLAB Toolbox.
Copyright 2008 Siddharth Joshi and Stephen Boyd. 
See the file `copyright' (included in the distribution) 
for full copyright information.
*/

#include "mex.h"
#include "math.h"

#if !defined(min)
#define	min(A, B)	((A) < (B) ? (A) : (B))
#endif

void gatedelays_softmin(mwSize n, double *F, mwIndex *Fi, mwIndex *Fj,
				double *dmin, double p, double *t, double *u)
{
	mwSize i,j,k,fig;
    double minui;

	for(i=0; i<n; i++) {
        k=0;
		minui = t[i]-dmin[i];		
		while(Fj[i+1] - Fj[i] - k > 0) {
			j = Fj[i]+k;
			fig = Fi[j];
            minui = min(t[i] - t[fig] - dmin[i], minui);
			k++;
		}
        
        if(k<=1)
            u[i]=minui;
        
        else{
            u[i]=0; k = 0;
            while(Fj[i+1] - Fj[i] - k > 0) {
                j = Fj[i]+k;
                fig = Fi[j];
                u[i] += pow(minui/(t[i] - t[fig] - dmin[i]), p);
                k++;
            }
            u[i]=minui*pow(u[i], (-1/p));
        }        
	}
}


/*
gatedelays_softmin(F, dmin, p2, t, u)
input  F, dmin, p2, t
output u
*/
void mexFunction( int nlhs, mxArray *plhs[], 
				  int nrhs, const mxArray *prhs[])
{
	mwSize n;
	mwIndex *Fi, *Fj;
	double *F, *t, *p2, *dmin, *u;
	
	F		= mxGetPr(prhs[0]);
	dmin	= mxGetPr(prhs[1]);
    p2      = mxGetPr(prhs[2]);
    t	    = mxGetPr(prhs[3]);
	u		= mxGetPr(prhs[4]);

	Fi		= mxGetIr(prhs[0]);
	Fj		= mxGetJc(prhs[0]);
	n		= mxGetM(prhs[0]);

	gatedelays_softmin(n, F, Fi, Fj, dmin, p2[0], t, u);
}
