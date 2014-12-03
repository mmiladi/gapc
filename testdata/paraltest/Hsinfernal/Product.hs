module Hsinfernal.Product where
import Type
import Data.List (nub)
infix ***
alg1 *** alg2 = ((f_IL_1,f_IR_2,f_MP_3,f_ML_4,f_MR_5,f_D_6,f_IL_7,f_IR_8,f_MP_9,f_ML_10,f_MR_11,f_D_12,f_IL_13,f_IR_14,f_MP_15,f_ML_16,f_MR_17,f_D_18,f_IL_19,f_IR_20,f_MP_21,f_ML_22,f_MR_23,f_D_24,f_IL_25,f_IR_26,f_MP_27,f_ML_28,f_MR_29,f_D_30,f_IL_31,f_IR_32,f_MP_33,f_ML_34,f_MR_35,f_D_36,f_IL_37,f_IR_38,f_ML_39,f_D_40,f_IL_41,f_ML_42,f_D_43,f_IL_44,f_ML_45,f_D_46,f_IL_47,f_ML_48,f_D_49,f_IL_50,f_ML_51,f_D_52,f_IL_53,f_ML_54,f_D_55,f_IL_56,f_ML_57,f_D_58,f_IL_59,f_MR_60),((f_D_61,f_IR_62,f_B_63,f_S_64,f_IL_65,f_ML_66,f_D_67,f_IL_68,f_ML_69,f_D_70,f_IL_71,f_ML_72,f_D_73,f_IL_74,f_MP_75,f_ML_76,f_MR_77,f_D_78,f_IL_79,f_IR_80,f_MP_81,f_ML_82,f_MR_83,f_D_84,f_IL_85,f_IR_86,f_MP_87,f_ML_88,f_MR_89,f_D_90,f_IL_91,f_IR_92,f_MP_93,f_ML_94,f_MR_95,f_D_96,f_E_99,f_S_100,f_MP_101,f_ML_102,f_MR_103,f_D_104,f_IL_105,f_IR_106,f_MP_107,f_ML_108,f_MR_109,f_D_110,f_IL_111,f_IR_112,f_MP_113,f_ML_114,f_MR_115,f_D_116,f_IL_117,f_IR_118,f_MP_119,f_ML_120,f_MR_121,f_D_122),(f_IL_123,f_IR_124,f_ML_125,f_D_126,f_IL_127,f_ML_128,f_D_129,f_IL_130,f_ML_131,f_D_132,f_IL_133,f_ML_134,f_D_135,f_IL_136,f_ML_137,f_D_138,f_IL_139,f_ML_140,f_D_141,f_E_143,nil,h)))
  where
    ((f_IL_1_1,f_IR_2_1,f_MP_3_1,f_ML_4_1,f_MR_5_1,f_D_6_1,f_IL_7_1,f_IR_8_1,f_MP_9_1,f_ML_10_1,f_MR_11_1,f_D_12_1,f_IL_13_1,f_IR_14_1,f_MP_15_1,f_ML_16_1,f_MR_17_1,f_D_18_1,f_IL_19_1,f_IR_20_1,f_MP_21_1,f_ML_22_1,f_MR_23_1,f_D_24_1,f_IL_25_1,f_IR_26_1,f_MP_27_1,f_ML_28_1,f_MR_29_1,f_D_30_1,f_IL_31_1,f_IR_32_1,f_MP_33_1,f_ML_34_1,f_MR_35_1,f_D_36_1,f_IL_37_1,f_IR_38_1,f_ML_39_1,f_D_40_1,f_IL_41_1,f_ML_42_1,f_D_43_1,f_IL_44_1,f_ML_45_1,f_D_46_1,f_IL_47_1,f_ML_48_1,f_D_49_1,f_IL_50_1,f_ML_51_1,f_D_52_1,f_IL_53_1,f_ML_54_1,f_D_55_1,f_IL_56_1,f_ML_57_1,f_D_58_1,f_IL_59_1,f_MR_60_1),((f_D_61_1,f_IR_62_1,f_B_63_1,f_S_64_1,f_IL_65_1,f_ML_66_1,f_D_67_1,f_IL_68_1,f_ML_69_1,f_D_70_1,f_IL_71_1,f_ML_72_1,f_D_73_1,f_IL_74_1,f_MP_75_1,f_ML_76_1,f_MR_77_1,f_D_78_1,f_IL_79_1,f_IR_80_1,f_MP_81_1,f_ML_82_1,f_MR_83_1,f_D_84_1,f_IL_85_1,f_IR_86_1,f_MP_87_1,f_ML_88_1,f_MR_89_1,f_D_90_1,f_IL_91_1,f_IR_92_1,f_MP_93_1,f_ML_94_1,f_MR_95_1,f_D_96_1,f_E_99_1,f_S_100_1,f_MP_101_1,f_ML_102_1,f_MR_103_1,f_D_104_1,f_IL_105_1,f_IR_106_1,f_MP_107_1,f_ML_108_1,f_MR_109_1,f_D_110_1,f_IL_111_1,f_IR_112_1,f_MP_113_1,f_ML_114_1,f_MR_115_1,f_D_116_1,f_IL_117_1,f_IR_118_1,f_MP_119_1,f_ML_120_1,f_MR_121_1,f_D_122_1),(f_IL_123_1,f_IR_124_1,f_ML_125_1,f_D_126_1,f_IL_127_1,f_ML_128_1,f_D_129_1,f_IL_130_1,f_ML_131_1,f_D_132_1,f_IL_133_1,f_ML_134_1,f_D_135_1,f_IL_136_1,f_ML_137_1,f_D_138_1,f_IL_139_1,f_ML_140_1,f_D_141_1,f_E_143_1,nil_1,h_1))) = alg1
    ((f_IL_1_2,f_IR_2_2,f_MP_3_2,f_ML_4_2,f_MR_5_2,f_D_6_2,f_IL_7_2,f_IR_8_2,f_MP_9_2,f_ML_10_2,f_MR_11_2,f_D_12_2,f_IL_13_2,f_IR_14_2,f_MP_15_2,f_ML_16_2,f_MR_17_2,f_D_18_2,f_IL_19_2,f_IR_20_2,f_MP_21_2,f_ML_22_2,f_MR_23_2,f_D_24_2,f_IL_25_2,f_IR_26_2,f_MP_27_2,f_ML_28_2,f_MR_29_2,f_D_30_2,f_IL_31_2,f_IR_32_2,f_MP_33_2,f_ML_34_2,f_MR_35_2,f_D_36_2,f_IL_37_2,f_IR_38_2,f_ML_39_2,f_D_40_2,f_IL_41_2,f_ML_42_2,f_D_43_2,f_IL_44_2,f_ML_45_2,f_D_46_2,f_IL_47_2,f_ML_48_2,f_D_49_2,f_IL_50_2,f_ML_51_2,f_D_52_2,f_IL_53_2,f_ML_54_2,f_D_55_2,f_IL_56_2,f_ML_57_2,f_D_58_2,f_IL_59_2,f_MR_60_2),((f_D_61_2,f_IR_62_2,f_B_63_2,f_S_64_2,f_IL_65_2,f_ML_66_2,f_D_67_2,f_IL_68_2,f_ML_69_2,f_D_70_2,f_IL_71_2,f_ML_72_2,f_D_73_2,f_IL_74_2,f_MP_75_2,f_ML_76_2,f_MR_77_2,f_D_78_2,f_IL_79_2,f_IR_80_2,f_MP_81_2,f_ML_82_2,f_MR_83_2,f_D_84_2,f_IL_85_2,f_IR_86_2,f_MP_87_2,f_ML_88_2,f_MR_89_2,f_D_90_2,f_IL_91_2,f_IR_92_2,f_MP_93_2,f_ML_94_2,f_MR_95_2,f_D_96_2,f_E_99_2,f_S_100_2,f_MP_101_2,f_ML_102_2,f_MR_103_2,f_D_104_2,f_IL_105_2,f_IR_106_2,f_MP_107_2,f_ML_108_2,f_MR_109_2,f_D_110_2,f_IL_111_2,f_IR_112_2,f_MP_113_2,f_ML_114_2,f_MR_115_2,f_D_116_2,f_IL_117_2,f_IR_118_2,f_MP_119_2,f_ML_120_2,f_MR_121_2,f_D_122_2),(f_IL_123_2,f_IR_124_2,f_ML_125_2,f_D_126_2,f_IL_127_2,f_ML_128_2,f_D_129_2,f_IL_130_2,f_ML_131_2,f_D_132_2,f_IL_133_2,f_ML_134_2,f_D_135_2,f_IL_136_2,f_ML_137_2,f_D_138_2,f_IL_139_2,f_ML_140_2,f_D_141_2,f_E_143_2,nil_2,h_2))) = alg2
    f_IL_1 p b (s1,s2) = (f_IL_1_1 p b s1,f_IL_1_2 p b s2)
    f_IR_2 p (s1,s2) b = (f_IR_2_1 p s1 b,f_IR_2_2 p s2 b)
    f_MP_3 p a (s1,s2) b = (f_MP_3_1 p a s1 b,f_MP_3_2 p a s2 b)
    f_ML_4 p b (s1,s2) = (f_ML_4_1 p b s1,f_ML_4_2 p b s2)
    f_MR_5 p (s1,s2) b = (f_MR_5_1 p s1 b,f_MR_5_2 p s2 b)
    f_D_6 p (s1,s2) = (f_D_6_1 p s1,f_D_6_2 p s2)
    f_IL_7 p b (s1,s2) = (f_IL_7_1 p b s1,f_IL_7_2 p b s2)
    f_IR_8 p (s1,s2) b = (f_IR_8_1 p s1 b,f_IR_8_2 p s2 b)
    f_MP_9 p a (s1,s2) b = (f_MP_9_1 p a s1 b,f_MP_9_2 p a s2 b)
    f_ML_10 p b (s1,s2) = (f_ML_10_1 p b s1,f_ML_10_2 p b s2)
    f_MR_11 p (s1,s2) b = (f_MR_11_1 p s1 b,f_MR_11_2 p s2 b)
    f_D_12 p (s1,s2) = (f_D_12_1 p s1,f_D_12_2 p s2)
    f_IL_13 p b (s1,s2) = (f_IL_13_1 p b s1,f_IL_13_2 p b s2)
    f_IR_14 p (s1,s2) b = (f_IR_14_1 p s1 b,f_IR_14_2 p s2 b)
    f_MP_15 p a (s1,s2) b = (f_MP_15_1 p a s1 b,f_MP_15_2 p a s2 b)
    f_ML_16 p b (s1,s2) = (f_ML_16_1 p b s1,f_ML_16_2 p b s2)
    f_MR_17 p (s1,s2) b = (f_MR_17_1 p s1 b,f_MR_17_2 p s2 b)
    f_D_18 p (s1,s2) = (f_D_18_1 p s1,f_D_18_2 p s2)
    f_IL_19 p b (s1,s2) = (f_IL_19_1 p b s1,f_IL_19_2 p b s2)
    f_IR_20 p (s1,s2) b = (f_IR_20_1 p s1 b,f_IR_20_2 p s2 b)
    f_MP_21 p a (s1,s2) b = (f_MP_21_1 p a s1 b,f_MP_21_2 p a s2 b)
    f_ML_22 p b (s1,s2) = (f_ML_22_1 p b s1,f_ML_22_2 p b s2)
    f_MR_23 p (s1,s2) b = (f_MR_23_1 p s1 b,f_MR_23_2 p s2 b)
    f_D_24 p (s1,s2) = (f_D_24_1 p s1,f_D_24_2 p s2)
    f_IL_25 p b (s1,s2) = (f_IL_25_1 p b s1,f_IL_25_2 p b s2)
    f_IR_26 p (s1,s2) b = (f_IR_26_1 p s1 b,f_IR_26_2 p s2 b)
    f_MP_27 p a (s1,s2) b = (f_MP_27_1 p a s1 b,f_MP_27_2 p a s2 b)
    f_ML_28 p b (s1,s2) = (f_ML_28_1 p b s1,f_ML_28_2 p b s2)
    f_MR_29 p (s1,s2) b = (f_MR_29_1 p s1 b,f_MR_29_2 p s2 b)
    f_D_30 p (s1,s2) = (f_D_30_1 p s1,f_D_30_2 p s2)
    f_IL_31 p b (s1,s2) = (f_IL_31_1 p b s1,f_IL_31_2 p b s2)
    f_IR_32 p (s1,s2) b = (f_IR_32_1 p s1 b,f_IR_32_2 p s2 b)
    f_MP_33 p a (s1,s2) b = (f_MP_33_1 p a s1 b,f_MP_33_2 p a s2 b)
    f_ML_34 p b (s1,s2) = (f_ML_34_1 p b s1,f_ML_34_2 p b s2)
    f_MR_35 p (s1,s2) b = (f_MR_35_1 p s1 b,f_MR_35_2 p s2 b)
    f_D_36 p (s1,s2) = (f_D_36_1 p s1,f_D_36_2 p s2)
    f_IL_37 p b (s1,s2) = (f_IL_37_1 p b s1,f_IL_37_2 p b s2)
    f_IR_38 p (s1,s2) b = (f_IR_38_1 p s1 b,f_IR_38_2 p s2 b)
    f_ML_39 p b (s1,s2) = (f_ML_39_1 p b s1,f_ML_39_2 p b s2)
    f_D_40 p (s1,s2) = (f_D_40_1 p s1,f_D_40_2 p s2)
    f_IL_41 p b (s1,s2) = (f_IL_41_1 p b s1,f_IL_41_2 p b s2)
    f_ML_42 p b (s1,s2) = (f_ML_42_1 p b s1,f_ML_42_2 p b s2)
    f_D_43 p (s1,s2) = (f_D_43_1 p s1,f_D_43_2 p s2)
    f_IL_44 p b (s1,s2) = (f_IL_44_1 p b s1,f_IL_44_2 p b s2)
    f_ML_45 p b (s1,s2) = (f_ML_45_1 p b s1,f_ML_45_2 p b s2)
    f_D_46 p (s1,s2) = (f_D_46_1 p s1,f_D_46_2 p s2)
    f_IL_47 p b (s1,s2) = (f_IL_47_1 p b s1,f_IL_47_2 p b s2)
    f_ML_48 p b (s1,s2) = (f_ML_48_1 p b s1,f_ML_48_2 p b s2)
    f_D_49 p (s1,s2) = (f_D_49_1 p s1,f_D_49_2 p s2)
    f_IL_50 p b (s1,s2) = (f_IL_50_1 p b s1,f_IL_50_2 p b s2)
    f_ML_51 p b (s1,s2) = (f_ML_51_1 p b s1,f_ML_51_2 p b s2)
    f_D_52 p (s1,s2) = (f_D_52_1 p s1,f_D_52_2 p s2)
    f_IL_53 p b (s1,s2) = (f_IL_53_1 p b s1,f_IL_53_2 p b s2)
    f_ML_54 p b (s1,s2) = (f_ML_54_1 p b s1,f_ML_54_2 p b s2)
    f_D_55 p (s1,s2) = (f_D_55_1 p s1,f_D_55_2 p s2)
    f_IL_56 p b (s1,s2) = (f_IL_56_1 p b s1,f_IL_56_2 p b s2)
    f_ML_57 p b (s1,s2) = (f_ML_57_1 p b s1,f_ML_57_2 p b s2)
    f_D_58 p (s1,s2) = (f_D_58_1 p s1,f_D_58_2 p s2)
    f_IL_59 p b (s1,s2) = (f_IL_59_1 p b s1,f_IL_59_2 p b s2)
    f_MR_60 p (s1,s2) b = (f_MR_60_1 p s1 b,f_MR_60_2 p s2 b)
    f_D_61 p (s1,s2) = (f_D_61_1 p s1,f_D_61_2 p s2)
    f_IR_62 p (s1,s2) b = (f_IR_62_1 p s1 b,f_IR_62_2 p s2 b)
    f_B_63 (s1,s2) (t1,t2) = (f_B_63_1 s1 t1,f_B_63_2 s2 t2)
    f_S_64 p (s1,s2) = (f_S_64_1 p s1,f_S_64_2 p s2)
    f_IL_65 p b (s1,s2) = (f_IL_65_1 p b s1,f_IL_65_2 p b s2)
    f_ML_66 p b (s1,s2) = (f_ML_66_1 p b s1,f_ML_66_2 p b s2)
    f_D_67 p (s1,s2) = (f_D_67_1 p s1,f_D_67_2 p s2)
    f_IL_68 p b (s1,s2) = (f_IL_68_1 p b s1,f_IL_68_2 p b s2)
    f_ML_69 p b (s1,s2) = (f_ML_69_1 p b s1,f_ML_69_2 p b s2)
    f_D_70 p (s1,s2) = (f_D_70_1 p s1,f_D_70_2 p s2)
    f_IL_71 p b (s1,s2) = (f_IL_71_1 p b s1,f_IL_71_2 p b s2)
    f_ML_72 p b (s1,s2) = (f_ML_72_1 p b s1,f_ML_72_2 p b s2)
    f_D_73 p (s1,s2) = (f_D_73_1 p s1,f_D_73_2 p s2)
    f_IL_74 p b (s1,s2) = (f_IL_74_1 p b s1,f_IL_74_2 p b s2)
    f_MP_75 p a (s1,s2) b = (f_MP_75_1 p a s1 b,f_MP_75_2 p a s2 b)
    f_ML_76 p b (s1,s2) = (f_ML_76_1 p b s1,f_ML_76_2 p b s2)
    f_MR_77 p (s1,s2) b = (f_MR_77_1 p s1 b,f_MR_77_2 p s2 b)
    f_D_78 p (s1,s2) = (f_D_78_1 p s1,f_D_78_2 p s2)
    f_IL_79 p b (s1,s2) = (f_IL_79_1 p b s1,f_IL_79_2 p b s2)
    f_IR_80 p (s1,s2) b = (f_IR_80_1 p s1 b,f_IR_80_2 p s2 b)
    f_MP_81 p a (s1,s2) b = (f_MP_81_1 p a s1 b,f_MP_81_2 p a s2 b)
    f_ML_82 p b (s1,s2) = (f_ML_82_1 p b s1,f_ML_82_2 p b s2)
    f_MR_83 p (s1,s2) b = (f_MR_83_1 p s1 b,f_MR_83_2 p s2 b)
    f_D_84 p (s1,s2) = (f_D_84_1 p s1,f_D_84_2 p s2)
    f_IL_85 p b (s1,s2) = (f_IL_85_1 p b s1,f_IL_85_2 p b s2)
    f_IR_86 p (s1,s2) b = (f_IR_86_1 p s1 b,f_IR_86_2 p s2 b)
    f_MP_87 p a (s1,s2) b = (f_MP_87_1 p a s1 b,f_MP_87_2 p a s2 b)
    f_ML_88 p b (s1,s2) = (f_ML_88_1 p b s1,f_ML_88_2 p b s2)
    f_MR_89 p (s1,s2) b = (f_MR_89_1 p s1 b,f_MR_89_2 p s2 b)
    f_D_90 p (s1,s2) = (f_D_90_1 p s1,f_D_90_2 p s2)
    f_IL_91 p b (s1,s2) = (f_IL_91_1 p b s1,f_IL_91_2 p b s2)
    f_IR_92 p (s1,s2) b = (f_IR_92_1 p s1 b,f_IR_92_2 p s2 b)
    f_MP_93 p a (s1,s2) b = (f_MP_93_1 p a s1 b,f_MP_93_2 p a s2 b)
    f_ML_94 p b (s1,s2) = (f_ML_94_1 p b s1,f_ML_94_2 p b s2)
    f_MR_95 p (s1,s2) b = (f_MR_95_1 p s1 b,f_MR_95_2 p s2 b)
    f_D_96 p (s1,s2) = (f_D_96_1 p s1,f_D_96_2 p s2)
    f_E_99 p (s1,s2) = (f_E_99_1 p s1,f_E_99_2 p s2)
    f_S_100 p (s1,s2) = (f_S_100_1 p s1,f_S_100_2 p s2)
    f_MP_101 p a (s1,s2) b = (f_MP_101_1 p a s1 b,f_MP_101_2 p a s2 b)
    f_ML_102 p b (s1,s2) = (f_ML_102_1 p b s1,f_ML_102_2 p b s2)
    f_MR_103 p (s1,s2) b = (f_MR_103_1 p s1 b,f_MR_103_2 p s2 b)
    f_D_104 p (s1,s2) = (f_D_104_1 p s1,f_D_104_2 p s2)
    f_IL_105 p b (s1,s2) = (f_IL_105_1 p b s1,f_IL_105_2 p b s2)
    f_IR_106 p (s1,s2) b = (f_IR_106_1 p s1 b,f_IR_106_2 p s2 b)
    f_MP_107 p a (s1,s2) b = (f_MP_107_1 p a s1 b,f_MP_107_2 p a s2 b)
    f_ML_108 p b (s1,s2) = (f_ML_108_1 p b s1,f_ML_108_2 p b s2)
    f_MR_109 p (s1,s2) b = (f_MR_109_1 p s1 b,f_MR_109_2 p s2 b)
    f_D_110 p (s1,s2) = (f_D_110_1 p s1,f_D_110_2 p s2)
    f_IL_111 p b (s1,s2) = (f_IL_111_1 p b s1,f_IL_111_2 p b s2)
    f_IR_112 p (s1,s2) b = (f_IR_112_1 p s1 b,f_IR_112_2 p s2 b)
    f_MP_113 p a (s1,s2) b = (f_MP_113_1 p a s1 b,f_MP_113_2 p a s2 b)
    f_ML_114 p b (s1,s2) = (f_ML_114_1 p b s1,f_ML_114_2 p b s2)
    f_MR_115 p (s1,s2) b = (f_MR_115_1 p s1 b,f_MR_115_2 p s2 b)
    f_D_116 p (s1,s2) = (f_D_116_1 p s1,f_D_116_2 p s2)
    f_IL_117 p b (s1,s2) = (f_IL_117_1 p b s1,f_IL_117_2 p b s2)
    f_IR_118 p (s1,s2) b = (f_IR_118_1 p s1 b,f_IR_118_2 p s2 b)
    f_MP_119 p a (s1,s2) b = (f_MP_119_1 p a s1 b,f_MP_119_2 p a s2 b)
    f_ML_120 p b (s1,s2) = (f_ML_120_1 p b s1,f_ML_120_2 p b s2)
    f_MR_121 p (s1,s2) b = (f_MR_121_1 p s1 b,f_MR_121_2 p s2 b)
    f_D_122 p (s1,s2) = (f_D_122_1 p s1,f_D_122_2 p s2)
    f_IL_123 p b (s1,s2) = (f_IL_123_1 p b s1,f_IL_123_2 p b s2)
    f_IR_124 p (s1,s2) b = (f_IR_124_1 p s1 b,f_IR_124_2 p s2 b)
    f_ML_125 p b (s1,s2) = (f_ML_125_1 p b s1,f_ML_125_2 p b s2)
    f_D_126 p (s1,s2) = (f_D_126_1 p s1,f_D_126_2 p s2)
    f_IL_127 p b (s1,s2) = (f_IL_127_1 p b s1,f_IL_127_2 p b s2)
    f_ML_128 p b (s1,s2) = (f_ML_128_1 p b s1,f_ML_128_2 p b s2)
    f_D_129 p (s1,s2) = (f_D_129_1 p s1,f_D_129_2 p s2)
    f_IL_130 p b (s1,s2) = (f_IL_130_1 p b s1,f_IL_130_2 p b s2)
    f_ML_131 p b (s1,s2) = (f_ML_131_1 p b s1,f_ML_131_2 p b s2)
    f_D_132 p (s1,s2) = (f_D_132_1 p s1,f_D_132_2 p s2)
    f_IL_133 p b (s1,s2) = (f_IL_133_1 p b s1,f_IL_133_2 p b s2)
    f_ML_134 p b (s1,s2) = (f_ML_134_1 p b s1,f_ML_134_2 p b s2)
    f_D_135 p (s1,s2) = (f_D_135_1 p s1,f_D_135_2 p s2)
    f_IL_136 p b (s1,s2) = (f_IL_136_1 p b s1,f_IL_136_2 p b s2)
    f_ML_137 p b (s1,s2) = (f_ML_137_1 p b s1,f_ML_137_2 p b s2)
    f_D_138 p (s1,s2) = (f_D_138_1 p s1,f_D_138_2 p s2)
    f_IL_139 p b (s1,s2) = (f_IL_139_1 p b s1,f_IL_139_2 p b s2)
    f_ML_140 p b (s1,s2) = (f_ML_140_1 p b s1,f_ML_140_2 p b s2)
    f_D_141 p (s1,s2) = (f_D_141_1 p s1,f_D_141_2 p s2)
    f_E_143 p (s1,s2) = (f_E_143_1 p s1,f_E_143_2 p s2)
    nil s = (nil_1 s, nil_2 s)
    h xs = [ (x1,x2) | x1 <- nub $ h_1 [y1 | (y1,y2) <- xs], x2 <- h_2 [y2 | (y1,y2) <- xs, y1 == x1] ]

