    function [arbre, imgNoeud,indNoeudCourant] = construcArbre(arbre, T)
    hauteur = 4;
    imgNoeud = zeros(7,1000);%Vecteur de sous ensembles d'images testées à chaque noeud de l'arbre
    imgNoeud(1,:) = 1:1000;%Ensemble d'images associé à la racine de l'arbre
    indNoeudCourant = 1;%Indice du sous ensemble d'images testées au noeud courant
    indNoeudFils = 2;%Indice du sous ensemble d'images testees pour le premier noeud fils du noeud courant
    indFeuilleHaut = 1;
    
    
    for h=1:hauteur-1
        for branche=1:2^(h-1)            
            %% Tirage aleatoire d'une feature
            f = round(rand(1)*3300);
            
            t = 2^(hauteur - 1)/2^(h-1);
            
            %% Arbre des features
            arbre((branche - 1)*t+1:branche*t,h,1) = f;
            arbre((branche - 1)*t+1:branche*t,h,1);
            %Calcul seuil pour cette feature
            [~,seuil] = separationSeuil(imgNoeud(indNoeudCourant,:)',T(:,f),T(:,3301));
            
            %% Arbre des seuils
            %Maj arbre seuils
            arbre((branche - 1)*t+1:branche*t,h,2) = seuil; 
 
            %% Maj images associées à chaque noeud
            if h <= hauteur - 2
                %Maj ensembles images testées aux deux noeuds fils
                ind1 = 1;
                ind2 = 1;
                for i=1:1000
                    %Image a cet indice
                    if imgNoeud(indNoeudCourant,i) > 0
                       %Noeud fils 1
                       if T(imgNoeud(indNoeudCourant,i),f) < seuil
                          imgNoeud(indNoeudFils,ind1) = imgNoeud(indNoeudCourant,i);%Ajout de l'img au premier noeud fils (noeud fils du haut dans le tableau)
                          ind1 = ind1 + 1;
                       %Noeud fils 2   
                       else
                           imgNoeud(indNoeudFils+1,ind2) = imgNoeud(indNoeudCourant,i);%Ajout de l'img au second noeud fils (noeud du bas dans le tableau) 
                           ind2 = ind2 + 1;
                       end
                    end
                end

                indNoeudCourant = indNoeudCourant + 1;
                indNoeudFils = indNoeudFils + 2;
            end

            %% Determination classe sur les feuilles terminales de l'arbre
            if h == (hauteur - 1)
               nbVisageInf = 0;%Nb de visage en dessous du seuil
               nbVisageSup = 0;%Nb de visages au dessus du seuil 
               %Parcours de toutes les images
               for i=1:1000
                    %Image bien comprise dans l'ensemble d'images du noeud
                    if imgNoeud(indNoeudCourant,i) > 0
                       %Feuille 1 (haut)
                       if T(imgNoeud(indNoeudCourant,i),f) < seuil
                          if T(imgNoeud(indNoeudCourant,i),3301) == 1%Image correspont a un visage 
                               nbVisageInf = nbVisageInf + 1; 
                          end
                       %Feuille 2 (bas)
                       else
                          if T(imgNoeud(indNoeudCourant,i),3301) == 1%Image correspont a un visage 
                               nbVisageSup = nbVisageSup + 1; 
                          end
                       end
                    end
                end
                
                %Attribution de la classe 2 feuilles terminales situees
                %sous le noeud courant
                if nbVisageInf > nbVisageSup
                    arbre(indFeuilleHaut,h+1,1)=1;
                    arbre(indFeuilleHaut+1,h+1,1)=0;    
                else
                    arbre(indFeuilleHaut,h+1,1)=0;
                    arbre(indFeuilleHaut+1,h+1,1)=1;  
                end

                indNoeudCourant = indNoeudCourant + 1;
                indFeuilleHaut = indFeuilleHaut + 2;
            end
            


            
        end
    end
end