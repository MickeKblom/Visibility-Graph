function VisibilityGraph = vis(start, target, O1, O2, O3) 
%ex  vis([0,0], [10,20], [12,14;10,14], [6,8;6,8], [0.9,8;0.9,1.5])
%Or vis([10,1],[10,19.5],[4,16;4,8],[3,17;10,12],[2,18;16,19]) 

%start as [x,y], target as [x,y]
%Objects O1,O2... as [x1,x2;y1,y2]

close all


mapshow(start(1),start(2),'Marker','x');
text(start(1),start(2),'START','Color','black','FontSize',8)
mapshow(target(1),target(2),'Marker','x');
text(target(1),target(2),'TARGET','Color','black','FontSize',8)

%%Draw the rectangles

%----------O1----------------------
xlimit1 = [O1(1,:)];
ylimit1 = [O1(2,:)];

xbox1 = xlimit1([1 1 2 2 1]);  %Making an object 
ybox1 = ylimit1([1 2 2 1 1]);
mapshow(xbox1,ybox1,'DisplayType','polygon','LineStyle','-')
text(O1(1,1)+(O1(1,2)-O1(1,1))/2,O1(2,1)+(O1(2,2)-O1(2,1))/2,'O1','Color','blue','FontSize',6)


%----------O2----------------------
xlimit2 = [O2(1,:)];
ylimit2 = [O2(2,:)];
xbox2 = xlimit2([1 1 2 2 1]);
ybox2 = ylimit2([1 2 2 1 1]);
mapshow(xbox2,ybox2,'DisplayType','polygon','LineStyle','-')
text(O2(1,1)+(O2(1,2)-O2(1,1))/2,O2(2,1)+(O2(2,2)-O2(2,1))/2,'O2','Color','blue','FontSize',6)


%----------O3----------------------
xlimit3 = [O3(1,:)];
ylimit3 = [O3(2,:)];
xbox3 = xlimit3([1 1 2 2 1]);
ybox3 = ylimit3([1 2 2 1 1]);
mapshow(xbox3,ybox3,'DisplayType','polygon','LineStyle','-')
text(O3(1,1)+(O3(1,2)-O3(1,1))/2,O3(2,1)+(O3(2,2)-O3(2,1))/2,'O3','Color','blue','FontSize',6)


% Create all possible lines to/from vertices 

%---------------------------------start to O1 ------------------------------------   
% 
 f1=1;
