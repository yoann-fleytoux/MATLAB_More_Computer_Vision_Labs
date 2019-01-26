img = double(imread('TP01I01.jpg'));
imagesc(log(abs(fft2(img))));
imgSpectre = fft2(img);
imgInv = abs(ifft2(imgSpectre));
errQuadMoy = sum(sum((img-imgInv).^2));  % l'erreur quadratique est de 7.543161182015319e-23

%% Algorithme à appliquer dans la question
n = 1;
imgSpectreATraiterReprConv = fftshift(imgSpectre);
errQuadMoyMat = [];
coeffRemplac = [];
for n = 1:size(img,2)/2-1
    imgSpectreATraiterReprConv(1:n,1:n) = 0;
    imgSpectreATraiterReprConv(size(imgSpectreATraiterReprConv,1)+1-n:n,1:n) = 0;
    imgSpectreATraiterReprConv(1:n,size(imgSpectreATraiterReprConv,2)+1-n:n) = 0;
    imgSpectreATraiterReprConv(size(imgSpectreATraiterReprConv,1)+1-n:n,size(imgSpectreATraiterReprConv,2)+1-n:n) = 0;
    imgSpectreInv = abs(ifft2(imgSpectreATraiterReprConv));
    errQuadMoyMat = [errQuadMoyMat sum(sum((img-imgSpectreInv).^2))];
    coeffRemplac = [coeffRemplac 4*n*n];
end

figure;
title('erreur quadratique en pourcent en vert et pourcentage coefficients remplacés en rouge');
hold on;
plot(errQuadMoyMat*100/max(errQuadMoyMat),'r'); %erreur quadratique en % en vert
hold on;
plot(coeffRemplac*100/(size(imgSpectreATraiterReprConv,1)*size(imgSpectreATraiterReprConv,1)),'g'); % pourcentage coefficients remplacés

%%