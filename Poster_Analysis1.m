
load('choc_beats_regroup.mat')

subj=fieldnames(choc_beats_regroup);
phrases=fieldnames(choc_beats_regroup.(subj{1}));
type=fieldnames(choc_beats_regroup.(subj{1}).(phrases{1}));

gl1stat=[];
gl2stat=[];
gl3stat=[];
gl4stat=[];

for i=1:length(subj)
    for j=2:length(phrases)
        gl1stat=vertcat(gl1stat,choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).avect);
        gl2stat=vertcat(gl2stat,choc_beats_regroup.(subj{i}).(phrases{j}).(type{5}).cvect);
    end
    gl3stat=vertcat(abs(gl1stat),abs(gl2stat));
    gl4stat=vertcat(gl4stat, mean(gl3stat));
    gl1stat=[];
    gl2stat=[];
    gl3stat=[];
end

clear i j
gl4stat=[];

load('van_beats_regroup.mat')

phrasesv=fieldnames(van_beats_regroup.(subj{1}));
typev=fieldnames(van_beats_regroup.(subj{1}).(phrases{1}));

for i=1:length(subj)
    for j=1:length(phrasesv)
        gl1stat=vertcat(gl1stat,van_beats_regroup.(subj{i}).(phrasesv{j}).(typev{4}).avect);
        %gl2stat=vertcat(gl2stat,van_beats_regroup.(subj{i}).(phrasesv{j}).(typev{4}).cvect);
    end
    gl3stat=vertcat(abs(gl1stat));
    %,abs(gl2stat));
    gl4stat=vertcat(gl4stat,mean(gl3stat));
    gl1stat=[];
    %gl2stat=[];
    gl3stat=[];
end

%Nuclear Circular correlations

nucchoc= [0.973170697, 0.962116518, 0.956734812, 0.98696911, 0.898658671, 0.964186633, 0.914446209, 0.94662813, 0.970293641, 0.965993123, 0.97431593, 0.977301698];
nucvan= [0.977353845, 0.964350796, 0.95134691, 0.976578794, 0.902041786, 0.969549234, 0.929082678, 0.822465286, 0.963729798, 0.966397369, 0.967595676, 0.981274154];

Spelt= [120,105,112,120,119,111,109,123,117,111,109,105];
Rhythm= [0.79,0.58,0.47,0.81,0.83,0.58,0.65,0.75,0.75,0.74,0.63,0.68];
Compsyn= [0.8333, 0.9167, 0.8333, 0.9167, 0.8333, 0.6667, 0.6667, 1.0000, 0.9167, 0.7500, 0.6667, 0.5833];

newone= [0.976410072, 0.961322497, 0.957353978, 0.983586366, 0.884755802, 0.959358661, 0.912894509, 0.951526772, 0.971791947, 0.963681124, 0.969592112, 0.976250974];

[rho, pval]=circ_corrcl(newone,Spelt)
[rho, pval]=circ_corrcl(newone,Rhythm)
[rho, pval]=circ_corrcl(newone,Compsyn)
[rho, pval]=circ_corrcl(nucvan,Spelt)
[rho, pval]=circ_corrcl(nucvan,Rhythm)
[rho, pval]=circ_corrcl(nucvan,Compsyn)

