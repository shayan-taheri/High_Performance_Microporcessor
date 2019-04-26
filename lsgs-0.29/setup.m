function setup()
%setup: sets up the lsgs toolbox 
%   - compiles C file in ./src/mex and puts the MEX files ./lib
%   - adds $PWD/src, $PWD/lib to MATLAB path.

% lsgs Large-scale Gate Sizing MATLAB Toolbox.
% Copyright 2008 Siddharth Joshi and Stephen Boyd.
% See the file `copyright' (included in the distribution) 
% for full copyright information.

fprintf('lsgs version 0.29\n');
fprintf('\nSetup...\n');

fprintf('Compiling C files in ./src/mex ...\n');

cfiles = dir( './src/mex/*.c' );
cfiles = { cfiles.name };
arch = mexext;
mexopts = { ' -O' };
if strcmp( arch(end-1:end), '64' )
	mexopts{end+1} = ' -largeArrayDims';
end

mexopts{end+1} = ' -outdir ./lib';

mexerr = 1;
for k = 1 : length( cfiles )
	str = cfiles{k}; str = [' ./src/mex/' str];
    try
		fprintf( 'mex %s\n', [mexopts{:} str] );
		eval(['mex' mexopts{:} str]);
    catch
        mexerr = 0;
    end
end
if (~mexerr),
	fprintf('ERROR: MEX files could not be generated.\n' );
    fprintf('Please check is the MEX has been setup properly.\n\n');
    return;
else
    fprintf('C files compiled. MEX file located in ./lib.\n');
end

DD=pwd;
addpath([DD '/lib']);
addpath([DD '/src']);
fprintf('Added $PWD/src and $PWD/lib to path.\n');
fprintf('Setup completed.\n');

fprintf('\nTo test lsgs run the scripts in ./examples directory.\n');    