for f2 =1:2
    for f3=1:2
        a(f1,:)=[start(1),O1(1,f2)];  %making the line to each vertice, all combinations (handled by for loop)
        b(f1,:)=[start(2),O1(2,f3)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique'); %Check if collision
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
        if  length(xi) == 1 && length(yi)==1 && isempty(xo)==1 && isempty(yo)==1 && isempty(xp)==1 && isempty(yp)==1
            %IF there is a "nonAccepted" (not to vertice) collision, we
            %dont include it. 
            mapshow(xi,yi,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            A(f1,:)=a(f1,:);
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
        
    end
end

% %---------------------------------start to O2 ------------------------------------ 


for f2 =1:2
    for f3=1:2
        a(f1,:)=[start(1),O2(1,f2)];
        b(f1,:)=[start(2),O2(2,f3)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique');
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
       if isempty(xi)==1 && isempty(yi)==1 && isempty(xp)==1 && isempty(yp)==1 && length(xo)==1 && length(yi)==1  
           mapshow(xo,yo,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            A(f1,:)=a(f1,:);
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
    end
end


% % %---------------------------------start to O3 ------------------------------------ 
% 

for f2 =1:2
    for f3=1:2
        a(f1,:)=[start(1),O3(1,f2)];
        b(f1,:)=[start(2),O3(2,f3)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique');
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
        if isempty(xi)==1 && isempty(yi)==1 && isempty(xo)==1 && isempty(yo)==1 && length(xp)==1 && length(yp)==1
            mapshow(xi,yi,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            A(f1,:)=a(f1,:);
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
    end
end

% % %---------------------------------O1 to O2------------------------------------
for g1 = 1:2
    for g2=1:2
for f2 =1:2
    for f3=1:2
        a(f1,:)=[O1(1,g1),O2(1,f2)];
        b(f1,:)=[O1(2,g2),O2(2,f3)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique');
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
     if length(xi)==1 && length(yi)==1 && length(xo)==1 && length(yo)==1 && isempty(xp)==1 && isempty(yp)==1 
            mapshow(xi,yi,'DisplayType','point','Marker','o')
            mapshow(xo,yo,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            A(f1,:)=a(f1,:);
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
    end
end
    end
end

% % %---------------------------------O1 to O3------------------------------------

for g1 = 1:2
    for g2=1:2
for f2 =1:2
    for f3=1:2
        a(f1,:)=[O1(1,g1),O3(1,f2)];
        b(f1,:)=[O1(2,g2),O3(2,f3)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique');
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
        if length(xi)==1 && length(yi)==1 && isempty(xo)==1 && isempty(yo)==1 && length(xp)==1 && length(yp)==1 
            mapshow(xi,yi,'DisplayType','point','Marker','o')
            mapshow(xp,yp,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            A(f1,:)=a(f1,:);
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
    end
end
    end
end
% 
% % %---------------------------------O2 to O3------------------------------------
% 
for g1 = 1:2
    for g2=1:2
for f2 =1:2
    for f3=1:2
        a(f1,:)=[O2(1,g1),O3(1,f2)];
        b(f1,:)=[O2(2,g2),O3(2,f3)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique');
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
        if length(xo)==1 && length(yo)==1 && isempty(xi)==1 && isempty(yi)==1 && length(xp)==1 && length(yp)==1 
            mapshow(xo,yo,'DisplayType','point','Marker','o')
            mapshow(xp,yp,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            A(f1,:)=a(f1,:);
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
    end
end
    end
end

% % %---------------------------------O1 to target------------------------------------

for f2 =1:2
    for f3=1:2
        a(f1,:)=[O1(1,f2),target(1)];
        b(f1,:)=[O1(2,f3),target(2)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique');
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
        if isempty(xp)==1 && isempty(yp)==1 && isempty(xo)==1 && isempty(yo)==1 && length(xi)==1 && length(yi)==1
            mapshow(xi,yi,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            A(f1,:)=a(f1,:);
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
    end
end

% % %---------------------------------O2 to target------------------------------------

for f2 =1:2
    for f3=1:2
        a(f1,:)=[O2(1,f2),target(1)];
        b(f1,:)=[O2(2,f3),target(2)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique');
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
       if isempty(xi)==1 && isempty(yi)==1 && isempty(xp)==1 && isempty(yp)==1 && length(xo)==1 && length(yo)==1  
            mapshow(xo,yo,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
    end
end
% 
% % %---------------------------------O3 to target------------------------------------

for f2 =1:2
    for f3=1:2
        a(f1,:)=[O3(1,f2),target(1)];
        b(f1,:)=[O3(2,f3),target(2)];
        
        [xi,yi] = polyxpoly(a(f1,:),b(f1,:),xbox1,ybox1,'unique');
        [xo,yo] = polyxpoly(a(f1,:),b(f1,:),xbox2,ybox2,'unique');
        [xp,yp] = polyxpoly(a(f1,:),b(f1,:),xbox3,ybox3,'unique');
       if isempty(xi)==1 && isempty(yi)==1 && isempty(xo)==1 && isempty(yo)==1 && length(xp)==1 && length(yp)==1   
            mapshow(xp,yp,'DisplayType','point','Marker','o')
            mapshow(a(f1,:),b(f1,:));
            A(f1,:)=a(f1,:);
            B(f1,:)=b(f1,:);
            f1=f1+1;
        end
    end
end

size(A);
size(B);

set(gca,'xlim',[0 20],'ylim',[0 20])

