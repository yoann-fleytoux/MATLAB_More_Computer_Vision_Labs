close all;
clear all;

% I
%%Production d'une image binaire à l'aide d'un estimateur et d'un seuil
seuil = 30;
img = double(imread('TP03I1.jpg'));
f1 = [1 0 -1;1 0 -1;1 0 -1];
f2 = [1 1 1;0 0 0;-1 -1 -1];
img_grad = abs(conv2(img,f1,'valid')) + abs(conv2(img,f2,'valid'));
img_bin = img_grad > seuil;
imagesc(double(img_bin));
colormap(gray(256));
%%
matriceDeVotes = zeros(size(img_bin,1)+size(img_bin,2),628);
diag = round(abs(sqrt(size(img_bin,1)^2+size(img_bin,2)^2)));
haut = size(img_bin,1);
larg = size(img_bin,2);
X = []; Y = [];
for i = 1:haut
   for j = 1:larg
      if(img_bin(i,j) == 1)
         for theta = 1:628
             val_theta = 2*pi*theta/628;
             rho = round(i*cos(val_theta)+j*sin(val_theta));
             if(rho < diag && rho>0)
                matriceDeVotes(rho,theta) = matriceDeVotes(rho,theta) + 1;
             end
         end
      end
       
   end
end

figure;
imagesc(log(abs(matriceDeVotes+1)));
colormap(gray(256));

%% II Reconnaissance
V = matriceDeVotes;
NbKpoints = 10; %nb de droite
Krho = zeros(Kpoints,1);
Ktheta = zeros(Kpoints,1);

for k=1:NbKpoints
    [rho,theta,v ] = find(V == max(max(V)))
    Krho(k) = rho(1);
    Ktheta(k) = theta(1);
    V(rho(1),theta(1)) = 0;
end

%% x*cos(teta)+y*sin(teta) - ro < 0.5
seuil = 0.5
coord1 = zeros(Kpoints,2)
coord2 = zeros(Kpoints,2)
for k = 1:NbKpoints
   rho =  Krho(k)
   theta = Ktheta(k)
   first = 1;
   for x=1:haut
         for y=1:larg
             if abs(x*cos(theta/100)+y*sin(theta/100) - rho) < seuil && img_bin(x,y) == 1
                 if first == 1
                     if k == t
                        test = [x y] ;
                     end
                     coord1(k,1) = x;
                     coord1(k,2) = y;
                     first = 0;
                 else
                     coord2(k,1) = x;
                     coord2(k,2) = y;
                 end
             end
         end
   end
   
end

figure()
hold on
colormap(gray(256));
imagesc(img_bin);

for k=1:Kpoints
plot([coord1(k,2) coord2(k,2)],[coord1(k,1) coord2(k,1)],'-y');
end

%% III Retroprojection de radon
imgV = double(imread('TP03I2.jpg'));
V = double(imread('TP03I2.jpg'));
NbKpoints = 25; %nb de droite
Krho = ones(Kpoints,1);
Ktheta = ones(Kpoints,1);

for k=1:NbKpoints
    [rho,theta,v] = find(V == max(max(V)));
    Krho(k) = rho(1);
    Ktheta(k) = theta(1);
    V(rho(1),theta(1)) = 0;
end

%% x*cos(teta)+y*sin(teta) - ro < 0.5
seuil = 0.5;
coord1 = zeros(Kpoints,2);
coord2 = zeros(Kpoints,2);
imgRecons = zeros(468,500);
for k = 1:NbKpoints
   rho =  Krho(k)
   theta = Ktheta(k)
   first = 1;
   for x=1:haut
         for y=1:larg
             if abs(x*cos(theta/100)+y*sin(theta/100) - rho) < seuil && img_bin(x,y) == 1
                 if first == 1
                     if k == t
                        test = [x y] ;
                     end
                     coord1(k,1) = x;
                     coord1(k,2) = y;
                     first = 0;
                 else
                     coord2(k,1) = x;
                     coord2(k,2) = y;
                 end
             end
         end
   end
   
end

figure()
hold on
colormap(gray(256));
imagesc();

for k=1:Kpoints
plot([coord1(k,2) coord2(k,2)],[coord1(k,1) coord2(k,1)],'-y');
end

%% III Retroprojection de radon correction
imgV = double(imread('TP03I2.jpg'));
[haut, larg] = size(imgV);
hauteurImg = 468;
largeurImg = 500;
imgRecons = zeros(hauteurImg, largeurImg);

for x = 1:hauteurImg
   for y = 1:largeurImg;
       for k = 1:larg
           theta = k;
           rho = round(x*cos(theta/100)+y*sin(theta/100));
           if rho > 0 && theta > 0
                imgRecons(x,y) = imgRecons(x,y) + imgV(rho,theta);
           end
       end
   end
end

figure();
colormap(gray(256));
imagesc(imgRecons);