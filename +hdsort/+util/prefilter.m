function Y = prefilter(X)

% Bandpass, FIR, LS, Order 151, Fs 32000, stop1 100, pass1 150, stop2
% 10000, pass2 10500, Wstop1 2, Wpass 1, Wstop2 1
% b = [-0.00380940249992598,-0.00440928921962132,-0.00364786179282231,-0.00386674243817075,-0.00487548408696818,-0.00406777902248233,-0.00386425591264219,-0.00527661248447914,-0.00460263803222821,-0.00383127159215120,-0.00556981685864704,-0.00525327177912237,-0.00381038756905096,-0.00571547811386106,-0.00600362960587271,-0.00385481600314680,-0.00568314920504982,-0.00681866604429803,-0.00402390123814376,-0.00545752155445641,-0.00764410044012373,-0.00437706336246660,-0.00504374918590350,-0.00840833571467823,-0.00496662679701450,-0.00447146286403762,-0.00902660469026614,-0.00583016236884439,-0.00379689813548642,-0.00940716408601985,-0.00698307576671531,-0.00310273550190937,-0.00945910688124448,-0.00841219390400486,-0.00249549855376825,-0.00910114250742463,-0.0100710178682410,-0.00210066192644046,-0.00827052899992464,-0.0118771160263900,-0.00205597058088079,-0.00693125458404810,-0.0137118127086324,-0.00250386045799435,-0.00508057301125389,-0.0154218629242652,-0.00358432343892426,-0.00275310203564754,-0.0168221232591154,-0.00543017661110152,-2.18913649745395e-05,-0.0176971400740430,-0.00816776266413221,0.00300386194389615,-0.0177975391994473,-0.0119284119994513,0.00618445275274091,-0.0168225523626187,-0.0168818395444675,0.00935832856656924,-0.0143679873976752,-0.0233195785066885,0.0123531235977932,-0.00978128614611268,-0.0318737501034854,0.0149981582118832,-0.00172072783593833,-0.0441963190761011,0.0171373205662070,0.0135296865287403,-0.0658430081238406,0.0186411775630260,0.0524363761122201,-0.129854323282922,0.0194172078528392,0.528149275554211,0.528149275554211,0.0194172078528392,-0.129854323282922,0.0524363761122201,0.0186411775630260,-0.0658430081238406,0.0135296865287403,0.0171373205662070,-0.0441963190761011,-0.00172072783593833,0.0149981582118832,-0.0318737501034854,-0.00978128614611268,0.0123531235977932,-0.0233195785066885,-0.0143679873976752,0.00935832856656924,-0.0168818395444675,-0.0168225523626187,0.00618445275274091,-0.0119284119994513,-0.0177975391994473,0.00300386194389615,-0.00816776266413221,-0.0176971400740430,-2.18913649745395e-05,-0.00543017661110152,-0.0168221232591154,-0.00275310203564754,-0.00358432343892426,-0.0154218629242652,-0.00508057301125389,-0.00250386045799435,-0.0137118127086324,-0.00693125458404810,-0.00205597058088079,-0.0118771160263900,-0.00827052899992464,-0.00210066192644046,-0.0100710178682410,-0.00910114250742463,-0.00249549855376825,-0.00841219390400486,-0.00945910688124448,-0.00310273550190937,-0.00698307576671531,-0.00940716408601985,-0.00379689813548642,-0.00583016236884439,-0.00902660469026614,-0.00447146286403762,-0.00496662679701450,-0.00840833571467823,-0.00504374918590350,-0.00437706336246660,-0.00764410044012373,-0.00545752155445641,-0.00402390123814376,-0.00681866604429803,-0.00568314920504982,-0.00385481600314680,-0.00600362960587271,-0.00571547811386106,-0.00381038756905096,-0.00525327177912237,-0.00556981685864704,-0.00383127159215120,-0.00460263803222821,-0.00527661248447914,-0.00386425591264219,-0.00406777902248233,-0.00487548408696818,-0.00386674243817075,-0.00364786179282231,-0.00440928921962132,-0.00380940249992598;];

