function[Yf] = modelEstimates( A, F, sites )
% Generates model estimates from a DA posterior.
%
% Ye = modelEstimates( M, F )
% Generates estimates for a model prior
%
% Yf = modelEstimates( A, F )
% Generates estimates for all proxies a model posterior.
%
% Yf = modelEstimates( A, F, sites )
% Uses a model posterior to generate estimates for the proxies used to
% update each time step.
%
% ----- Inputs -----
%
% M: A model prior (nState x nEns)
%
% A: A model posterior (nState x nEns x nTime)
%
% F: A cell vector of PSM objects.
%
% sites: A logical matrix indicating which sites were used in each time
%        step (nSite x nTime)   (This is an output from the dash kalman filter)
%
% ----- Outputs -----
%
% Ye: Model estimates for a prior. (nSite x nEns)
%
% Yf: Model estimates for a posterior (nSite x nEns x nTime)

% Preallocate
[~, nEns, nTime] = size(A);
nSite = size(F);
Yf = NaN( nSite, nEns, nTime );

% Default sites
if ~exist('sites','var') || isempty(sites)
    sites = true( nSite, nTime );
end

% Get estimates for each site in each time step
for t = 1:nTime
    for s = 1:nSite
        if sites(s,t)
            Apsm = A(F{s}.H, :, t);
            Yf(s,:,t) = F{s}.runForwardModel( Apsm, NaN, NaN );
        end
    end
end

end