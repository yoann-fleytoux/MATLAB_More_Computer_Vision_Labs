

function V=haarfeature(img)
Nofeature=0;
V=[];

%% Caractéristiques de haar bloc 1
larg =  2;
ep = 1;
% feature horizontale 1
% pour toutes les largeurs possibles
for i=1:5 
    
    ep = 1;
    % pour toutes les épaisseurs possibles
    for j=1:10
        
        % pour toutes les positions en ligne
        for x=1:10-ep+1
                
            % pour toutes les positions en colonnes
            for y=1:10-larg+1
                  som1 = sum ( sum (img(x:x+ep-1,y:y+larg/2-1)));
                  som2 = sum ( sum (img(x:x+ep-1,y+larg/2:y+larg/2+larg/2-1)));
                  res = som1 - som2;
                  V = [V res];
                  
                  Nofeature=Nofeature+1;
            end
        end
        ep =  ep + 1;
    end
    larg = larg + 2;
    
end


%% Caractéristiques de haar bloc 2
img = img';%Inversion de l'image 
larg =  2;
ep = 1;
% feature horizontale 1
% pour toutes les largeurs possibles
for i=1:5 
    
    ep = 1;
    % pour toutes les épaisseurs possibles
    for j=1:10
        
        % pour toutes les positions en ligne
        for x=1:10-ep+1
                
            % pour toutes les positions en colonnes
            for y=1:10-larg+1
                  som1 = sum ( sum (img(x:x+ep-1,y:y+larg/2-1)));
                  som2 = sum ( sum (img(x:x+ep-1,y+larg/2:y+larg/2+larg/2-1)));
                  res = som1 - som2;
                  V = [V res];
                  
                  Nofeature=Nofeature+1;
            end
        end
        ep =  ep + 1;
    end
    larg = larg + 2;
    
end

%% Caractéristiques de haar bloc 3
img = img';%Inversion de l'image (pour retrouver l'img initiale)
larg =  4;
ep = 1;
% feature horizontale 1
% pour toutes les largeurs possibles
for i=1:5 
    
    ep = 1;
    % pour toutes les épaisseurs possibles
    for j=1:10
        
        % pour toutes les positions en ligne
        for x=1:10-ep+1
                
            % pour toutes les positions en colonnes
            for y=1:10-larg+1
                  som1 = sum ( sum (img(x:x+ep-1,y:y+larg/4-1)));
                  som2 = sum ( sum (img(x:x+ep-1,y+larg/4+larg/2:y+larg/4+larg/2 + larg/4-1)));
                  som3 = sum ( sum (img(x:x+ep-1,y+larg/4:y+larg/4 + larg/2-1)));
                  res = som1 + som2 - som3;
                  V = [V res];
                  
                  Nofeature=Nofeature+1;
            end
        end
        ep =  ep + 1;
    end
    larg = larg + 4;
    
end

end