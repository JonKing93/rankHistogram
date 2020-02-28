function[bins] = rankHistogram( Y, D )
% Computes a rank histogram for proxy estimates
%
% rankHistogram( Ye, D )
% Computes a rank histogram for a model prior.
%
% rankHistogram( Yf, D )
% Computes a rank histogram for a model posterior.
%
% ----- Inputs -----
%
% Ye: Prior model estimates. (nSite x nEns)
%
% Yf: Posterior model estimates (nSite x nEns x nTime)
%
% D: The proxy values (nSite x nTime)
%
% ----- Outputs -----
%
% bins: The number of counts in each histogram bin.

% Preallocate, get sizes
nBins = size(Y,2) + 1;
[nSite, nTime] = size(D);
bins = zeros( nBins, 1 );

% Yf are time dependent, Ye are not
if size(Y,3) > 1
    time = 1:nTime;
else
    time = ones( 1, nTime );
end

% For each site in each time step with an observation...
for s = 1:nSite
    for t = 1:nTime
        if ~isnan( D(s,t) )
            
            % Sort the appropriate Y values. Set Inf as upper bound
            Ysort = [sort( Y(s,:,time(t)) ), Inf];
            
            % Get the rank of the observation
            rank = find( D(s,t) <= Ysort, 1 );
            
            % Check if this rank is one of a set of duplicate values. If so,
            % choose a random rank from the set of duplicates.
            if sum( Ysort==Ysort(rank) ) > 1
                duplicateRanks = find( Ysort == Ysort(rank) );
                k = randsample( numel(duplicateRanks), 1 );
                rank = duplicateRanks( k );
            end
            
            % Add a count to the rank
            bins(rank) = bins(rank)+1;
        end
    end
end

end