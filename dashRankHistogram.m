function[bins] = dashRankHistogram( M, F, D )
% Computes a rank histogram for proxy estimates
%
% dashRankHistogram( M, F, D )
% Computes a rank histogram for proxy estimates
%
% ----- Inputs -----
%
% M: A model prior (nState x nEns)
%
% F: The PSMs. A cell vector (nSite x 1)
%
% D: The proxy values (nSite x nTime)
%
% ----- Outputs -----
%
% bins: The number of counts in each histogram bin.

% Preallocate the histogram counts
nBins = size(M,2) + 1;
bins = zeros( nBins, 1 );

% Get sizes
[nSite, nTime] = size(D);

% For each site, generate the proxy estimates
for s = 1:nSite
    Mpsm = M( F{s}.H, : );
    Ye = F{s}.runForwardModel( Mpsm, NaN, NaN );
    
    % Sort the ensemble of estimates, set Inf as an upper bound
    Ye = [sort(Ye), Inf];
    
    % In each time step, find the rank of the observation in the sorted
    % ensemble
    for t = 1:nTime
        rank = find( D(s,t) <= Ye, 1 );
        
        % Check if this rank is one of a set of duplicate values. If so,
        % choose a random rank from the set of duplicates.
        if sum( Ye==Ye(rank) ) > 1
            duplicateRanks = find( Ye == Ye(rank) );
            k = randsample( numel(duplicateRanks), 1 );
            rank = duplicateRanks( k );
        end
        
        % Add a count to the rank
        bins(rank) = bins(rank)+1;
    end
end

end