% Demo for suggested use.

% Get the prior and posterior estimates
Ye = modelEstimates( M, F );
Yf = modelEstimates( A, F );

% Observations, observation error variance, background error variance
% (I'm assuming R and D exist)
D;   % (nSite x nTime)
R;   % (nSite x nTime)
Yvar = var( Ye, [], 2 );

% Compute metrics for one site
s = 1;
histBincounts = rankHistogram( Ye(s,:), D(s,:) );
sb2 = backgroundErrorVariance( D(s,:), Ye(s,:), Yf(s,:,:) );
so2 = observationErrorVariance( D(s,:), Ye(s,:), Yf(s,:,:) );
Rsite = R(s,:);
Yvar_site = Yvar(s) * ones(size(Rsite));

% Plot rank histogram
figure
plot( histBincounts );
title('Rank Histogram');

% Compare error variances
figure
time = 1:nTime;
plot( time, sb2, 'b' );
hold on
plot( time, Yvar_site, 'b:' );
plot( time, so2, 'k' );
plot( time, Rsite, 'k:' );
legend('Diagnosed background error','Used background error','Diagnosed observation error', 'Used observation error');
title('Error variance comparison');