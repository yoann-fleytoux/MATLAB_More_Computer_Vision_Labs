T = [];
 
for i=1:1000
    img = double(imread(strcat('img',int2str(i),'.bmp')));
    
    %% Calcul features/caractéristiques  img i
    V = haarfeature(img);
    
    %Tag de l'image
    if i<=500
        V = [V 1];%Visage 
    else
        V = [V 0];%Pas visage
    end
    
    %Ajout caracteristiques au tableau
    T = [T ; V];
end
    %% Apprentissage foret (partie a priori OK)
    nbArbres = 8;
    foret = zeros(8,4,2,nbArbres);
    for j=1:nbArbres
        [foret(:,:,:,j),ens,indNoeudCourant] = construcArbre(foret(:,:,:,j), T);
    end
    
    
    %% Reconnaissance 
    %tTester sur l'ensemble des visages utilises pour l'apprentissage
    hauteurArbres = 4;
    vraiPos = 0;
    fauxNeg = 0;
    
    fauxPos = 0;
    vraiNeg = 0;
    
    for i=1:1000
        classe = Reco(foret,nbArbres,hauteurArbres,i,T);
        
        if i <= 500
           if classe == 1
                vraiPos = vraiPos + 1;
           else
                fauxNeg = fauxNeg + 1;
           end
        else
           if classe == 1
                fauxPos = fauxPos + 1;
           else
                vraiNeg = vraiNeg + 1;
           end
            
        end

    end
    


