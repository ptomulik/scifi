function F1_dq = wn_F1_dq(t, sys, vaw)

  F1_dq = -sys.g_dq(t, wav.dq(t), wav.q(t))