% Bandpass, FIR, LS, Order 251, Fs 32000, stop1 300, pass1 350, stop2
% 9000, pass2 9500, Wstop1 2, Wpass 1, Wstop2 1
b = [-0.00242954143507786,-0.00247521474818249,-0.00192887656078363,-0.00230663150087578,-0.00288094562146412,-0.00229978009876855,-0.00202891499537124,-0.00286981832911902,-0.00280474188330959,-0.00191428715256196,-0.00239272412498649,-0.00309721638439980,-0.00215817801271176,-0.00172733877533782,-0.00282562930628543,-0.00260954849238963,-0.00132173804664058,-0.00194768381910718,-0.00280096426749888,-0.00144038045512435,-0.000857091502882211,-0.00227554573796860,-0.00188028477884940,-0.000158216458866856,-0.000995137110945710,-0.00203001378488569,-0.000199512002459645,0.000512533639351232,-0.00130469387096980,-0.000718128996143478,0.00146050791530581,0.000334387230354434,-0.000932383868735744,0.00140183709457919,0.00220776494077094,-0.000103483509731651,0.000669537776329664,0.00331897076824666,0.00181404436818597,0.000245769829132103,0.00310855974856754,0.00397036903754844,0.00105278894945027,0.00199312934018550,0.00513063173565808,0.00314986783861777,0.00119075663220623,0.00460865477349383,0.00549537735926194,0.00184119809463010,0.00292170600195197,0.00658272493550073,0.00402484353213905,0.00156619398196182,0.00558276700021835,0.00648146210408938,0.00193967572689054,0.00313451340180500,0.00739105312088362,0.00415117442945382,0.00106468067782743,0.00576015790737554,0.00668649692263075,0.00107844576939451,0.00237455880267171,0.00735660636384727,0.00332214066657362,-0.000543264088737767,0.00497221536976046,0.00597988341970449,-0.000915409042747053,0.000494375707848916,0.00641582815411962,0.00145451053837033,-0.00337359471470336,0.00319499852112183,0.00438426108569187,-0.00409049412909101,-0.00251572315117180,0.00467871583784247,-0.00138638440760159,-0.00741748386747717,0.000574884507445697,0.00210294456277945,-0.00837113587670704,-0.00652568091296547,0.00245498847679905,-0.00498417681738730,-0.0125673320412017,-0.00256308883067024,-0.000462262268995365,-0.0135979830902647,-0.0112991678628116,0.000282517217036653,-0.00899319639732475,-0.0187035432985222,-0.00571296160534666,-0.00267784317158877,-0.0196379296542092,-0.0165806074519422,-0.000987893431022386,-0.0129819281464772,-0.0259144114973322,-0.00814725261301596,-0.00353635484246380,-0.0266681933394240,-0.0223053874941927,0.000164023061495241,-0.0164919326415198,-0.0351731301419000,-0.00864316379928467,-0.000963551003171829,-0.0361900542081375,-0.0293354794657322,0.00779413142226569,-0.0191031638390150,-0.0517428511357310,-0.00354380101886890,0.0131087433461267,-0.0581802838695051,-0.0453040321267077,0.0484009466002948,-0.0204953197521830,-0.144660372905124,0.0713593714187471,0.477035767703275,0.477035767703275,0.0713593714187471,-0.144660372905124,-0.0204953197521830,0.0484009466002948,-0.0453040321267077,-0.0581802838695051,0.0131087433461267,-0.00354380101886890,-0.0517428511357310,-0.0191031638390150,0.00779413142226569,-0.0293354794657322,-0.0361900542081375,-0.000963551003171829,-0.00864316379928467,-0.0351731301419000,-0.0164919326415198,0.000164023061495241,-0.0223053874941927,-0.0266681933394240,-0.00353635484246380,-0.00814725261301596,-0.0259144114973322,-0.0129819281464772,-0.000987893431022386,-0.0165806074519422,-0.0196379296542092,-0.00267784317158877,-0.00571296160534666,-0.0187035432985222,-0.00899319639732475,0.000282517217036653,-0.0112991678628116,-0.0135979830902647,-0.000462262268995365,-0.00256308883067024,-0.0125673320412017,-0.00498417681738730,0.00245498847679905,-0.00652568091296547,-0.00837113587670704,0.00210294456277945,0.000574884507445697,-0.00741748386747717,-0.00138638440760159,0.00467871583784247,-0.00251572315117180,-0.00409049412909101,0.00438426108569187,0.00319499852112183,-0.00337359471470336,0.00145451053837033,0.00641582815411962,0.000494375707848916,-0.000915409042747053,0.00597988341970449,0.00497221536976046,-0.000543264088737767,0.00332214066657362,0.00735660636384727,0.00237455880267171,0.00107844576939451,0.00668649692263075,0.00576015790737554,0.00106468067782743,0.00415117442945382,0.00739105312088362,0.00313451340180500,0.00193967572689054,0.00648146210408938,0.00558276700021835,0.00156619398196182,0.00402484353213905,0.00658272493550073,0.00292170600195197,0.00184119809463010,0.00549537735926194,0.00460865477349383,0.00119075663220623,0.00314986783861777,0.00513063173565808,0.00199312934018550,0.00105278894945027,0.00397036903754844,0.00310855974856754,0.000245769829132103,0.00181404436818597,0.00331897076824666,0.000669537776329664,-0.000103483509731651,0.00220776494077094,0.00140183709457919,-0.000932383868735744,0.000334387230354434,0.00146050791530581,-0.000718128996143478,-0.00130469387096980,0.000512533639351232,-0.000199512002459645,-0.00203001378488569,-0.000995137110945710,-0.000158216458866856,-0.00188028477884940,-0.00227554573796860,-0.000857091502882211,-0.00144038045512435,-0.00280096426749888,-0.00194768381910718,-0.00132173804664058,-0.00260954849238963,-0.00282562930628543,-0.00172733877533782,-0.00215817801271176,-0.00309721638439980,-0.00239272412498649,-0.00191428715256196,-0.00280474188330959,-0.00286981832911902,-0.00202891499537124,-0.00229978009876855,-0.00288094562146412,-0.00230663150087578,-0.00192887656078363,-0.00247521474818249,-0.00242954143507786;];

