function[sb2] = backgroundErrorVariance( D, Ye, Yf )
%% Diagnoses background error variance as per Desroziers, 2005
%
% sb2 = backgroundErrorVariance( D, Ye, Yf )
%
% ----- Inputs -----
%
% D: Observations (nSite x nTime)
%
% Ye: Prior estimates (nSite x nEns)
%
% Yf: Posterior estimates (nSite x nEns x nTime)
%
% ----- Outputs -----
%
% sb2: Diagnosed background error variance (nTime x 1)

% Desroziers is for classical (non-ensemble) systems. Use the proxy means
Ye = mean( Ye, 2 );
Yf = mean(Yf, 2);
Yf = permute( Yf, [1 3 2] );

% Get the background error variance in each time step for the sites with
% observations
nObs = sum( ~isnan(D), 1 );
sb2 = nansum( (Yf-Ye) .* (D-Ye) ./ nObs, 1 )';

end