img = {1:50};
imgSpectre = {1:50};
sumModCoefFreq = zeros(50,18);
for i=1:50
   img{i} = double(imread(['bibimage/' int2str(i) '.jpg']));
   % imshow(img{i});
   img{i} = round((img{i}(:,:,1)+img{i}(:,:,2)+img{i}(:,:,3))/3);
   %imagesc(log(abs(fft2(img{i}))));
   imgSpectre{i} = fft2(img{i});
   imgSpectre{i} = fftshift(imgSpectre{i});
   imgSpectre{i} = imgSpectre{i}(1:100,:);
   
   sumModCoefFreq(i,1) = sum(sum(abs(imgSpectre{i}(1:50,1:50))));
   sumModCoefFreq(i,2) = sum(sum(abs(imgSpectre{i}(1:50,51:75))));
   sumModCoefFreq(i,3) = sum(sum(abs(imgSpectre{i}(1:50,76:100))));
   sumModCoefFreq(i,4) = sum(sum(abs(imgSpectre{i}(1:50,101:125))));
   sumModCoefFreq(i,5) = sum(sum(abs(imgSpectre{i}(1:50,126:150))));
   sumModCoefFreq(i,6) = sum(sum(abs(imgSpectre{i}(1:50,151:200))));
   sumModCoefFreq(i,7) = sum(sum(abs(imgSpectre{i}(51:75,1:50))));
   sumModCoefFreq(i,8) = sum(sum(abs(imgSpectre{i}(51:75,51:75))));
   sumModCoefFreq(i,9) = sum(sum(abs(imgSpectre{i}(51:75,76:100))));
   sumModCoefFreq(i,10) = sum(sum(abs(imgSpectre{i}(51:75,101:125))));
   sumModCoefFreq(i,11) = sum(sum(abs(imgSpectre{i}(51:75,126:150))));
   sumModCoefFreq(i,12) = sum(sum(abs(imgSpectre{i}(51:75,151:200))));
   sumModCoefFreq(i,13) = sum(sum(abs(imgSpectre{i}(76:100,1:50))));
   sumModCoefFreq(i,14) = sum(sum(abs(imgSpectre{i}(76:100,51:75))));
   sumModCoefFreq(i,15) = sum(sum(abs(imgSpectre{i}(76:100,76:100))));
   sumModCoefFreq(i,16) = sum(sum(abs(imgSpectre{i}(76:100,101:125))));
   sumModCoefFreq(i,17) = sum(sum(abs(imgSpectre{i}(76:100,126:150))));
   sumModCoefFreq(i,18) = sum(sum(abs(imgSpectre{i}(76:100,151:200))));
end

mandist = []
nb = 44;
tempImg = double(imread(['bibimage/' int2str(nb) '.jpg']));
for i=1:50
    
   mandist(i) = sum(abs(sumModCoefFreq(nb,:) - sumModCoefFreq(i,:)));
   
end

