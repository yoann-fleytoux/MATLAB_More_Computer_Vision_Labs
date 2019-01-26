function [ classe ] = Reco(foret,nbArbres,hauteurArbres,indImg,T)
%         for h=1:hauteurArbres-1
%             for branche=1:2^(h-1)            
% 
%             
%                 t = 2^(hauteur - 1)/2^(h-1);
%             
%                 %% Arbre des features
% %                 arbre((branche - 1)*t+1:branche*t,h,1) = f;
%                 indFeat = arbre((branche - 1)*t+1,h,1);%Indice feature a tester
%                 
%                 valFeat = T(indImg,f);
%              

    nbVisage = 0;
    nbPasVisage = 0;
    
    %Pour chaque arbre
    for i=1:nbArbres
        indL = 1;
        indCol = 1;
        
        %%%
        %%% Hauteur = 1
        %%%
        f = foret(indL,indCol,1,i);%Feature
        seuil = foret(indL,indCol,2,i);%Seuil
        
        if T(indImg,f) < seuil
           %indCol = indCol
        else
            indL = indL + 4;
        end
        indCol =  indCol + 1;
        
        
        
        %%%
        %%% Hauteur = 2
        %%%
        f = foret(indL,indCol,1,i);%Feature
        seuil = foret(indL,indCol,2,i);%Seuil
        
        if T(indImg,f) < seuil
           %indCol = indCol
        else
            indL = indL + 2;
        end
        indCol =  indCol + 1;
        
        %%%
        %%% Hauteur = 3
        %%%
        f = foret(indL,indCol,1,i);%Feature
        seuil = foret(indL,indCol,2,i);%Seuil
        
        if T(indImg,f) < seuil
           %indCol = indCol
        else
            indL = indL + 1;
        end
        indCol =  indCol + 1;
        
        
        %%%
        %%% Hauteur = 3
        %%%
        if foret(indL,indCol,1,i) == 1
           nbVisage = nbVisage + 1; 
        else
           nbPasVisage = nbPasVisage + 1; 
        end

        
    end
    
    %Vote majoritaire
    if nbVisage > nbPasVisage
        classe = 1;
    else
        classe = 0;
    end
    
end

