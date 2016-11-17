close all
clc
clear


% L is the number of points in each direction
L=11;
id_multiplier = 8;
%I'm pretty sure my Id_ends in 8, if not I made it easy to change

%open a new file to write the STL mesh
fid=fopen('one.stl','w')
fprintf(fid,'%s \n','solid sheet');

%limits
xmin=-id_multiplier/2;
xmax=id_multiplier/2;
ymin=-id_multiplier;
ymax=id_multiplier;
zmin=-id_multiplier*2;
zmax=id_multiplier*2;

%creaes two vectors x & y with dimensions 1*L
x1=linspace(xmin,xmax,L);
y1=linspace(ymin,ymax,L);
x1=0.5*id_multiplier*sin(pi*x1/id_multiplier);
y1=id_multiplier*sin(pi*y1/id_multiplier/2);
%converts 1*L vectors to L*L matrices
[X1,Y1]=meshgrid(x1,y1);
X2 = X1;Y2 = Y1;
%calculate corresponding Z-values
Z1=-ones(L,L)*2*id_multiplier;
Z2=ones(L,L)*2*id_multiplier;

for i=1:L-1
    for j=1:L-1
        
        %first triangle
        x1_1=X1(i,j);
        y1_1=Y1(i,j);
        z1_1=Z1(i,j);
        x2_1=X1(i+1,j);
        y2_1=Y1(i+1,j);
        z2_1=Z1(i+1,j);
        x3_1=X1(i+1,j+1);
        y3_1=Y1(i+1,j+1);
        z3_1=Z1(i+1,j+1);
        
        x1_3=X2(i,j);
        y1_3=Y2(i,j);
        z1_3=Z2(i,j);
        x2_3=X2(i+1,j);
        y2_3=Y2(i+1,j);
        z2_3=Z2(i+1,j);
        x3_3=X2(i+1,j+1);
        y3_3=Y2(i+1,j+1);
        z3_3=Z2(i+1,j+1);        
        
        %second triangle
        x1_2=X1(i,j);
        y1_2=Y1(i,j);
        z1_2=Z1(i,j);
        x2_2=X1(i+1,j+1);
        y2_2=Y1(i+1,j+1);
        z2_2=Z1(i+1,j+1);
        x3_2=X1(i,j+1);
        y3_2=Y1(i,j+1);
        z3_2=Z1(i,j+1);
        
        x1_4=X2(i,j);
        y1_4=Y2(i,j);
        z1_4=Z2(i,j);
        x2_4=X2(i+1,j+1);
        y2_4=Y2(i+1,j+1);
        z2_4=Z2(i+1,j+1);
        x3_4=X2(i,j+1);
        y3_4=Y2(i,j+1);
        z3_4=Z2(i,j+1);
        
        %plot the two triangles
        figure(1)
        hold on
        fill3([x1_1 x2_1 x3_1 x1_1],[y1_1 y2_1 y3_1 y1_1],[z1_1 z2_1 z3_1 z1_1],'b')
        fill3([x1_2 x2_2 x3_2 x1_2],[y1_2 y2_2 y3_2 y1_2],[z1_2 z2_2 z3_2 z1_2],'b')
        fill3([x1_3 x2_3 x3_3 x1_3],[y1_3 y2_3 y3_3 y1_3],[z1_3 z2_3 z3_3 z1_3],'b')
        fill3([x1_4 x2_4 x3_4 x1_4],[y1_4 y2_4 y3_4 y1_4],[z1_4 z2_4 z3_4 z1_4],'b')
%         pause
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_1,y1_1,z1_1);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_1,y2_1,z2_1);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_1,y3_1,z3_1);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_2,y1_2,z1_2);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_2,y2_2,z2_2);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_2,y3_2,z3_2);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
                
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_3,y1_3,z1_3);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_3,y2_3,z2_3);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_3,y3_3,z3_3);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_4,y1_4,z1_4);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_4,y2_4,z2_4);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_4,y3_4,z3_4);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
    end
end

y1=linspace(ymin,ymax,L);
z1=linspace(zmin,zmax,L);
y1=id_multiplier*sin(pi*y1/id_multiplier/2);
z1=2*id_multiplier*sin(pi*z1/id_multiplier/4);
%converts 1*L vectors to L*L matrices
[Y1,Z1]=meshgrid(y1,z1);
Y2 = Y1;Z2 = Z1;
%calculate corresponding Z-values
X1=-ones(L,L)*0.5*id_multiplier;
X2=ones(L,L)*0.5*id_multiplier;

