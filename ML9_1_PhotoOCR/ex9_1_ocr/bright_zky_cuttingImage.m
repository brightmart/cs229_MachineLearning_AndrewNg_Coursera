function [superZkyX,superZkyy]=bright_zky_cuttingImage(Xzky,yzky)
%bright_zky_cuttingImage
%load('bright_zky_zkyAllData.mat');
%cutting each image into 4 sperate images.
%x1=ones(10,40);
size1=size(Xzky,1)
size2=size(Xzky,2)
numbersFromAImage=4;
superX=ones(size1*numbersFromAImage,size2/numbersFromAImage); %ones(91*4,400/4)=ones(364,100);
temp=ones(1,size2/numbersFromAImage);
count=1;
superZkyy=zeros(size1*numbersFromAImage,1);
for i=1:size1;
   x=Xzky(i,:);
   yzkyOne=yzky(i);
   for j=1:numbersFromAImage;
     temp= x(1,(j-1)*(size2/numbersFromAImage)+1:j*(size2/numbersFromAImage));
     superZkyX(count,:)=temp;
     if length(num2str(yzkyOne))==3;
         if j==1;
             superZkyy(count)=10;
             count=count+1;
         else
             yzkyOne2=num2str(yzkyOne);
             yOne=yzkyOne2(j-1);
             if strcmp(yOne,'0');
                 yOne='10';
             end;
            superZkyy(count)=str2num(yOne);
            count=count+1;
         end;
     elseif length(num2str(yzkyOne))==4;    
        yzkyOne2=num2str(yzkyOne);
        yOne=yzkyOne2(j);
        if strcmp(yOne,'0');
              yOne='10';
        end;
        superZkyy(count)=str2num(yOne);
        count=count+1;
     end;
   end;
end;

%save('bright_zky_superZkyXy.mat','superZkyX','superZkyy');