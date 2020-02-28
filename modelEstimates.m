function[Yf] = modelEstimates( A, F )
% Generates model estimates from a DA posterior.
%
% Ye = modelEstimates( M, F )
% Generates estimates for a model prior
%
% Yf = modelEstimates( A, F )
% Generates estimates for a model posterior.
%
% ----- Inputs -----
%
% M: A model prior (nState x nEns)
%
% A: A model posterior (nState x nEns x nTime)
%
% F: A cell vector of PSM objects.
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

% Get estimates for each site in each time step
for s = 1:nSite
    Apsm = A( F{s}.H, :, : );
    for t = 1:nTime     
        Yf(s,:,t) = F{s}.runForwardModel( Apsm, NaN, NaN );
    end
end

end