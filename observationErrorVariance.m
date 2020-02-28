function[so2] = observationErrorVariance( D, Ye, Yf )
%% Diagnoses observation error variance as per Desroziers, 2005
%
% so2 = observationErrorVariance( D, Ye, Yf )
%
% % ----- Inputs -----
%
% D: Observations (nSite x nTime)
%
% Ye: Prior estimates (nSite x nEns)
%
% Yf: Posterior estimates (nSite x nEns x nTime)
%
% ----- Outputs -----
%
% so2: Diagnosed observation error variance

% Desroziers is for classical (non-ensemble) systems. Use the proxy means
Ye = mean( Ye, 2 );
Yf = squeeze( mean(Yf, 2) );

% Do the calculation in each time step for each observation
nObs = sum( ~isnan(D), 1 );
so2 = nansum( (D-Yf) .* (D-Ye) ./ nObs, 1)';

end