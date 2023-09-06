%%
%     COURSE: Signal processing and image processing in MATLAB and Python
%    SECTION: Time-domain denoising
%      VIDEO: Code challenge: Denoise these signals!
% Instructor: mikexcohen.com
% Completed by: Stephen Ebaseh-Onofa
%
%%
clc, clearvars
load denoising_codeChallenge.mat

N = length(origSignal);

figure(1), clf,
subplot(3,1,1)
plot(1:N,origSignal,'linew', 2)

subplot(3,1,2)
plot(1:N, cleanedSignal, 'linew', 2)

figure(2)
histogram(origSignal,100)

%% Median filtering

medianFilteredSignal = origSignal;

upp_threshold = 5; % picked visually from the histogram
low_threshold = -5;

thresh_indxs = find(origSignal > upp_threshold | origSignal < low_threshold);

k = 20;
for tp=1:length(thresh_indxs)

   lowbnd = max(1, thresh_indxs(tp)-k);
   uppbnd = min(thresh_indxs(tp)+k, N);

   medianFilteredSignal(thresh_indxs(tp)) = median(origSignal(lowbnd:uppbnd));
end

% plot after median filtering
figure(1)
subplot(3,1,3)
plot(1:N, medianFilteredSignal, 'linew', 2)

%% Gaussian smooth

fwhm = 125;

k = 150;

gtime = -k:k;
gauswin = exp(-(4 * log(2) * gtime.^2) / fwhm^2 );

figure(3)
plot(gtime,gauswin,'ko-','markerfacecolor','w','linew',2)

% apply filter
gauswin = gauswin / sum(gauswin);
gaussianSmoothSignal = medianFilteredSignal;

for i=k+1:N-k-1
    gaussianSmoothSignal(i) = sum(medianFilteredSignal(i-k:i+k).*gauswin);
end

% plot after gaussian smooth
figure(1)
subplot(3,1,3)
hold on
plot(1:N, gaussianSmoothSignal, 'linew', 2)

%% Mean smooth beginning and end 125

meanSmoothSignal = gaussianSmoothSignal;

k_mean = 50;
for i=1:k
    meanSmoothSignal(i) = mean(gaussianSmoothSignal(max(1,i-k_mean):min(i+k_mean,k)));
end

for i=N-k:N
    meanSmoothSignal(i) = mean(gaussianSmoothSignal(max(N-k,i-k_mean):min(i+k_mean,N)));
end

subplot(3,1,3)
hold on
plot(1:N, meanSmoothSignal, 'linew', 2)
