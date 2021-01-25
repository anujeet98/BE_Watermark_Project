function v = bhattacharyya(host,watermark)
    [r,c] = size(host);
    temp_l = imresize(double(host),[1,r*c]);
    temp_h = imresize(double(watermark),[1,r*c]);
    v = bhattacharyya_calculation(temp_l,temp_h);
end