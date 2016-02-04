load('choc_beats_regroup.mat')

subj=fieldnames(choc_beats_regroup);
type=fieldnames(choc_beats_regroup.(subj{1}).(phrases{1}));
globals=[];

for i=1:length(subj)
    choc_beats_regroup.(subj{i}) = rmfield(choc_beats_regroup.(subj{i}), 'phr01'); %removes phrase 1 from struct, fills with zeros?
end

phrases=fieldnames(choc_beats_regroup.(subj{1}));

x=choc_beats_regroup.(subj{10}).(phrases{1}).(type{2});
y1=zeros(length(choc_beats_regroup.(subj{10}).(phrases{1}).(type{2})),1);
z=choc_beats_regroup.(subj{10}).(phrases{1}).(type{1});
y2=ones(length(choc_beats_regroup.(subj{10}).(phrases{1}).(type{1})),1);
%plotting metronome beats with the speech beats

figure(1)
plot(x,y1,'bo',z,y2,'go')
axis([-5 30 -10 10])

firstvect=choc_beats_regroup.(subj{1}).(phrases{1}).(type{2});
newvect1=firstvect(8:2:end);
newvect2=firstvect(9:2:end);

asynch1=[];
asynch2=[];
for j=1:length(choc_beats_regroup.(subj{1}).(phrases{1}).(type{4}).a)
    if abs(choc_beats_regroup.(subj{1}).(phrases{1}).(type{4}).a(j)-newvect1(j))<0.666 && abs(choc_beats_regroup.(subj{1}).(phrases{1}).(type{4}).c(j)-newvect2(j))<0.666
        asynch1=vertcat(asynch1,abs(choc_beats_regroup.(subj{1}).(phrases{1}).(type{4}).a(j)-newvect1(j)));
        asynch2=vertcat(asynch2,abs(choc_beats_regroup.(subj{1}).(phrases{1}).(type{4}).c(j)-newvect2(j)));
    end
end
    
phase1=asynch1./0.666;
phase2=asynch2./0.666;

figure(2)
h1=rose((phase1*2*pi));
x1 = get(h1,'Xdata');
y1 = get(h1,'Ydata');
g1=patch(x1,y1,'b');
figure(3)
h2=rose((phase2*2*pi));
x2 = get(h2,'Xdata');
y2 = get(h2,'Ydata');
g2=patch(x2,y2,'b');


circvect1=circ_r((2*pi*phase1),[],[],1)
circvect2=circ_r((2*pi*phase2),[],[],1)

save 'choc_beats_regroup.mat'
