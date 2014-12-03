import rna

input rna


/*signature Foo(alphabet, answer) {
  choice [answer] h([answer]);
}
*/

signature Canonical_Algebra(alphabet,answer)
{
answer sadd(Subsequence,answer);
answer cadd(answer,answer);
answer cadd_Pr(answer,answer);
answer cadd_Pr_Pr(answer,answer);
answer cadd_Pr_Pr_Pr(answer,answer);
answer ambd(answer,Subsequence,answer);
answer ambd_Pr(answer,Subsequence,answer);
answer nil(void);
answer nil_Pr(void);
answer edl(Subsequence,answer);
answer edr(answer,Subsequence);
answer edlr(Subsequence,answer,Subsequence);
answer drem(answer);
answer is(answer);
answer sr(Subsequence,answer,Subsequence);
answer hl(Subsequence,Subsequence,Subsequence,Subsequence,Subsequence);
answer sp(Subsequence,Subsequence,answer,Subsequence,Subsequence);
answer bl(Subsequence,answer);
answer br(answer,Subsequence);
answer il(Subsequence,answer,Subsequence);
answer ml(Subsequence,Subsequence,answer,Subsequence,Subsequence);
answer mldr(Subsequence,Subsequence,answer,Subsequence,Subsequence,Subsequence);
answer mladr(Subsequence,Subsequence,answer,Subsequence,Subsequence,Subsequence);
answer mldlr(Subsequence,Subsequence,Subsequence,answer,Subsequence,Subsequence,Subsequence);
answer mladlr(Subsequence,Subsequence,Subsequence,answer,Subsequence,Subsequence,Subsequence);
answer mldladr(Subsequence,Subsequence,Subsequence,answer,Subsequence,Subsequence,Subsequence);
answer mladldr(Subsequence,Subsequence,Subsequence,answer,Subsequence,Subsequence,Subsequence);
answer mldl(Subsequence,Subsequence,Subsequence,answer,Subsequence,Subsequence);
answer mladl(Subsequence,Subsequence,Subsequence,answer,Subsequence,Subsequence);
answer addss(answer,Subsequence);
answer ssadd(Subsequence,answer);
answer trafo(answer);
answer incl(answer);
answer combine(answer,answer);
answer lcombine(answer,answer);
answer lcombine_Pr(answer,answer);
answer rcombine(answer,answer);
answer rcombine_Pr(answer,answer);
answer lrcombine(answer,answer);
answer acomb(answer,Subsequence,answer);
answer lacomb(answer,Subsequence,answer);
answer lacomb_Pr(answer,Subsequence,answer);
answer racomb(answer,Subsequence,answer);
answer racomb_Pr(answer,Subsequence,answer);
answer lracomb(answer,Subsequence,answer);
choice [answer] h([answer]);
}

algebra count auto count ;

algebra enum auto enum ;


