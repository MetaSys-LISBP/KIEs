# 2014-28-08 millard@insa-toulouse.fr
#
# Model of the glycolytic and pentose phosphate pathways of E. coli
# published in the following paper:
#
#   Impact of kinetic isotope effects in isotope labeling experiments
#   by P. Millard, S. Sokol, J.C. Portais and P. Mendes
#
# A graphical representation of this network in SBGN format can be
# found in Figure 2 of the paper.
#
# 'rxn' : list containing the topology of the metabolic network, the
#         carbon atom transitions, and the rate laws
# 'kp'  : named vector of parameters
#
# note: in this version, reversible reactions are not converted to two
#       irreversible reactions, hence isotope exchange between
#       metabolite pools is not taken into account
#
# Copyright 2014, INRA, France
# License: GNU General Public License v2 (see license.txt for details)

# network definition
#         reaction              substrate(s)         product(s)            carbon atom transitions                  rate law
rxn=list('PTS'=           list('su'=c('GLC','PEP'), 'pr'=c('G6P','PYR'),  'tr'=c('abcdef','ghi','abcdef','ghi'),   'eq'="65*PTSrmaxPTS*GLC*(PEP/PYR)/((PTSKPTSa1+PTSKPTSa2*(PEP/PYR)+PTSKPTSa3*GLC+GLC*(PEP/PYR))*(1+G6P**PTSnPTSg6p/PTSKPTSg6p))"),
         'PGI'=           list('su'=c('G6P',''),    'pr'=c('F6P',''),     'tr'=c('abcdef','','abcdef',''),         'eq'="PGIrmaxPGI*(G6P-F6P/PGIKPGIeq)/(PGIKPGIg6p*(1+F6P/(PGIKPGIf6p*(1+PGN/PGIKPGIf6ppginh))+PGN/PGIKPGIg6ppginh)+G6P)"),
         'GPM'=           list('su'=c('G6P',''),    'pr'=c('G1P',''),     'tr'=c('abcdef','','abcdef',''),         'eq'="PGMrmaxPGM*(G6P-G1P/PGMKPGMeq)/(PGMKPGMg6p*(1+G1P/PGMKPGMg1p)+G6P)"),
         'G6PDH'=         list('su'=c('G6P',''),    'pr'=c('PGN',''),     'tr'=c('abcdef','','abcdef',''),         'eq'="G6PDHrmaxG6PDH*G6P*cnadp/((G6P+G6PDHKG6PDHg6p)*(1+cnadph/G6PDHKG6PDHnadphg6pinh)*(G6PDHKG6PDHnadp*(1+cnadph/G6PDHKG6PDHnadphnadpinh)+cnadp))"),
         'PFK'=           list('su'=c('F6P',''),    'pr'=c('FBP',''),     'tr'=c('abcdef','','abcdef',''),         'eq'="PFKrmaxPFK*catp*F6P/((catp+PFKKPFKatps*(1+cadp/PFKKPFKadpc))*(F6P+PFKKPFKf6ps*(1+PEP/PFKKPFKpep+cadp/PFKKPFKadpb+camp/PFKKPFKampb)/(1+cadp/PFKKPFKadpa+camp/PFKKPFKampa))*(1+PFKLPFK/(1+F6P*(1+cadp/PFKKPFKadpa+camp/PFKKPFKampa)/(PFKKPFKf6ps*(1+PEP/PFKKPFKpep+cadp/PFKKPFKadpb+camp/PFKKPFKampb)))**PFKnPFK))"),
         'TA'=            list('su'=c('GAP','S7P'), 'pr'=c('F6P','E4P'),  'tr'=c('abc','defghij','defabc','ghij'), 'eq'="TArmaxTA*(GAP*S7P-E4P*F6P/TAKTAeq)"),
         'TK1'=           list('su'=c('R5P','X5P'), 'pr'=c('GAP','S7P'),  'tr'=c('abcde','fghij','cde','abfghij'), 'eq'="TK1rmaxTKa*(R5P*X5P-S7P*GAP/TK1KTKaeq)"),
         'TK2'=           list('su'=c('E4P','X5P'), 'pr'=c('GAP','F6P'),  'tr'=c('abcd','efghi','ghi','efabcd'),   'eq'="TK2rmaxTKb*(X5P*E4P-F6P*GAP/TK2KTKbeq)"),
         'MURSYN'=        list('su'=c('F6P',''),    'pr'=c('',''),        'tr'=c('abcdef','','',''),               'eq'="MURSYNv*2"),
         'ALD'=           list('su'=c('FBP',''),    'pr'=c('DHAP','GAP'), 'tr'=c('abcdef','','cba','def'),         'eq'="ALDrmaxALDO*(FBP-GAP*DHAP/ALDkALDOeq)/(ALDkALDOfdp+FBP+ALDkALDOgap*DHAP/(ALDkALDOeq*ALDVALDOblf)+ALDkALDOdhap*GAP/(ALDkALDOeq*ALDVALDOblf)+FBP*GAP/ALDkALDOgapinh+GAP*DHAP/(ALDVALDOblf*ALDkALDOeq))"),
         'GAPDH'=         list('su'=c('GAP',''),    'pr'=c('BPG',''),     'tr'=c('abc','','abc',''),               'eq'="GAPDHrmaxGAPDH*(GAP*cnad-BPG*cnadh/GAPDHKGAPDHeq)/((GAPDHKGAPDHgap*(1+BPG/GAPDHKGAPDHpgp)+GAP)*(GAPDHKGAPDHnad*(1+cnadh/GAPDHKGAPDHnadh)+cnad))"),
         'TPI'=           list('su'=c('DHAP',''),   'pr'=c('GAP',''),     'tr'=c('abc','','cba',''),               'eq'="TPIrmaxTIS*(DHAP-GAP/TPIkTISeq)/(TPIkTISdhap*(1+GAP/TPIkTISgap)+DHAP)"),
         'GDH'=           list('su'=c('DHAP',''),   'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="GDHrmaxG3PDH*DHAP/(GDHKG3PDHdhap+DHAP)"),
         'PGK'=           list('su'=c('BPG',''),    'pr'=c('PG3',''),     'tr'=c('abc','','abc',''),               'eq'="PGKrmaxPGK*(cadp*BPG-catp*PG3/PGKKPGKeq)/((PGKKPGKadp*(1+catp/PGKKPGKatp)+cadp)*(PGKKPGKpgp*(1+PG3/PGKKPGKpg3)+BPG))"),
         'SERSYN'=        list('su'=c('PG3',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="SERSYNrmaxSerSynth*PG3/(SERSYNKSerSynthpg3+PG3)"),
         'PGM'=           list('su'=c('PG3',''),    'pr'=c('PG2',''),     'tr'=c('abc','','abc',''),               'eq'="PGMrmaxPGluMu*(PG3-PG2/PGMKPGluMueq)/(PGMKPGluMupg3*(1+PG2/PGMKPGluMupg2)+PG3)"),
         'ENO'=           list('su'=c('PG2',''),    'pr'=c('PEP',''),     'tr'=c('abc','','abc',''),               'eq'="ENOrmaxENO*(PG2-PEP/ENOKENOeq)/(ENOKENOpg2*(1+PEP/ENOKENOpep)+PG2)"),
         'PYK'=           list('su'=c('PEP',''),    'pr'=c('PYR',''),     'tr'=c('abc','','abc',''),               'eq'="PYKrmaxPK*PEP*(PEP/PYKKPKpep+1)**(PYKnPK-1)*cadp/(PYKKPKpep*(PYKLPK*((1+catp/PYKKPKatp)/(FBP/PYKKPKfdp+camp/PYKKPKamp+1))**PYKnPK+(PEP/PYKKPKpep+1)**PYKnPK)*(cadp+PYKKPKadp))"),
         'PPC'=           list('su'=c('PEP',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="PPCrmaxpepCxylase*PEP*(1+(FBP/PPCKpepCxylasefdp)**PPCnpepCxylasefdp)/(PPCKpepCxylasepep+PEP)"),
         'SYN1'=          list('su'=c('PEP',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="SYN1rmaxSynth1*PEP/(SYN1KSynth1pep+PEP)"),
         'SYN2'=          list('su'=c('PYR',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="SYN2rmaxSynth2*PYR/(SYN2KSynth2pyr+PYR)"),
         'DAHPSYN'=       list('su'=c('E4P','PEP'), 'pr'=c('',''),        'tr'=c('abcd','efg','',''),              'eq'="DAHPSYNrmaxDAHPS*E4P**DAHPSYNnDAHPSe4p*PEP**DAHPSYNnDAHPSpep/((DAHPSYNKDAHPSe4p+E4P**DAHPSYNnDAHPSe4p)*(DAHPSYNKDAHPSpep+PEP**DAHPSYNnDAHPSpep))"),
         'PDH'=           list('su'=c('PYR',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="PDHrmaxPDH*PYR**PDHnPDH/(PDHKPDHpyr+PYR**PDHnPDH)"),
         'GND'=           list('su'=c('PGN',''),    'pr'=c('RB5P',''),    'tr'=c('abcdef','','abcde',''),          'eq'="GNDrmaxPGDH*PGN*cnadp/((PGN+GNDKPGDHpg)*(cnadp+GNDKPGDHnadp*(1+cnadph/GNDKPGDHnadphinh)*(1+catp/GNDKPGDHatpinh)))"),
         'RPI'=           list('su'=c('RB5P',''),   'pr'=c('R5P',''),     'tr'=c('abcde','','abcde',''),           'eq'="RPIrmaxR5PI*(RB5P-R5P/RPIKR5PIeq)"),
         'RPE'=           list('su'=c('RB5P',''),   'pr'=c('X5P',''),     'tr'=c('abcde','','abcde',''),           'eq'="RPErmaxRu5P*(RB5P-X5P/RPEKRu5Peq)"),
         'RPP'=           list('su'=c('R5P',''),    'pr'=c('',''),        'tr'=c('abcde','','',''),                'eq'="RPPrmaxRPPK*R5P/(RPPKRPPKrib5p+R5P)"),
         'G1PAT'=         list('su'=c('G1P',''),    'pr'=c('',''),        'tr'=c('abcdef','','',''),               'eq'="G1PATrmaxG1PAT*G1P*catp*(1+(FBP/G1PATKG1PATfdp)**G1PATnG1PATfdp)/((G1PATKG1PATatp+catp)*(G1PATKG1PATg1p+G1P))"),
         'G6Pdilution'=   list('su'=c('G6P',''),    'pr'=c('',''),        'tr'=c('abcdef','','',''),               'eq'="mu*G6P"),
         'F6Pdilution'=   list('su'=c('F6P',''),    'pr'=c('',''),        'tr'=c('abcdef','','',''),               'eq'="mu*F6P"),
         'FDPdilution'=   list('su'=c('FBP',''),    'pr'=c('',''),        'tr'=c('abcdef','','',''),               'eq'="mu*FBP"),
         'GAPdilution'=   list('su'=c('GAP',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="mu*GAP"),
         'DHAPdilution'=  list('su'=c('DHAP',''),   'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="mu*DHAP"),
         'BPGdilution'=   list('su'=c('BPG',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="mu*BPG"),
         'PG3dilution'=   list('su'=c('PG3',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="mu*PG3"),
         'PG2dilution'=   list('su'=c('PG2',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="mu*PG2"),
         'PEPdilution'=   list('su'=c('PEP',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="mu*PEP"),
         'RB5Pdilution'=  list('su'=c('RB5P',''),   'pr'=c('',''),        'tr'=c('abcde','','',''),                'eq'="mu*RB5P"),
         'R5Pdilution'=   list('su'=c('R5P',''),    'pr'=c('',''),        'tr'=c('abcde','','',''),                'eq'="mu*R5P"),
         'X5Pdilution'=   list('su'=c('X5P',''),    'pr'=c('',''),        'tr'=c('abcde','','',''),                'eq'="mu*X5P"),
         'S7Pdilution'=   list('su'=c('S7P',''),    'pr'=c('',''),        'tr'=c('abcdefg','','',''),              'eq'="mu*S7P"),
         'PYRdilution'=   list('su'=c('PYR',''),    'pr'=c('',''),        'tr'=c('abc','','',''),                  'eq'="mu*PYR"),
         'PGNdilution'=   list('su'=c('PGN',''),    'pr'=c('',''),        'tr'=c('abcdef','','',''),               'eq'="mu*PGN"),
         'E4Pdilution'=   list('su'=c('E4P',''),    'pr'=c('',''),        'tr'=c('abcd','','',''),                 'eq'="mu*E4P"),
         'G1Pdilution'=   list('su'=c('G1P',''),    'pr'=c('',''),        'tr'=c('abcdef','','',''),               'eq'="mu*G1P"))

# kinetic parameters
kp=c('PTSrmaxPTS'=7829.78,
     'PTSKPTSa1'=3082.3,
     'PTSKPTSa2'=0.01,
     'PTSKPTSa3'=245.3,
     'PTSnPTSg6p'=3.66,
     'PTSKPTSg6p'=2.15,
     'PGIrmaxPGI'=650.988,
     'PGIKPGIeq'=0.1725,
     'PGIKPGIg6p'=2.9,
     'PGIKPGIf6p'=0.266,
     'PGIKPGIf6ppginh'=0.2,
     'PGIKPGIg6ppginh'=0.2,
     'PGMrmaxPGM'=0.839824,
     'PGMKPGMeq'=0.196,
     'PGMKPGMg6p'=1.038,
     'PGMKPGMg1p'=0.0136,
     'G6PDHrmaxG6PDH'=1.3802,
     'G6PDHKG6PDHg6p'=14.4,
     'G6PDHKG6PDHnadphg6pinh'=6.43,
     'G6PDHKG6PDHnadp'=0.0246,
     'G6PDHKG6PDHnadphnadpinh'=0.01,
     'cnadph'=0.062,
     'PFKrmaxPFK'=1840.58,
     'PFKKPFKatps'=0.123,
     'PFKKPFKadpc'=4.14,
     'PFKKPFKf6ps'=0.325,
     'PFKKPFKpep'=3.26,
     'PFKKPFKadpb'=3.89,
     'PFKKPFKampb'=3.2,
     'PFKKPFKadpa'=128,
     'PFKKPFKampa'=19.1,
     'PFKLPFK'=5629070,
     'PFKnPFK'=11.1,
     'cadp'=0.582,
     'camp'=0.954783,
     'TArmaxTA'=10.8716,
     'TAKTAeq'=1.05,
     'TK1rmaxTKa'=9.47338,
     'TK1KTKaeq'=1.2,
     'TK2rmaxTKb'=86.5586,
     'TK2KTKbeq'=10,
     'MURSYNv'=0.00043711,
     'ALDrmaxALDO'=17.4146,
     'ALDkALDOeq'=0.144,
     'ALDkALDOfdp'=1.75,
     'ALDkALDOgap'=0.088,
     'ALDVALDOblf'=2,
     'ALDkALDOdhap'=0.088,
     'ALDkALDOgapinh'=0.6,
     'GAPDHrmaxGAPDH'=921.594,
     'GAPDHKGAPDHeq'=0.63,
     'GAPDHKGAPDHgap'=0.683,
     'GAPDHKGAPDHpgp'=0.0000104,
     'GAPDHKGAPDHnad'=0.252,
     'GAPDHKGAPDHnadh'=1.09,
     'cnad'=1.4644,
     'cnadh'=0.0934,
     'TPIrmaxTIS'=68.6747,
     'TPIkTISeq'=1.39,
     'TPIkTISdhap'=2.8,
     'TPIkTISgap'=0.3,
     'TRPv'=0.001037,
     'GDHrmaxG3PDH'=0.0116204,
     'GDHKG3PDHdhap'=1,
     'PGKrmaxPGK'=3021.77,
     'PGKKPGKeq'=1934.4,
     'PGKKPGKadp'=0.185,
     'PGKKPGKatp'=0.653,
     'PGKKPGKpgp'=0.0468,
     'PGKKPGKpg3'=0.473,
     'SERSYNrmaxSerSynth'=0.0257121,
     'SERSYNKSerSynthpg3'=1,
     'PGMrmaxPGluMu'=89.0497,
     'PGMKPGluMueq'=0.188,
     'PGMKPGluMupg3'=0.2,
     'PGMKPGluMupg2'=0.369,
     'ENOrmaxENO'=330.448,
     'ENOKENOeq'=6.73,
     'ENOKENOpg2'=0.1,
     'ENOKENOpep'=0.135,
     'PYKrmaxPK'=0.0611315,
     'PYKKPKpep'=0.31,
     'PYKnPK'=4,
     'PYKLPK'=1000,
     'PYKKPKatp'=22.5,
     'PYKKPKfdp'=0.19,
     'PYKKPKamp'=0.2,
     'PYKKPKadp'=0.26,
     'PPCrmaxpepCxylase'=0.107021,
     'PPCKpepCxylasefdp'=0.7,
     'PPCnpepCxylasefdp'=4.21,
     'PPCKpepCxylasepep'=4.07,
     'SYN1rmaxSynth1'=0.019539,
     'SYN1KSynth1pep'=1,
     'SYN2rmaxSynth2'=0.0736186,
     'SYN2KSynth2pyr'=1,
     'DAHPSYNrmaxDAHPS'=0.107953,
     'DAHPSYNnDAHPSe4p'=2.6,
     'DAHPSYNnDAHPSpep'=2.2,
     'DAHPSYNKDAHPSe4p'=0.035,
     'DAHPSYNKDAHPSpep'=0.0053,
     'PDHrmaxPDH'=6.05953,
     'PDHnPDH'=3.68,
     'PDHKPDHpyr'=1159,
     'METSYNv'=0.0022627,
     'GNDrmaxPGDH'=16.2324,
     'GNDKPGDHpg'=37.5,
     'GNDKPGDHnadp'=0.0506,
     'GNDKPGDHnadphinh'=0.0138,
     'GNDKPGDHatpinh'=208,
     'catp'=4.27,
     'cnadp'=0.196759,
     'RPIrmaxR5PI'=4.83841,
     'RPIKR5PIeq'=4,
     'RPErmaxRu5P'=6.73903,
     'RPEKRu5Peq'=1.4,
     'RPPrmaxRPPK'=0.0129005,
     'RPPKRPPKrib5p'=0.1,
     'G1PATrmaxG1PAT'=0.00752546,
     'G1PATKG1PATfdp'=0.119,
     'G1PATnG1PATfdp'=1.2,
     'G1PATKG1PATatp'=4.42,
     'G1PATKG1PATg1p'=3.2,
     'mu'=0.0000278)