for i=1:L-1
    for j=1:L-1
        
        %first triangle
        x1_1=X1(i,j);
        y1_1=Y1(i,j);
        z1_1=Z1(i,j);
        x2_1=X1(i+1,j);
        y2_1=Y1(i+1,j);
        z2_1=Z1(i+1,j);
        x3_1=X1(i+1,j+1);
        y3_1=Y1(i+1,j+1);
        z3_1=Z1(i+1,j+1);
        
        x1_3=X2(i,j);
        y1_3=Y2(i,j);
        z1_3=Z2(i,j);
        x2_3=X2(i+1,j);
        y2_3=Y2(i+1,j);
        z2_3=Z2(i+1,j);
        x3_3=X2(i+1,j+1);
        y3_3=Y2(i+1,j+1);
        z3_3=Z2(i+1,j+1);        
        
        %second triangle
        x1_2=X1(i,j);
        y1_2=Y1(i,j);
        z1_2=Z1(i,j);
        x2_2=X1(i+1,j+1);
        y2_2=Y1(i+1,j+1);
        z2_2=Z1(i+1,j+1);
        x3_2=X1(i,j+1);
        y3_2=Y1(i,j+1);
        z3_2=Z1(i,j+1);
        
        x1_4=X2(i,j);
        y1_4=Y2(i,j);
        z1_4=Z2(i,j);
        x2_4=X2(i+1,j+1);
        y2_4=Y2(i+1,j+1);
        z2_4=Z2(i+1,j+1);
        x3_4=X2(i,j+1);
        y3_4=Y2(i,j+1);
        z3_4=Z2(i,j+1);
        
        %plot the two triangles
        figure(1)
        hold on
        fill3([x1_1 x2_1 x3_1 x1_1],[y1_1 y2_1 y3_1 y1_1],[z1_1 z2_1 z3_1 z1_1],'b')
        fill3([x1_2 x2_2 x3_2 x1_2],[y1_2 y2_2 y3_2 y1_2],[z1_2 z2_2 z3_2 z1_2],'b')
        fill3([x1_3 x2_3 x3_3 x1_3],[y1_3 y2_3 y3_3 y1_3],[z1_3 z2_3 z3_3 z1_3],'b')
        fill3([x1_4 x2_4 x3_4 x1_4],[y1_4 y2_4 y3_4 y1_4],[z1_4 z2_4 z3_4 z1_4],'b')
%         pause
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_1,y1_1,z1_1);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_1,y2_1,z2_1);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_1,y3_1,z3_1);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_2,y1_2,z1_2);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_2,y2_2,z2_2);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_2,y3_2,z3_2);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_3,y1_3,z1_3);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_3,y2_3,z2_3);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_3,y3_3,z3_3);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_4,y1_4,z1_4);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_4,y2_4,z2_4);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_4,y3_4,z3_4);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
    end
end

x1=linspace(xmin,xmax,L);
z1=linspace(zmin,zmax,L);
x1=0.5*id_multiplier*sin(pi*x1/id_multiplier);
z1=2*id_multiplier*sin(pi*z1/id_multiplier/4);
%converts 1*L vectors to L*L matrices
[X1,Z1]=meshgrid(x1,z1);
X2 = X1;Z2 = Z1;
%calculate corresponding Z-values
Y1=-ones(L,L)*id_multiplier;
Y2=ones(L,L)*id_multiplier;

for i=1:L-1
    for j=1:L-1
        
        %first triangle
        x1_1=X1(i,j);
        y1_1=Y1(i,j);
        z1_1=Z1(i,j);
        x2_1=X1(i+1,j);
        y2_1=Y1(i+1,j);
        z2_1=Z1(i+1,j);
        x3_1=X1(i+1,j+1);
        y3_1=Y1(i+1,j+1);
        z3_1=Z1(i+1,j+1);
        
        x1_3=X2(i,j);
        y1_3=Y2(i,j);
        z1_3=Z2(i,j);
        x2_3=X2(i+1,j);
        y2_3=Y2(i+1,j);
        z2_3=Z2(i+1,j);
        x3_3=X2(i+1,j+1);
        y3_3=Y2(i+1,j+1);
        z3_3=Z2(i+1,j+1);        
        
        %second triangle
        x1_2=X1(i,j);
        y1_2=Y1(i,j);
        z1_2=Z1(i,j);
        x2_2=X1(i+1,j+1);
        y2_2=Y1(i+1,j+1);
        z2_2=Z1(i+1,j+1);
        x3_2=X1(i,j+1);
        y3_2=Y1(i,j+1);
        z3_2=Z1(i,j+1);
        
        x1_4=X2(i,j);
        y1_4=Y2(i,j);
        z1_4=Z2(i,j);
        x2_4=X2(i+1,j+1);
        y2_4=Y2(i+1,j+1);
        z2_4=Z2(i+1,j+1);
        x3_4=X2(i,j+1);
        y3_4=Y2(i,j+1);
        z3_4=Z2(i,j+1);
        
        %plot the two triangles
        figure(1)
        hold on
        fill3([x1_1 x2_1 x3_1 x1_1],[y1_1 y2_1 y3_1 y1_1],[z1_1 z2_1 z3_1 z1_1],'b')
        fill3([x1_2 x2_2 x3_2 x1_2],[y1_2 y2_2 y3_2 y1_2],[z1_2 z2_2 z3_2 z1_2],'b')
        fill3([x1_3 x2_3 x3_3 x1_3],[y1_3 y2_3 y3_3 y1_3],[z1_3 z2_3 z3_3 z1_3],'b')
        fill3([x1_4 x2_4 x3_4 x1_4],[y1_4 y2_4 y3_4 y1_4],[z1_4 z2_4 z3_4 z1_4],'b')
%         pause
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_1,y1_1,z1_1);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_1,y2_1,z2_1);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_1,y3_1,z3_1);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_2,y1_2,z1_2);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_2,y2_2,z2_2);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_2,y3_2,z3_2);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_3,y1_3,z1_3);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_3,y2_3,z2_3);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_3,y3_3,z3_3);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
        
        %write in the STL file the vertices of the first triangle
        fprintf(fid,'%s \n',' facet normal 0 0 0');
        fprintf(fid,'%s\n','  outer loop');
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x1_4,y1_4,z1_4);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x2_4,y2_4,z2_4);
        fprintf(fid,'%s %12.9f  %12.9f %12.9f\n','   vertex', x3_4,y3_4,z3_4);
        fprintf(fid,'%s\n','  endloop');
        fprintf(fid,'%s\n',' endfacet');
    end
end

fprintf(fid,'%s \n','endsolid solid ig_0.4_1');
fclose(fid)

figure(1)
axis image
set(gcf,'color',[1 1 1])

