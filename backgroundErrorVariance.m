function[] = backgroundErrorVariance( D, Ye, Yf )
%% Diagnoses background error variance as per Desroziers, 2005
%
% sb2 = backgroundErrorVariance( D, Ye, Yf )
%
% ----- Inputs -----
%
% D: Observations in a single time step (nSite x 1)
%
% Ye: Prior estimates (nSite x nEns)
%
% Yf: Posterior estimates in a single time step (nSite x nEns x 1)

nObs = size(D,1);
sb2 = nansum( (Yf-Ye) .* (D-Ye) / nObs );

