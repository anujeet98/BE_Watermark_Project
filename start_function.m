function value = start_function(host,watermark,name)
    
    [host_LL,host_LH,host_HL,host_HH]=dwt2(host,'haar');
    [watermark_LL,watermark_LH,watermark_HL,watermark_HH]=dwt2(watermark,'haar');
    d = cell(4,2);
    
    d{1,1} = "LL";
    d{1,2} = bhattacharyya(host_LL,watermark_LL);
     
    d{2,1} = "LH";
    d{2,2} = bhattacharyya(host_LH,watermark_LH);
     
    d{3,1} = "HL";
    d{3,2} = bhattacharyya(host_HL,watermark_HL);
     
    d{4,1} = "HH";
    d{4,2} = bhattacharyya(host_HH,watermark_HH);
     
    first = min(d{1,2},d{2,2});
    second = min(d{3,2},d{4,2});
    final = min(first,second);
    
    if final == d{1,2}
        result_LL(host,watermark,name,d{1,1});
    elseif final == d{2,2}
        result_LH(host,watermark,name,d{2,1});
    elseif final == d{3,2}
        result_HL(host,watermark,name,d{3,1});
    elseif final == d{4,2}
        result_HH(host,watermark,name,d{4,1});
    end
    
    value=1;
end    