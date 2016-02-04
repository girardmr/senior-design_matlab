load('choc_beats_regroup.mat') 

subj=fieldnames(choc_beats_regroup); %participant...a list
phrases=fieldnames(choc_beats_regroup.(subj{1})); %names of all the choc phrases...a list
type=fieldnames(choc_beats_regroup.(subj{1}).(phrases{1})); %certain participant, certain phrase

for i=1:length(subj)
    for m=1:length(phrases)
        times=choc_beats_regroup.(subj{i}).(phrases{m}).speechbeats;
        a=times(1:3:end);
        b=times(2:3:end);
        c=times(3:3:end); %identify snd regroup the three different beats of a phrase 
        choc_beats_regroup.(subj{i}).(phrases{m}).(type{4})=struct('a',a,'b',b,'c',c); %puts each grouped beat back...
        ...in the struct, creates 3 new fields (one for each beat of a phrase)
    end
end
%This loop assigns fields a, b, and c to the choc struct for eahc trial. 
%'a' represents the first syllable, 'b' the second, 'c' the third

for j=1:length(subj)
    for n=1:length(phrases)
        adiff=[];
        asize=length(choc_beats_regroup.(subj{j}).(phrases{n}).(type{4}).a);
        for k=1:asize
            if k>1
                adiff=vertcat(adiff,choc_beats_regroup.(subj{j}).(phrases{n}).(type{4}).a(k)-choc_beats_regroup.(subj{j}).(phrases{n}).(type{4}).a(k-1));
            end
            choc_beats_regroup.(subj{j}).(phrases{n}).(type{4}).adiff=adiff; %difference between all the a beats
        end
        clear adiff
    end
end
%This loop creates the field adiff, which has a vector that represents
%the difference between the first syllables for each trial

clear i j k m n

for j=1:length(subj)
    for m=1:length(phrases)
        cdiff=[];
        bdiff=[];
        csize=length(choc_beats_regroup.(subj{j}).(phrases{m}).(type{4}).c);
        for k=1:csize
            cdiff=vertcat(cdiff,choc_beats_regroup.(subj{j}).(phrases{m}).(type{4}).c(k)-choc_beats_regroup.(subj{j}).(phrases{m}).(type{4}).a(k));
            bdiff=vertcat(bdiff,choc_beats_regroup.(subj{j}).(phrases{m}).(type{4}).b(k)-choc_beats_regroup.(subj{j}).(phrases{m}).(type{4}).a(k));
            choc_beats_regroup.(subj{j}).(phrases{m}).(type{4}).cdiff=cdiff;
            choc_beats_regroup.(subj{j}).(phrases{m}).(type{4}).bdiff=bdiff;
        end
        clear cdiff bdiff
    end
end
%This loop creates the fields bdiff and cdiff, vectors within the struct
%that represent the time between first and second syllables, and first and
%third syllables respectively

clear i j k m n

for i=1:length(subj)
    for n=1:length(phrases)
        phase1=[];
        diffsize=length(choc_beats_regroup.(subj{i}).(phrases{n}).(type{4}).a);
        for l=1:diffsize
            phase1=vertcat(phase1,choc_beats_regroup.(subj{i}).(phrases{n}).(type{4}).bdiff(l)/choc_beats_regroup.(subj{i}).(phrases{n}).(type{4}).cdiff(l));
            choc_beats_regroup.(subj{i}).(phrases{n}).(type{4}).phase1=phase1; 
        end
        clear phase1
    end
end
%This loop creates the fields phase1 and phase1, vectors within the stuct
%that represent the phase of the third (cdiff divided by adiff) and second
%(bdiff divided by adiff) syllables respectively

clear i j k l

save('choc_beats_regroup.mat', 'choc_beats_regroup');

figure(1)
for i=1:length(phrases)
    subplot(2,3,i)
    h1=rose((choc_beats_regroup.(subj{12}).(phrases{i}).(type{4}).phase1)*2*pi,30);
    x1 = get(h1,'Xdata');
    y1 = get(h1,'Ydata');
    
    
%     t = 0 : .01 : 5 * pi;
%     P = polar(t, 5 * ones(size(t)));
%     set(P, 'Visible', 'off')
  
    g1=patch(x1,y1,'b');
end