% Bandpass, FIR, LS, Order 251, Fs 32000, stop1 400, pass1 450, stop2
% 9000, pass2 9500, Wstop1 2, Wpass 1, Wstop2 1
% b = [0.00287441696955001,0.00270865191590348,0.00185927912648363,0.00229971146395842,0.00282388689402423,0.00179056230653138,0.00140408626031984,0.00241147046180969,0.00194572942431351,0.000615782473932746,0.00133735742950635,0.00196004654644894,0.000313191158501499,-0.000109575559945616,0.00134949506048422,0.000487587400240377,-0.00130551210490060,-8.22090906138443e-05,0.000646296127396525,-0.00169523354779694,-0.00195404863818430,0.000111702123989811,-0.00125275703028538,-0.00342199288071519,-0.00143127351852601,-0.000621834938883943,-0.00371197534795991,-0.00353840412487060,-0.000735235436566839,-0.00273533749000770,-0.00513180758529796,-0.00210026676163027,-0.00130063051638387,-0.00517358367325559,-0.00425818616048987,-0.000656676717367989,-0.00346912323044211,-0.00589588407167827,-0.00158778162732768,-0.000986604022618010,-0.00566293868378814,-0.00368763767165250,0.000659269410091029,-0.00319505072639238,-0.00542008255194554,0.000318599110744637,0.000413628691935109,-0.00507054601575545,-0.00173778716947409,0.00315485120890360,-0.00201772952389790,-0.00377894069751693,0.00342879315218209,0.00258832485709271,-0.00367525484804185,0.00127327259671809,0.00635055593275807,-0.000437983464263745,-0.00143527633511360,0.00714658593569015,0.00483846070236508,-0.00210973973256551,0.00466928239318221,0.00941376253357336,0.000734864101646369,0.000862061486859473,0.0105882916358816,0.00621446582734849,-0.00120865462088159,0.00758169648671328,0.0113388196432972,0.000576354380968313,0.00228475765859661,0.0127998396586505,0.00574087279418953,-0.00177281393232575,0.00919559151098278,0.0111933962518121,-0.00170305606825599,0.00218705819081814,0.0130168515604651,0.00266625297568974,-0.00430981757646401,0.00901427631517410,0.00835967398436122,-0.00652318244302895,0.000358687519657267,0.0108954214862813,-0.00334284068619148,-0.00882010558315964,0.00707804787929020,0.00268763600940304,-0.0137923958298712,-0.00278473169389761,0.00664513140422900,-0.0121524542236146,-0.0146795333738749,0.00410198152200676,-0.00552585435468172,-0.0229307960171196,-0.00606963563882736,0.00102020056635620,-0.0233707086927112,-0.0206110612865298,0.00159362903347715,-0.0158648854387902,-0.0331499500713128,-0.00729226510486354,-0.00483681206329606,-0.0371460355628932,-0.0245506053940775,0.00239746556578180,-0.0289739453745844,-0.0443744651432658,-0.00154619090382382,-0.00966259117231814,-0.0577922746271567,-0.0219372752352978,0.0153918644464524,-0.0539501212061951,-0.0633373033260510,0.0384368675085224,-0.0123830557187654,-0.153528875197784,0.0521509723371856,0.479537464442856,0.479537464442856,0.0521509723371856,-0.153528875197784,-0.0123830557187654,0.0384368675085224,-0.0633373033260510,-0.0539501212061951,0.0153918644464524,-0.0219372752352978,-0.0577922746271567,-0.00966259117231814,-0.00154619090382382,-0.0443744651432658,-0.0289739453745844,0.00239746556578180,-0.0245506053940775,-0.0371460355628932,-0.00483681206329606,-0.00729226510486354,-0.0331499500713128,-0.0158648854387902,0.00159362903347715,-0.0206110612865298,-0.0233707086927112,0.00102020056635620,-0.00606963563882736,-0.0229307960171196,-0.00552585435468172,0.00410198152200676,-0.0146795333738749,-0.0121524542236146,0.00664513140422900,-0.00278473169389761,-0.0137923958298712,0.00268763600940304,0.00707804787929020,-0.00882010558315964,-0.00334284068619148,0.0108954214862813,0.000358687519657267,-0.00652318244302895,0.00835967398436122,0.00901427631517410,-0.00430981757646401,0.00266625297568974,0.0130168515604651,0.00218705819081814,-0.00170305606825599,0.0111933962518121,0.00919559151098278,-0.00177281393232575,0.00574087279418953,0.0127998396586505,0.00228475765859661,0.000576354380968313,0.0113388196432972,0.00758169648671328,-0.00120865462088159,0.00621446582734849,0.0105882916358816,0.000862061486859473,0.000734864101646369,0.00941376253357336,0.00466928239318221,-0.00210973973256551,0.00483846070236508,0.00714658593569015,-0.00143527633511360,-0.000437983464263745,0.00635055593275807,0.00127327259671809,-0.00367525484804185,0.00258832485709271,0.00342879315218209,-0.00377894069751693,-0.00201772952389790,0.00315485120890360,-0.00173778716947409,-0.00507054601575545,0.000413628691935109,0.000318599110744637,-0.00542008255194554,-0.00319505072639238,0.000659269410091029,-0.00368763767165250,-0.00566293868378814,-0.000986604022618010,-0.00158778162732768,-0.00589588407167827,-0.00346912323044211,-0.000656676717367989,-0.00425818616048987,-0.00517358367325559,-0.00130063051638387,-0.00210026676163027,-0.00513180758529796,-0.00273533749000770,-0.000735235436566839,-0.00353840412487060,-0.00371197534795991,-0.000621834938883943,-0.00143127351852601,-0.00342199288071519,-0.00125275703028538,0.000111702123989811,-0.00195404863818430,-0.00169523354779694,0.000646296127396525,-8.22090906138443e-05,-0.00130551210490060,0.000487587400240377,0.00134949506048422,-0.000109575559945616,0.000313191158501499,0.00196004654644894,0.00133735742950635,0.000615782473932746,0.00194572942431351,0.00241147046180969,0.00140408626031984,0.00179056230653138,0.00282388689402423,0.00229971146395842,0.00185927912648363,0.00270865191590348,0.00287441696955001;];
a = 1;
for i=1:size(X,1)
    Y(i,:) = filtfilt(b, a, X(i,:)); 
end