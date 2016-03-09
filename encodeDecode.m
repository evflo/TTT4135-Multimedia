function encodeDecode(rate, encoding, source)
srcFiles = {'bike.pgm', 'cafe.pgm', 'woman.pgm'};
imgNames = {'bike', 'cafe', 'woman'};
strRate = num2str(rate);
strRate = strRate(strRate ~= '.');

if ~(strcmp(encoding, 'jp2') || strcmp(encoding, 'jpg'))
    fprintf('Invalid encoding');
    return;
end

strEncFile = sprintf('%s_%s_%sbpp_enc.%s', imgNames{source}, encoding, ...
    strRate, encoding);
strDecFile = sprintf('%s_%s_%sbpp_dec.pgm', imgNames{source}, encoding, ...
    strRate);

if strcmp(encoding, 'jp2')
    strEnc = sprintf('j2000_encoder -i %s -o %s -rate %g', srcFiles{source}, ...
        strEncFile, rate);
    strDec = sprintf('j2000_decoder -i %s -o %s -Cno_speedup', strEncFile, ...
        strDecFile);
    
else %jpg
    strEnc = sprintf('jpeg_encoder -quality %g %s %s', rate, srcFiles{source}, ...
        strEncFile);
    strDec = sprintf('jpeg_decoder %s %s', strEncFile, strDecFile);
end

[status, result] = system(strEnc);
disp(result);
[status, result] = system(strDec);
disp(result);
strPSNR = sprintf('vm3_dist %s %s', srcFiles{source}, strDecFile);
[status, result] = system(strPSNR);
disp(result);

if strcmp(encoding, 'jpg')
    img = imread(strEncFile);
    pixels = prod(size(img));
    fileObj = dir(strEncFile);
    bpp = fileObj.bytes * 8 / pixels;
    fprintf('BPP: %g\n', bpp);
end
    

%system(strDecFile);
end