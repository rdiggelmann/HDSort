s = 1:5;
nC = 3;
nT = 4;

vte = repmat(s, 1, nC);
vte = repmat(vte, nT, 1) + repmat((0:nT-1)'*10, 1, nC*length(s));


vce = hdsort.waveforms.vte2vce(vte, nC);
vce2 = hdsort.util.embedTime2embedChan(vte, nC);
vte_ = hdsort.waveforms.vce2vte(vce, nC);
vte2_ = hdsort.waveforms.vce2vte(vce2, nC);

vte
vte_
vte2_
vce
vce2