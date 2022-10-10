function maxLoc=fnFindLocalMax(a,trsh,korInt)

l=length(a);
test=0;
aMax=trsh(1);
dummy=-1000;
maxLoc=[dummy];
aTest=[0];

for i=1:l
    if a(i,1)>trsh
        test=1;
        if a(i,1)>aMax
            aMax=a(i,1);
            maxLocTemp=i;
        end
   elseif test==1
        test=0;        
       if maxLocTemp-maxLoc(end)>korInt
            aTest=[aTest aMax];
            maxLoc=[maxLoc maxLocTemp];
        elseif aMax>aTest(end)
             aTest(end)=aMax;
             maxLoc(end)=maxLocTemp;           
        end        
        aMax=trsh;
        maxLocTemp=0;       
    end
end

if maxLoc(1)==dummy
    maxLoc=maxLoc(2:end);
    aTest=aTest(2:end);
end

fig=figure;
plot(a)
hold on
plot(maxLoc,a(maxLoc),'om')