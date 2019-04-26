function [x, t, d, cumpcgiters, area, areasoft] = ...
    lsgs(a, g, F, dmin, T, x0, quiet, MAXCUMPCGITERS);

% function [x, t, d, cumpcgiters, area, areasoft] = ...
%    lsgs(a, g, F, dmin, T, x0, quiet, MAXCUMPCGITERS); 
% inputs: required a, g, F, dmin; others optional
% a, g, dmin column vector size n
% F sparse strictly upper triangular matrix size n x n
% see users' guide for details

% LSGS Large-scale Gate Sizing MATLAB Toolbox.
% Copyright 2008 Siddharth Joshi and Stephen Boyd.
% See the file `copyright' (included in the distribution) 
% for full copyright information.

if (nargin < 8) MAXCUMPCGITERS = 500; end
if (nargin < 7) quiet = 1; end 
if (nargin < 6) x0 = []; end
if (nargin < 5) T = []; end
  
if (nargin >= 8 && isempty(MAXCUMPCGITERS)) MAXCUMPCGITERS = 500; end
if (nargin >= 7 && isempty(quiet)) quiet = 1; end 

%Basic input checking
if (~quiet) fprintf('Checking input problem data ...\n'); end
n = size(F,1);
if (~issparse(F))
   fprintf('ERROR: F should be a sparse strictly upper triangular matrix of size n x n.\n'); 
   return;
end

if (size(a,1) ~= n || size(g,1) ~=n || size(dmin, 1) ~= n || size(F,2) ~=n)
    fprintf('ERROR: Incorrect input. Size mismatch.\n'); 
    return;
end

if ( any(a<0) || any(g<0) || any(any(F <0)) )
    fprintf('ERROR: Incorrect input. Negative entry found.\n');
    return;
end

if (nnz(tril(F)) ~= 0)
   fprintf('ERROR: F should be strictly upper triangular.\n'); 
   return;
end

if (isempty(T))
    if (~isempty(x0))
        if (size(x0,1) ~= n)
            fprintf('ERROR: x0 should be column vector of size n.\n');
            return;
        end
        if (any(x0 < 1))
            fprintf('ERROR: x0 is infeasible.\n');
            return;
        end
        
        t0 = zeros(n,1);
        timingasg(F, (((F*x0 + g)./x0)+dmin), t0);
        T = max(t0);
        initialize = 0;
        
    else
        quiet = 0;
        initialize = -1;
    end
else
    initialize = 1;
end
if (~quiet) fprintf('Input checked.\n'); end

%Obtaining required data structures
PO = find(sum(F,2) == 0); 
PI = find(sum(F,1) == 0);

[Fi Fj Fv] = find(F);
m = nnz(F);
A = [sparse(PI, cumsum(ones(length(PI),1)), -1, n, length(PI)) ...
    (sparse(Fi, cumsum(ones(m,1)), 1, n, m) + sparse(Fj, cumsum(ones(m,1)), -1, n, m))];

Ain = A<0;
Atld = A; Atld(PO,:) = [];
Atldsq = Atld.^2;
ntld = size(Atld,1);
Ft = F';

tminarea = zeros(n, 1);
timingasg(F, (sum(F,2)+g+dmin), tminarea);

if(~quiet)
    fprintf('Circuit summary:\n');
    fprintf('Number of gates: %d\n', n);
    fprintf('Number of interconnections: %d\n', m);
    fprintf('Number of primary output gates: %d\n', size(PO,1) );
    fprintf('Number of primary input gates: %d\n', size(PI,2) );
    fprintf('Circuit delay for minimum area: %.3f\n', max(tminarea));
end

lpathtoin = zeros(n,1); lpathtoout = zeros(n,1);
tmin = zeros(n,1); tmax = zeros(n,1);
if(isempty(T)) T = max(tminarea) -0.01; end
cslackandlpath(F, Ft, dmin, T, tmin, tmax, lpathtoin, lpathtoout);
if(~quiet) fprintf('Minimum circuit delay (Tmin): %.3f\n', max(tmin)); end

if(T >= max(tminarea))
    fprintf('WARNING: Requested timing specification greater than equal to circuit delay of minimum area circuit.\n');
    x = ones(n,1); d = (sum(F,2)+g+dmin); t = tminarea;
    cumpcgiters = 0; area = sum(a); areasoft = area;
    return;
elseif (T <= max(tmin))
    fprintf('ERROR: Requested timing specification is infeasible.\n');
    return;
end

if (initialize == 1)
    t0 = zeros(n,1);
    lpath = lpathtoin + lpathtoout;
    cslack = tmax - tmin;
    u0 = cslack./lpath; 
    d0 = u0+dmin;
    timingasg(F, d0, t0);
elseif (initialize == -1)
    return;
end
t0(PO) = T;

[t, u, x, cumpcgiters, areasoft, area] = ...
    lsgssolver(n, a, g, F, Ft, dmin, T, A, PO, Ain, ntld, Atld, Atldsq, t0, quiet, MAXCUMPCGITERS);

d = u + dmin;
cumpcgiters = cumpcgiters'; areasoft = areasoft'; area = area';
