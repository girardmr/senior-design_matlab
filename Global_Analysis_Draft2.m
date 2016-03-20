
load('choc_beats_regroup.mat')

subj=fieldnames(choc_beats_regroup);
phrases=fieldnames(choc_beats_regroup.(subj{1}));
type=fieldnames(choc_beats_regroup.(subj{1}).(phrases{1}));

for i=1:length(subj)
    for j=1:length(phrases)
        phase1=[];
        phase2=[];
        for k=1:length(choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).avect)
            phase1=vertcat(phase1,choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).avect(k)/0.666);
            phase2=vertcat(phase2,choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).cvect(k)/0.666);
            choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).phase1=phase1;
            choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).phase2=phase2;
        end
        clear phase1 phase2
    end
end
    
save('choc_beats_regroup.mat', 'choc_beats_regroup');

figure(1)
for i=1:length(phrases)
    subplot(2,3,i)
    h1=rose(((choc_beats_regroup.(subj{10}).(phrases{i}).(type{5}).phase2)*2*pi),30);
    x1 = get(h1,'Xdata');
    y1 = get(h1,'Ydata');
    
    g1=patch(x1,y1,'b');

end