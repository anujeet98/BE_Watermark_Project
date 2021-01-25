function [approximation]=mypca(ip)
    % ip = input image
    % approximation is image after PCA 
    img = im2double(ip);
    img = rgb2gray(img);

    [m,n] = size(ip);

    [coeff, score, latent, tsquared, explained, mu] = pca(img);

    approximation = score(:,1:30) * coeff(:,1:30)' + repmat(mu, m, 1);