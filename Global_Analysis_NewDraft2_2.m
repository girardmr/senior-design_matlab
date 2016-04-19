
load('choc_beats_regroup.mat')
load('BBA.mat')
load('NewEEG.mat')

subj=fieldnames(choc_beats_regroup);

% for i=1:length(subj)
%     choc_beats_regroup.(subj{i}) = rmfield(choc_beats_regroup.(subj{i}), 'phr01');
% end
% 
% for i=1:length(subj)
%     choc_beats_regroup.(subj{i}) = rmfield(choc_beats_regroup.(subj{i}), 'phr04');
% end

% for i=1:length(subj)
%     choc_beats_regroup.(subj{i}) = rmfield(choc_beats_regroup.(subj{i}), 'circ');
% end

phrases=fieldnames(choc_beats_regroup.(subj{1}));
type=fieldnames(choc_beats_regroup.(subj{1}).(phrases{1}));

asynch1=[];
asynch2=[];

for i=1:length(subj)
    for j=1:length(phrases)
        metrovect1=[];
        metrovect2=[];
        for k=1:length(choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).a)
            if (i==10 && j==2)
                newvect1=choc_beats_regroup.(subj{i}).(phrases{j}).(type{2})(6:2:end);
                metrovect1=newvect1(1:length(choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).a));
                newvect2=choc_beats_regroup.(subj{i}).(phrases{j}).(type{2})(7:2:end);
                newvect2=vertcat(newvect2,(newvect2(end)+0.666));
                metrovect2=newvect2(1:length(choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).a));
                choc_beats_regroup.(subj{i}).(phrases{j}).globals.metrovect1=metrovect1;
                choc_beats_regroup.(subj{i}).(phrases{j}).globals.metrovect2=metrovect2;
            else
                holdvalue=choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).aidx(1);
                newvect1=choc_beats_regroup.(subj{i}).(phrases{j}).(type{2})(holdvalue:2:end);
                metrovect1=newvect1(1:length(choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).a));
                newvect2=choc_beats_regroup.(subj{i}).(phrases{j}).(type{2})((holdvalue+1):2:end);
                metrovect2=newvect2(1:length(choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).a));
                choc_beats_regroup.(subj{i}).(phrases{j}).globals.metrovect1=metrovect1;
                choc_beats_regroup.(subj{i}).(phrases{j}).globals.metrovect2=metrovect2;
            end
        end
    end
end

clear i j k

for i=1:length(subj)
    for j=1:length(phrases)
        asynch1=[];
        asynch2=[];
        for k=1:length(choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).a)
             if abs(choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).a(k)-choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).metrovect1(k))<0.666 ...
                     && abs(choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).c(k)-choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).metrovect2(k))<0.666
                asynch1=vertcat(asynch1,choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).a(k)-choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).metrovect1(k));
                asynch2=vertcat(asynch2,choc_beats_regroup.(subj{i}).(phrases{j}).(type{4}).c(k)-choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).metrovect2(k));
                choc_beats_regroup.(subj{i}).(phrases{j}).globals.asynch=vertcat(asynch1,asynch2);
            end
        end
    end
end

clear i j k

for i=1:length(subj)
    for j=1:length(phrases)
        for k=1:length(choc_beats_regroup.(subj{i}).(phrases{j}).globals.asynch)
            newphase=choc_beats_regroup.(subj{i}).(phrases{j}).globals.asynch/0.666;
            choc_beats_regroup.(subj{i}).(phrases{j}).globals.newphase=newphase;
        end
    end
end
      
clear i j k

for i=1:length(subj)
    for j=1:length(phrases)
        circvect=circ_r((pi*choc_beats_regroup.(subj{i}).(phrases{j}).globals.newphase),[],[],1);
        choc_beats_regroup.(subj{i}).(phrases{j}).globals.circvect=circvect;
    end
end

clear i j k

circstats2=[];
for i=1:length(subj)
    circ=[];
    for j=1:length(phrases)
        circ =vertcat(circ,choc_beats_regroup.(subj{i}).(phrases{j}).globals.newphase);
        choc_beats_regroup.(subj{i}).circ = circ;
    end
    holder=circ_r((pi*circ),[],[],1);
    circstats2=vertcat(circstats2,holder);
end
        
%Chocolate global circular values correlated with other stuff

Spelt= [120,105,112,120,119,111,109,123,117,111,109,105];
Rhythm= [0.79,0.58,0.47,0.81,0.83,0.58,0.65,0.75,0.75,0.74,0.63,0.68];
Compsyn= [0.8333, 0.9167, 0.8333, 0.9167, 0.8333, 0.6667, 0.6667, 1.0000, 0.9167, 0.7500, 0.6667, 0.5833];
Beta = [-248.9,1009.02,2381.5,1848.26,1834.55,883.23,1263.99,662.45,-520.57,54.32,368.01,1274.34];
Evobeta = [-1.96,1.44,2.52,2.79,1.32,1.6,1.08,-0.07,-0.62,0.11,1.23,0.85];
Cluster1 = [17281.44,28278.72,13021.33,11769.17,16804.01,19930.04,12720.79,4019.07,9067.55,-329.09,-950.18,-1195.87];
Cluster2 = [1368.67,6623.87,5324.18,9276.59,-410.09,4633.87,5847.54,1726.59,3868.23,-3120.46,-593.17,532.71];


[rho, pval]=circ_corrcl(circstats2,Spelt)
[rho, pval]=circ_corrcl(circstats2,Rhythm)
[rho, pval]=circ_corrcl(circstats2,Compsyn)
[rho, pval]=circ_corrcl(circstats2,Beta)
[rho, pval]=circ_corrcl(circstats2,Evobeta)
[rho, pval]=circ_corrcl(circstats2,Cluster1)
[rho, pval]=circ_corrcl(circstats2,Cluster2)
[rho, pval]=circ_corrcl(circstats2,NewEEG)
[rho, pval]=circ_corrcl(circstats2,BBA)

%Good and Poor Synchronizer plots

% for m=1:length(subj)
%     circ=[];
%     for n=1:length(phrases)
%        circ =vertcat(circ,choc_beats_regroup.(subj{m}).(phrases{n}).(type{5}).newphase);
%        choc_beats_regroup.(subj{m}).circ = circ;
%     end
% end



figure(1)
h1=rose(((choc_beats_regroup.(subj{2}).circ)*pi)); %This plot is a poor synchronizer
x1 = get(h1,'Xdata');
y1 = get(h1,'Ydata');
g1=patch(x1,y1,'b');
figure(2)
h2=rose(((choc_beats_regroup.(subj{4}).circ)*pi)); %This plot is a good synchronizer
x2 = get(h2,'Xdata');
y2 = get(h2,'Ydata');
g2=patch(x2,y2,'b');

figure(3)
h2=rose((choc_beats_regroup.(subj{6}).(phrases{2}).globals.newphase*2*pi)); %Just phrase 2 of subject 6
x2 = get(h2,'Xdata');
y2 = get(h2,'Ydata');
g2=patch(x2,y2,'b');








%Order for Item Analysis:
%This, NewDraft,NewDraft2, Period_Analysis






