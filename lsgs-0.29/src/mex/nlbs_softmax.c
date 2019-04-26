/*
LSGS Large-scale Gate Sizing MATLAB Toolbox.
Copyright 2008 Siddharth Joshi and Stephen Boyd. 
See the file `copyright' (included in the distribution) 
for full copyright information.
*/

#include "mex.h"
#include "math.h"

#if !defined(max)
#define	max(A, B)	((A) > (B) ? (A) : (B))
#endif
									
void nlbs_softmax(mwSize n, double *Ft, mwIndex *Fti, mwIndex *Ftj, 
		  double *g, double p, double *u, double *x, double *umax)
{
	mwSize i,j,k,fog;
	double xtemp;

	for(i=n-1; ; i--) {		
		umax[i] = g[i];		
		k = 0;
		while(Ftj[i+1] - Ftj[i] - k > 0) {
			j = Ftj[i]+k;
			fog = Fti[j];
			umax[i] += Ft[j]*x[fog];
			k++;
            
		}
		/*x[i] = softmax(1, t/u[i] );*/
        xtemp = umax[i]/u[i];
		if( xtemp <= 1) 
			x[i] = pow((pow(xtemp, p ) + 1), 1/p);
		
		else 
			x[i] = xtemp*pow((1 + pow(xtemp, -p)), 1/p);

		if (i==0) break;
	}
}

/*
nlbs_softmax(Ft, g, p1, u, x, umax)
input  Ft, g, p1, u
output x, umax
*/
void mexFunction( int nlhs, mxArray *plhs[], 
				  int nrhs, const mxArray *prhs[])
{
	mwSize n;
	mwIndex *Fti, *Ftj;
	double *Ft, *g, *p1, *u, *x, *umax;
	
	Ft		= mxGetPr(prhs[0]);
	g		= mxGetPr(prhs[1]);
	p1		= mxGetPr(prhs[2]);
	u		= mxGetPr(prhs[3]);
	x		= mxGetPr(prhs[4]);
	umax	= mxGetPr(prhs[5]);

	Fti		= mxGetIr(prhs[0]);
	Ftj		= mxGetJc(prhs[0]);
	n		= mxGetM(prhs[0]);
	
	nlbs_softmax(n, Ft, Fti, Ftj, g, p1[0], u, x, umax);
}

