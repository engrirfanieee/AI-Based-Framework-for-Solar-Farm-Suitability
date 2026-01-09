% AI-Based Solar Site Suitability Model (Synthetic Data + 10 Figures)
% Author: [Your Name] - For Nature Energy-style Research

clc; clear; close all;

rows = 100;
cols = 100;

%% 1. Generate Synthetic Layers
solarIrradiance = 1000 * rand(rows, cols);         % [W/m²]
slope = 45 * rand(rows, cols);                     % [degrees]
ndvi = 2 * rand(rows, cols) - 1;                   % NDVI [-1 to 1]
distanceToGrid = 50 * rand(rows, cols);            % [km]
landUse = randi([1 3], rows, cols);                % 1=agri, 2=urban, 3=barren

%% 2. Ground Truth Label (Fake Suitability)
label = (solarIrradiance > 800) & ...
        (slope < 10) & ...
        (ndvi > 0.2) & ...
        (distanceToGrid < 10) & ...
        (landUse ~= 2);  % Urban unsuitable

label = double(label);

%% 3. Flatten Data for ML Model
X = [solarIrradiance(:), slope(:), ndvi(:), distanceToGrid(:), landUse(:)];
Y = label(:);

%% 4. Train-Test Split
cv = cvpartition(Y, 'HoldOut', 0.3);
Xtrain = X(training(cv), :); Ytrain = Y(training(cv));
Xtest = X(test(cv), :); Ytest = Y(test(cv));

%% 5. Train Random Forest Model
model = fitcensemble(Xtrain, Ytrain, 'Method', 'Bag');
Ypred = predict(model, Xtest);

% Predict on full dataset
Yfull = predict(model, X);
suitabilityMap = reshape(Yfull, rows, cols);

% Feature importance
imp = predictorImportance(model);

%% -----------------------------
% 6. Generate 10 Figures
% -----------------------------

% --- FIGURE 1: Model Workflow Diagram (Schematic Only Placeholder) ---
figure;
annotation('textbox', [0.15 0.7 0.7 0.2], 'String', ...
    'Workflow: Synthetic Layers → Ground Truth → ML Training → Prediction → Suitability Map', ...
    'FontSize', 12, 'EdgeColor', 'none', 'HorizontalAlignment', 'center');
title('Fig. 1: Model Workflow Overview');

% --- FIGURE 2 to 6: Synthetic Input Layers ---
figure;
subplot(2,3,1); imagesc(solarIrradiance); title('Fig. 2: Solar Irradiance (W/m²)'); colorbar;
subplot(2,3,2); imagesc(slope); title('Fig. 3: Slope (degrees)'); colorbar;
subplot(2,3,3); imagesc(ndvi); title('Fig. 4: NDVI'); colorbar;
subplot(2,3,4); imagesc(distanceToGrid); title('Fig. 5: Distance to Grid (km)'); colorbar;
subplot(2,3,5); imagesc(landUse); title('Fig. 6: Land Use (1=Agri, 2=Urban, 3=Barren)'); colorbar;

% --- FIGURE 7: Ground Truth Suitability ---
figure;
imagesc(reshape(Y, rows, cols));
title('Fig. 7: Ground Truth Suitability (0=No, 1=Yes)');
colormap(gray); colorbar;

% --- FIGURE 8: Predicted Suitability Map ---
figure;
imagesc(suitabilityMap);
title('Fig. 8: Predicted Suitability Map');
colormap([1 0 0; 0 1 0]); % Red=Unsuitable, Green=Suitable
colorbar;

% --- FIGURE 9: Confusion Matrix ---
figure;
confusionchart(Ytest, Ypred);
title('Fig. 9: Confusion Matrix - Model Performance');

% --- FIGURE 10: Feature Importance ---
figure;
bar(imp);
xticklabels({'Irradiance','Slope','NDVI','Dist2Grid','LandUse'});
ylabel('Importance Score');
title('Fig. 10: Feature Importance (Random Forest)');
grid on;
