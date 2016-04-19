function Draw_area(area)
%display the area's situation
[L, W] = size(area);
temp = area;

Area(:,:,1) = area;
Area(:,:,2) = area;
Area(:,:,3) = temp;

for i=1:L
    for j=1:W
        if area(i,j)==0
            Area(i,j,:)=[123 123 123];
        end
        if area(i,j)==1
            Area(i,j,:)=[0 200 0];
        end
        if area(i,j)==2
            Area(i,j,:)=[255 255 0];
        end
        if area(i,j)==3
            Area(i,j,:)=[255 0 0];
        end
        if area(i,j)==4
            Area(i,j,:)=[0 255 255];
        end
        if area(i,j)==5
            Area(i,j,:)=[0 0 200];
        end
    end
end
Area = uint8(Area);
   p = imagesc(Area); 
   hold on;
%    plot([(0:W)',(0:W)']+0.5,[0,L]+0.5,'k');
%    plot([0,W]+0.5,[(0:L)',(0:L)']+0.5,'k');
   axis image;
   set(gca,'xtick',[]);
   set(gca,'ytick',[]);
%    str = {'grey','green','yellow','red','cyanine','blue'};
% [str(1),str(2),str(3),str(4),str(5),str(6)],
% 'black','susceptible','station','symptomatic','isolated','recovered'
%    legend(p,3);
end

