function varnum = result_LL(input,watermark,name,band_name)

    %resizing of image
    [rows,columns] = size(input);
    watermark = imresize(watermark,[rows,columns]);

    %calculating Bhattacharya Distance and Kurtosis of Input image
    double_input = double(input);
    temp_input = imresize(double_input,[1,rows*columns]);
    double_watermark = double(watermark);
    temp_watermark = imresize(double_watermark,[1,rows*columns]);
    % temp_input = double_input(:);
    % temp_watermark = double_watermark(:);

    d=bhattacharyya_calculation(temp_input,temp_watermark);
    k = kurtosis((temp_watermark));

    %calculating dwt using Haar Wavelet
    [host_LL,host_LH,host_HL,host_HH]=dwt2(input,'haar');
    [watermark_LL,watermark_LH,watermark_HL,watermark_HH]=dwt2(watermark,'haar');

    %embedding watermark
    embedded_LL = host_LL + ( ((bhat_d*0.55)/k) * watermark_LL);
    embedded = idwt2(embedded_LL,host_LH,host_HL,host_HH,'haar');

    embedded=uint8(embedded);

    % attack = 'salt & pepper'; embedded = imnoise(embedded,attack,0.02);

    % attack = "gaussian"; embedded = imnoise(embedded,"gaussian" ,0.01);

    %attack = "poisson"; embedded = imnoise(embedded,"poisson");

    %extracting watermark
    [embedded_LL,embedded_LH,embedded_HL,embedded_HH]=dwt2(embedded,'haar');
    original_watermark_LL = (embedded_LL - host_LL)*(k/(bhat_d*0.55));
    extracted = idwt2(original_watermark_LL,watermark_LH,watermark_HL,watermark_HH,'haar');

    %plotting images
    figure;
    subplot(2,2,1),imshow(input);title("Original Image");
    subplot(2,2,2),imshow(watermark);title("Watermark Image");
    subplot(2,2,3),imshow(embedded);title("Embedded Image");
    subplot(2,2,4),imshow((extracted));title("Extracted Image");

    embedded = imresize(embedded,[rows,columns]);  

    double_extracted = double(extracted);
    temp_extracted = imresize(double_extracted,[1,rows*columns]);
    N = rows*columns;
    if true
      NCC =...
          ((1/N)*...
              sum(...
                (temp_watermark-mean(temp_watermark)).*(temp_extracted-mean(temp_extracted))...
                /sqrt(var(temp_watermark)*var(temp_extracted))...
              )...
          );
    end

    PSNR = psnr(embedded, input);

    X = sprintf('%10s \t %5f \t %5f %10s ',name,PSNR,NCC,band_name);
    disp(X);

    varnum = 1;

end