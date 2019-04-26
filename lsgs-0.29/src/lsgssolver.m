function [t uhard xhard cumpcgiters area areahard] = ...
    lsgssolver(n, a, g, F, Ft, dmin, T, A, PO, Ain, ntld, Atld, Atldsq, t0, quiet,  MAXCUMPCGITERS)

% lsgssolver called via lsgs
% type help lsgs or see users' guide 

% LSGS Large-scale Gate Sizing MATLAB Toolbox.
% Copyright 2008 Siddharth Joshi and Stephen Boyd.
% See the file `copyright' (included in the distribution) 
% for full copyright information.


% smooth apporximation parameters
SMAXWT =  4;  %soft-max weight
SMINWT = 50; %soft-min weight

% backtracking linesearch parameters
ALPHA     = 0.01;     %(0,0.5]
BETA      = 0.5;      %(0,1)
MAXLSITER = 25; lsiter=0;

MAXITERS = 500;
MAXPCGITERS = 2;
TOLPCG = 1e-4;

t= t0;
x = zeros(n,1); u = zeros(n,1);
dttld = zeros(ntld,1);
umax = zeros(n,1); dt = zeros(n,1);
xp = zeros(n,1); up = zeros(n,1);
xhard = zeros(n,1); uhard = zeros(n,1);
Ju_x = 2*Ft + spdiags(-10*ones(n,1), 0, n, n);
Ju_t = 2*F + spdiags(-10*ones(n,1), 0, n, n);

gatedelays_softmin(F, dmin, SMINWT, t, u);
nlbs_softmax(Ft, g, SMAXWT, u, x, umax);

area = []; areahard = []; cumpcgiters = []; sumpcgiters = 0;
if(~quiet) fprintf('  # \t Area(soft) \t  Area \t   CumPCGiters\n'); end
for i=1:MAXITERS
    if ( any(-A'*t - Ain'*dmin < 0) )
        fprintf('ERROR: Delay below dmin\n');
        keyboard;
    end

    f = log(a'*x);
    gradf_x = (a/(a'*x));
    jacobianux(Ft, x, u, umax, SMAXWT, Ju_x);
    gradf_u = Ju_x \ gradf_x;
    jacobianut(F, dmin, u, t, SMINWT, Ju_t);
    gradf_t = Ju_t * gradf_u;
    gradf_ttld = gradf_t;
    gradf_t(PO) = 0;
    gradf_ttld(PO) = [];

    delay = -A'*t - Ain'*dmin;
    H_beta = (Ain'*(2*a.*umax))./(delay.^3);

    Hfn = @(H_w) Atld*((Atld'*H_w).*H_beta);
    Mfn = @(H_w) H_w./(Atldsq*(H_beta));

    [dttld,flag,relres,pcgiter,resvec] = pcg(Hfn,-gradf_ttld, TOLPCG, MAXPCGITERS,Mfn,[],dttld);
    if (gradf_ttld'*dttld) < 0

        dttldtodt(dttld, PO, dt);
        ddelay = -A'*dt;

        % Backtracking
        negindex = find(ddelay < 0);
        if (any(negindex))
            s =  0.9*min([-(delay(negindex))./ddelay(negindex)]) ;
		else
			s = 1;
		end
		
        if lsiter > 2
            s = s*(BETA^(lsiter-2));
        end

        for lsiter  = max(lsiter-2,0):MAXLSITER
            tp    = t  + s*dt;
            gatedelays_softmin(F, dmin, SMINWT, tp, up);
            nlbs_softmax(Ft, g, SMAXWT, up, xp, umax);
            fp = log(a'*xp);
            if ( fp - f < ALPHA*s*(gradf_t'*dt)) break; end
            s = BETA*s;
        end
		
        if(lsiter < MAXLSITER)
            t = tp; u = up; x = xp;
            MAXPCGITERS = 2;
            gatedelays(F, dmin, t, uhard);
            nlbs(Ft, g, uhard, xhard);
        end

    else
        %if(~quiet) fprintf('RESET at cumulative PCG iteration %d  (%e) \n', sumpcgiters, gradf_ttld'*dttld); end
        dttld(:) = 0;
        lsiter = 0;
        MAXPCGITERS = 4;
    end

    if (i>2)
        if 0.05*( area(i-2) - area(i-1) ) > area(i-1) - a'*x
%             if(~quiet)
%                 fprintf('PRE-RESET at cumulative PCG iteration %d. Decrement previous: %.5e current: %.5e\n', ...
%                     sumpcgiters, area(i-2) - area(i-1), area(i-1) - a'*x);
%             end
            dttld(:) = 0;
            lsiter = 0;
            MAXPCGITERS = 4;
        end
    end

    area(i) = a'*x; areahard(i) = a'*xhard;
    
    if flag == 0
        sumpcgiters = pcgiter+ sumpcgiters;
    else
        sumpcgiters = MAXPCGITERS+sumpcgiters;
    end
    cumpcgiters(i) = sumpcgiters;
    
    if(~quiet) fprintf('%3d %15.3e %15.3e %10d\n', i, area(i), areahard(i), sumpcgiters); end
    
    if (sumpcgiters >= MAXCUMPCGITERS) break; end   
    
end

