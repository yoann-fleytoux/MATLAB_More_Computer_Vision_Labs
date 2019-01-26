close all;
clear all;
CarreRGB = imread('Carre.png');
CercleRGB = imread('Cercle.png');
TriangleRGB = imread('Triangle.png');

Carre = rgb2gray(CarreRGB);
Cercle = rgb2gray(CercleRGB);
Triangle = rgb2gray(TriangleRGB);

CarreBW = imbinarize(Carre);
CercleBW = imbinarize(Cercle);
TriangleBW = imbinarize(Triangle);

CarreBW = CarreBW -1;
CarreBW = abs(CarreBW);
CercleBW = CercleBW -1;
CercleBW = abs(CercleBW);
TriangleBW = TriangleBW -1;
TriangleBW = abs(TriangleBW);

CarreTD = CarreBW;
CercleTD = CercleBW;
TriangleTD = TriangleBW;

for i=1:100
    for j=1:100
        if CarreTD(i,j) == 0
           CarreTD(i,j) = (70*3);
        else
           CarreTD(i,j) = 0;
        end
        if CercleTD(i,j) == 0
           CercleTD(i,j) = (70*3);
        else
           CercleTD(i,j) = 0;
        end
        if TriangleTD(i,j) == 0
           TriangleTD(i,j) = (70*3);
        else
           TriangleTD(i,j) = 0;
        end
    end
end

for i=2:99
    for j=2:99
    CaD = [CarreTD(i-1,j-1)+4;
        CarreTD(i-1,j)+3;
        CarreTD(i-1,j+1)+4;
        CarreTD(i,j-1)+3;
        CarreTD(i,j)];
        CarreTD(i,j) = min(CaD);
    CeD = [CercleTD(i-1,j-1)+4;
        CercleTD(i-1,j)+3;
        CercleTD(i-1,j+1)+4;
        CercleTD(i,j-1)+3;
        CercleTD(i,j)];
        CercleTD(i,j) = min(CeD);
    TriD = [TriangleTD(i-1,j-1)+4;
        TriangleTD(i-1,j)+3;
        TriangleTD(i-1,j+1)+4;
        TriangleTD(i,j-1)+3;
        TriangleTD(i,j)];
        TriangleTD(i,j) = min(TriD);
    end
end
for i=99:-1:2
    for j=99:-1:2
        CaM = [CarreTD(i+1,j+1)+4;
        CarreTD(i+1,j)+3;
        CarreTD(i+1,j-1)+4;
        CarreTD(i,j+1)+3;
        CarreTD(i,j)];
        CarreTD(i,j) = min(CaM);
    CeM = [CercleTD(i+1,j+1)+4;
        CercleTD(i+1,j)+3;
        CercleTD(i+1,j-1)+4;
        CercleTD(i,j+1)+3;
        CercleTD(i,j)];
        CercleTD(i,j) = min(CeM);
    TriM = [TriangleTD(i+1,j+1)+4;
        TriangleTD(i+1,j)+3;
        TriangleTD(i+1,j-1)+4;
        TriangleTD(i,j+1)+3;
        TriangleTD(i,j)];
        TriangleTD(i,j) = min(TriM);
    end
end
figure;
imagesc(uint8(CarreTD));
figure;
imagesc(uint8(CercleTD));
figure;
imagesc(uint8(TriangleTD));

%%PARTIE 2
CercleDouteuxRGB = imread('CercleDouteux.png');
CercleDouteux = rgb2gray(CercleDouteuxRGB);

CercleDouteuxBW = imbinarize(CercleDouteux);

CercleDouteuxBW = CercleDouteuxBW -1;
CercleDouteuxBW = abs(CercleDouteuxBW);

CercleDouteuxTD = CercleDouteuxBW;
for i=1:100
    for j=1:100
        if CercleDouteuxTD(i,j) == 0
           CercleDouteuxTD(i,j) = (200*3);
        else
           CercleDouteuxTD(i,j) = 0;
        end
    end
end

for i=2:99
    for j=2:99
    CeDD = [CercleDouteuxTD(i-1,j-1)+4;
        CercleDouteuxTD(i-1,j)+3;
        CercleDouteuxTD(i-1,j+1)+4;
        CercleDouteuxTD(i,j-1)+3;
        CercleDouteuxTD(i,j)];
        CercleDouteuxTD(i,j) = min(CeDD);
    end
end
for i=99:-1:2
    for j=99:-1:2
    CeDM = [CercleDouteuxTD(i+1,j+1)+4;
        CercleDouteuxTD(i+1,j)+3;
        CercleDouteuxTD(i+1,j-1)+4;
        CercleDouteuxTD(i,j+1)+3;
        CercleDouteuxTD(i,j)];
        CercleDouteuxTD(i,j) = min(CeDM);
    end
end
figure;
imagesc(uint8(CercleDouteuxTD));

erreurCercle = sum(sum(CercleTD.*CercleDouteuxBW));
erreurCarre = sum(sum(CarreTD.*CercleDouteuxBW));
erreurTriangle = sum(sum(TriangleTD.*CercleDouteuxBW));
tauxCercle = 1-erreurCercle/10000
tauxCarre = 1-erreurCarre/10000
tauxTriangle = 1-erreurTriangle/10000
