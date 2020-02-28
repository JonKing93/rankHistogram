% Demo for suggested use.

% Observations and observation error (I'm assuming these already exist)
D;
R;

% Get the prior and posterior estimates
Ye = modelEstimates( M, F );
Yf = modelEstimates( A, F );

% Compute metrics
histBincounts = rankHistogram( Ye, D );
sb2 = backgroundErrorVariance( D, Ye, Yf );
so2 = observationErrorVariance( D, Ye, Yf );
Eb = 

% Plot rank histogram
figure
plot( histBincounts );
title('Rank Histogram');

% Plot diagnosed error variances
figure
time = 1:nTime;
plot( time, sb2 );
hold on
plot( time, so2 );
title('Diagnosed error variance');
legend('Background','Observation');