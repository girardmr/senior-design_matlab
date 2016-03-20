
load('van_beats_regroup.mat')

subj=fieldnames(van_beats_regroup);
phrases=fieldnames(van_beats_regroup.(subj{1}));
type=fieldnames(van_beats_regroup.(subj{1}).(phrases{1}));

for i=1:length(subj)
    for j=1:length(phrases)
        phase1=[];
        phase2=[];
        for k=1:length(van_beats_regroup.(subj{i}).(phrases{j}).(type{4}).avect)
            phase1=vertcat(phase1,van_beats_regroup.(subj{i}).(phrases{j}).(type{4}).avect(k)/0.666);
            phase2=vertcat(phase2,van_beats_regroup.(subj{i}).(phrases{j}).(type{4}).cvect(k)/0.666);
            van_beats_regroup.(subj{i}).(phrases{j}).(type{4}).phase1=phase1;
            van_beats_regroup.(subj{i}).(phrases{j}).(type{4}).phase2=phase2;
        end
        clear phase1 phase2
    end
end
    
save('van_beats_regroup.mat', 'van_beats_regroup');

figure(1)
for i=1:length(phrases)
    subplot(2,3,i)
    h1=rose(((van_beats_regroup.(subj{10}).(phrases{i}).(type{4}).phase2)*2*pi),30);
    x1 = get(h1,'Xdata');
    y1 = get(h1,'Ydata');
    
    g1=patch(x1,y1,'b');

end