grammar canonicals_nonamb uses Canonical_Algebra(axiom = struc) {

tabulated {
endMultiloop1,
ml_comps12,
ml_comps22,
no_dl_ss_end2,
dl_or_ss_left_ss_end2,
block_dl2,
block_dlr2,
block_dl3,
block_dlr3,
endMultiloop4,
ml_comps15,
ml_comps25,
block_dl5,
block_dlr5,
endMultiloop5,
ml_comps16,
ml_comps26,
block_dl6,
block_dlr6,
ml_comps17,
ml_comps27,
no_dl_ss_end7,
dl_or_ss_left_ss_end7,
block_dl7,
block_dlr7,
endHairpin,
left_unpaired1,
left_unpaired4,
left_unpaired10,
left_unpairedEnd,
initMultiloop4,
leftB4,
initMultiloop5,
stack
}

  struc = left_dangle1 |
    trafo(noleft_dangle1) |
    left_unpaired1 # h 
;


  left_unpaired1 = sadd(BASE, left_unpaired1) |
    sadd(BASE, left_dangle1) # h 
;


  left_dangle1 = ambd(edanglel1, BASE, noleft_dangle4) |
    cadd_Pr(edanglel1, noleft_dangle4) |
    cadd(edanglelr1,  { left_dangle4 | left_unpaired4 } ) # h 
;


  noleft_dangle1 = cadd_Pr_Pr(edangler1,  { left_dangle4 | left_unpaired4 } ) |
    cadd_Pr_Pr_Pr(nodangle1, noleft_dangle4) |
    ambd_Pr(nodangle1, BASE, noleft_dangle4) # h 
;


  edanglel1 = edl(BASE, motif1) # h 
;


  edangler1 = edr(motif1, BASE) # h 
;


  edanglelr1 = edlr(BASE, motif1, BASE) # h 
;


  nodangle1 = drem(motif1) # h 
;


  motif1 = initMultiloop1 
;


  initMultiloop1 = is(endMultiloop1) # h 
;


  endMultiloop1 = stack1 |
    multiloop1 |
    leftB1 |
    rightB1 |
    iloop1 # h 
;


  stack1 = sr(BASE, endMultiloop1, BASE) with basepairing 
;


  multiloop1 =  { mldl(BASE, BASE, BASE, ml_comps12, BASE, BASE) |
    mladl(BASE, BASE, BASE, ml_comps22, BASE, BASE) |
    mldr(BASE, BASE, ml_comps32, BASE, BASE, BASE) |
    mladr(BASE, BASE, ml_comps22, BASE, BASE, BASE) |
    mldlr(BASE, BASE, BASE, ml_comps42, BASE, BASE, BASE) |
    mladlr(BASE, BASE, BASE, ml_comps22, BASE, BASE, BASE) |
    mldladr(BASE, BASE, BASE, ml_comps12, BASE, BASE, BASE) |
    mladldr(BASE, BASE, BASE, ml_comps32, BASE, BASE, BASE) |
    ml(BASE, BASE, ml_comps22, BASE, BASE) } with stackpairing 
;


  leftB1 = sp(BASE, BASE, bl(REGION, initMultiloop1), BASE, BASE) with stackpairing # h
;


  rightB1 = sp(BASE, BASE, br(initMultiloop1, REGION), BASE, BASE) with stackpairing # h
;


  iloop1 = sp(BASE, BASE, il(REGION with maxsize(30), endMultiloop1, REGION with maxsize(30)), BASE, BASE) with stackpairing # h
;


  ml_comps12 = combine(block_dl2, no_dl_no_ss_end2) |
    combine(block_dlr2, dl_or_ss_left_no_ss_end2) |
    acomb(block_dl2, BASE, no_dl_no_ss_end2) # h 
;


  ml_comps22 = combine(incl(nodangle2), no_dl_no_ss_end2) |
    combine(incl(edangler2), dl_or_ss_left_no_ss_end2) |
    acomb(incl(nodangle2), BASE, no_dl_no_ss_end2) # h 
;


  ml_comps32 = combine(incl(edangler2), dl_or_ss_left_ss_end2) |
    combine(incl(nodangle2), no_dl_ss_end2) |
    acomb(incl(nodangle2), BASE, no_dl_ss_end2) # h 
;


  ml_comps42 = combine(block_dl2, no_dl_ss_end2) |
    combine(block_dlr2, dl_or_ss_left_ss_end2) |
    acomb(block_dl2, BASE, no_dl_ss_end2) # h 
;


  no_dl_no_ss_end2 = incl(nodangle3) # h 
;


  dl_or_ss_left_no_ss_end2 = block_dl3 # h 
;


  no_dl_ss_end2 = incl(edangler3) |
    addss(incl(edangler3), REGION) # h 
;


  dl_or_ss_left_ss_end2 = block_dlr3 |
    addss(block_dlr3, REGION) # h 
;


  block_dl2 = ssadd(REGION, edanglel2) |
    incl(edanglel2) # h 
;


  block_dlr2 = ssadd(REGION, edanglelr2) |
    incl(edanglelr2) # h 
;


  edanglel2 = edl(BASE, motif2) # h 
;


  edangler2 = edr(motif2, BASE) # h 
;


  edanglelr2 = edlr(BASE, motif2, BASE) # h 
;


  nodangle2 = drem(motif2) # h 
;


  motif2 = initHairpin 
;


  block_dl3 = ssadd(REGION, edanglel3) |
    incl(edanglel3) # h 
;


  block_dlr3 = ssadd(REGION, edanglelr3) |
    incl(edanglelr3) # h 
;


  edanglel3 = edl(BASE, motif3) # h 
;


  edangler3 = edr(motif3, BASE) # h 
;


  edanglelr3 = edlr(BASE, motif3, BASE) # h 
;


  nodangle3 = drem(motif3) # h 
;


  motif3 = initHairpin 
;


  left_unpaired4 = sadd(BASE, left_unpaired4) |
    sadd(BASE, left_dangle4) # h 
;


  left_dangle4 = ambd(edanglel4, BASE, noleft_dangle10) |
    cadd_Pr(edanglel4, noleft_dangle10) |
    cadd(edanglelr4,  { left_dangle10 | left_unpaired10 } ) # h 
;


  noleft_dangle4 = cadd_Pr_Pr(edangler4,  { left_dangle10 | left_unpaired10 } ) |
    cadd_Pr_Pr_Pr(nodangle4, noleft_dangle10) |
    ambd_Pr(nodangle4, BASE, noleft_dangle10) # h 
;


  edanglel4 = edl(BASE, motif4) # h 
;


  edangler4 = edr(motif4, BASE) # h 
;


  edanglelr4 = edlr(BASE, motif4, BASE) # h 
;


  nodangle4 = drem(motif4) # h 
;


  motif4 = initMultiloop4 
;


  initMultiloop4 = is(endMultiloop4) # h 
;


  endMultiloop4 = stack4 |
    multiloop4 |
    leftB4 |
    rightB4 |
    iloop4 # h 
;


  stack4 = sr(BASE, endMultiloop4, BASE) with basepairing 
;


  multiloop4 =  { mldl(BASE, BASE, BASE, ml_comps15, BASE, BASE) |
    mladl(BASE, BASE, BASE, ml_comps25, BASE, BASE) |
    mldr(BASE, BASE, ml_comps35, BASE, BASE, BASE) |
    mladr(BASE, BASE, ml_comps25, BASE, BASE, BASE) |
    mldlr(BASE, BASE, BASE, ml_comps45, BASE, BASE, BASE) |
    mladlr(BASE, BASE, BASE, ml_comps25, BASE, BASE, BASE) |
    mldladr(BASE, BASE, BASE, ml_comps15, BASE, BASE, BASE) |
    mladldr(BASE, BASE, BASE, ml_comps35, BASE, BASE, BASE) |
    ml(BASE, BASE, ml_comps25, BASE, BASE) } with stackpairing 
;


  leftB4 = sp(BASE, BASE, bl(REGION, initMultiloop4), BASE, BASE) with stackpairing # h
;


  rightB4 = sp(BASE, BASE, br(initMultiloop4, REGION), BASE, BASE) with stackpairing # h
;


  iloop4 = sp(BASE, BASE, il(REGION with maxsize(30), endMultiloop4, REGION with maxsize(30)), BASE, BASE) with stackpairing # h
;


  ml_comps15 = combine(block_dl5, no_dl_no_ss_end5) |
    combine(block_dlr5, dl_or_ss_left_no_ss_end5) |
    acomb(block_dl5, BASE, no_dl_no_ss_end5) # h 
;


  ml_comps25 = combine(incl(nodangle5), no_dl_no_ss_end5) |
    combine(incl(edangler5), dl_or_ss_left_no_ss_end5) |
    acomb(incl(nodangle5), BASE, no_dl_no_ss_end5) # h 
;


  ml_comps35 = combine(incl(edangler5), dl_or_ss_left_ss_end5) |
    combine(incl(nodangle5), no_dl_ss_end5) |
    acomb(incl(nodangle5), BASE, no_dl_ss_end5) # h 
;


  ml_comps45 = combine(block_dl5, no_dl_ss_end5) |
    combine(block_dlr5, dl_or_ss_left_ss_end5) |
    acomb(block_dl5, BASE, no_dl_ss_end5) # h 
;


  no_dl_no_ss_end5 = ml_comps22 
;


  dl_or_ss_left_no_ss_end5 = ml_comps12 
;


  no_dl_ss_end5 = ml_comps32 
;


  dl_or_ss_left_ss_end5 = ml_comps42 
;


  block_dl5 = ssadd(REGION, edanglel5) |
    incl(edanglel5) # h 
;


  block_dlr5 = ssadd(REGION, edanglelr5) |
    incl(edanglelr5) # h 
;


  edanglel5 = edl(BASE, motif5) # h 
;


  edangler5 = edr(motif5, BASE) # h 
;


  edanglelr5 = edlr(BASE, motif5, BASE) # h 
;


  nodangle5 = drem(motif5) # h 
;


  motif5 = initMultiloop5 
;


  initMultiloop5 = is(endMultiloop5) # h 
;


  endMultiloop5 = stack5 |
    multiloop5 |
    leftB5 |
    rightB5 |
    iloop5 # h 
;


  stack5 = sr(BASE, endMultiloop5, BASE) with basepairing 
;


  multiloop5 =  { mldl(BASE, BASE, BASE, ml_comps16, BASE, BASE) |
    mladl(BASE, BASE, BASE, ml_comps26, BASE, BASE) |
    mldr(BASE, BASE, ml_comps36, BASE, BASE, BASE) |
    mladr(BASE, BASE, ml_comps26, BASE, BASE, BASE) |
    mldlr(BASE, BASE, BASE, ml_comps46, BASE, BASE, BASE) |
    mladlr(BASE, BASE, BASE, ml_comps26, BASE, BASE, BASE) |
    mldladr(BASE, BASE, BASE, ml_comps16, BASE, BASE, BASE) |
    mladldr(BASE, BASE, BASE, ml_comps36, BASE, BASE, BASE) |
    ml(BASE, BASE, ml_comps26, BASE, BASE) } with stackpairing 
;


  leftB5 = sp(BASE, BASE, bl(REGION, initMultiloop5), BASE, BASE) with stackpairing # h
;


  rightB5 = sp(BASE, BASE, br(initMultiloop5, REGION), BASE, BASE) with stackpairing # h
;


  iloop5 = sp(BASE, BASE, il(REGION with maxsize(30), endMultiloop5, REGION with maxsize(30)), BASE, BASE) with stackpairing # h
;


  ml_comps16 = combine(block_dl6, no_dl_no_ss_end6) |
    combine(block_dlr6, dl_or_ss_left_no_ss_end6) |
    acomb(block_dl6, BASE, no_dl_no_ss_end6) # h 
;


  ml_comps26 = combine(incl(nodangle6), no_dl_no_ss_end6) |
    combine(incl(edangler6), dl_or_ss_left_no_ss_end6) |
    acomb(incl(nodangle6), BASE, no_dl_no_ss_end6) # h 
;


  ml_comps36 = combine(incl(edangler6), dl_or_ss_left_ss_end6) |
    combine(incl(nodangle6), no_dl_ss_end6) |
    acomb(incl(nodangle6), BASE, no_dl_ss_end6) # h 
;


  ml_comps46 = combine(block_dl6, no_dl_ss_end6) |
    combine(block_dlr6, dl_or_ss_left_ss_end6) |
    acomb(block_dl6, BASE, no_dl_ss_end6) # h 
;


  no_dl_no_ss_end6 = ml_comps27 
;


  dl_or_ss_left_no_ss_end6 = ml_comps17 
;


  no_dl_ss_end6 = ml_comps37 
;


  dl_or_ss_left_ss_end6 = ml_comps47 
;


  block_dl6 = ssadd(REGION, edanglel6) |
    incl(edanglel6) # h 
;


  block_dlr6 = ssadd(REGION, edanglelr6) |
    incl(edanglelr6) # h 
;


  edanglel6 = edl(BASE, motif6) # h 
;


  edangler6 = edr(motif6, BASE) # h 
;


  edanglelr6 = edlr(BASE, motif6, BASE) # h 
;


  nodangle6 = drem(motif6) # h 
;


  motif6 = initHairpin 
;


  ml_comps17 = combine(block_dl7, no_dl_no_ss_end7) |
    combine(block_dlr7, dl_or_ss_left_no_ss_end7) |
    acomb(block_dl7, BASE, no_dl_no_ss_end7) # h 
;


  ml_comps27 = combine(incl(nodangle7), no_dl_no_ss_end7) |
    combine(incl(edangler7), dl_or_ss_left_no_ss_end7) |
    acomb(incl(nodangle7), BASE, no_dl_no_ss_end7) # h 
;


  ml_comps37 = combine(incl(edangler7), dl_or_ss_left_ss_end7) |
    combine(incl(nodangle7), no_dl_ss_end7) |
    acomb(incl(nodangle7), BASE, no_dl_ss_end7) # h 
;


  ml_comps47 = combine(block_dl7, no_dl_ss_end7) |
    combine(block_dlr7, dl_or_ss_left_ss_end7) |
    acomb(block_dl7, BASE, no_dl_ss_end7) # h 
;


  no_dl_no_ss_end7 = incl(nodangle3) # h 
;


  dl_or_ss_left_no_ss_end7 = block_dl3 # h 
;


  no_dl_ss_end7 = incl(edangler3) |
    addss(incl(edangler3), REGION) # h 
;


  dl_or_ss_left_ss_end7 = block_dlr3 |
    addss(block_dlr3, REGION) # h 
;


  block_dl7 = ssadd(REGION, edanglel7) |
    incl(edanglel7) # h 
;


  block_dlr7 = ssadd(REGION, edanglelr7) |
    incl(edanglelr7) # h 
;


  edanglel7 = edl(BASE, motif7) # h 
;


  edangler7 = edr(motif7, BASE) # h 
;


  edanglelr7 = edlr(BASE, motif7, BASE) # h 
;


  nodangle7 = drem(motif7) # h 
;


  motif7 = motif1 
;


  left_unpaired10 = sadd(BASE, left_unpaired10) |
    sadd(BASE, left_dangle10) # h 
;


  left_dangle10 = cadd_Pr(edanglel10, nil_Pr(EMPTY)) |
    cadd(edanglelr10,  { nil(EMPTY) | left_unpairedEnd } ) # h 
;


  noleft_dangle10 = cadd_Pr_Pr(edangler10,  { nil(EMPTY) | left_unpairedEnd } ) |
    cadd_Pr_Pr_Pr(nodangle10, nil_Pr(EMPTY)) # h 
;


  edanglel10 = edl(BASE, motif10) # h 
;


  edangler10 = edr(motif10, BASE) # h 
;


  edanglelr10 = edlr(BASE, motif10, BASE) # h 
;


  nodangle10 = drem(motif10) # h 
;


  motif10 = initHairpin 
;


  initHairpin = is(endHairpin) # h 
;


  endHairpin = stack |
    hairpin |
    leftB |
    rightB |
    iloop # h 
;


  stack = sr(BASE, endHairpin, BASE) with basepairing 
;


  hairpin = hl(BASE, BASE, REGION with minsize(3), BASE, BASE) with stackpairing 
;


  leftB = sp(BASE, BASE, bl(REGION, initHairpin), BASE, BASE) with stackpairing  # h
;


  rightB = sp(BASE, BASE, br(initHairpin, REGION), BASE, BASE) with stackpairing # h
;


  iloop = sp(BASE, BASE, il(REGION with maxsize(30), endHairpin, REGION with maxsize(30)), BASE, BASE) with stackpairing # h
;


  left_unpairedEnd = sadd(BASE, left_unpairedEnd) |
    sadd(BASE, nil(EMPTY)) # h 
;

}

instance count = canonicals_nonamb ( count ) ;
instance en = canonicals_nonamb ( enum ) ;

