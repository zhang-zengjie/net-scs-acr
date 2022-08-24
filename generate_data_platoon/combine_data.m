load('1.mat');


P_bar_n_f = P_bar_n;
P_bar_n_conv_f = P_bar_n_conv;
st_ACR_f = st_ACR;
st_ACR_conv_f = st_ACR_conv;

ACR_n_f = ACR_n;
ACR_n_conv_f = ACR_n_conv;
ACR_GT_f = ACR_GT;

E_x_f = E_x;
E_p_f = E_p;

load('2.mat');


P_bar_n_f = [P_bar_n_f; P_bar_n];
P_bar_n_conv_f = [P_bar_n_conv_f; P_bar_n_conv];
st_ACR_f = [st_ACR_f; st_ACR];
st_ACR_conv_f = [st_ACR_conv_f; st_ACR_conv];

ACR_n_f = [ACR_n_f;  ACR_n];
ACR_n_conv_f = [ACR_n_conv_f; ACR_n_conv];
ACR_GT_f = [ACR_GT_f; ACR_GT];

E_x_f = [E_x_f; E_x];
E_p_f = [E_p_f; E_p];

load('3.mat');


P_bar_n_f = [P_bar_n_f; P_bar_n];
P_bar_n_conv_f = [P_bar_n_conv_f; P_bar_n_conv];
st_ACR_f = [st_ACR_f; st_ACR];
st_ACR_conv_f = [st_ACR_conv_f; st_ACR_conv];

ACR_n_f = [ACR_n_f;  ACR_n];
ACR_n_conv_f = [ACR_n_conv_f; ACR_n_conv];
ACR_GT_f = [ACR_GT_f; ACR_GT];

E_x_f = [E_x_f; E_x];
E_p_f = [E_p_f; E_p];

load('4.mat');


P_bar_n_f = [P_bar_n_f; P_bar_n];
P_bar_n_conv_f = [P_bar_n_conv_f; P_bar_n_conv];
st_ACR_f = [st_ACR_f; st_ACR];
st_ACR_conv_f = [st_ACR_conv_f; st_ACR_conv];

ACR_n_f = [ACR_n_f;  ACR_n];
ACR_n_conv_f = [ACR_n_conv_f; ACR_n_conv];
ACR_GT_f = [ACR_GT_f; ACR_GT];

E_x_f = [E_x_f; E_x];
E_p_f = [E_p_f; E_p];

load('5.mat');


P_bar_n_f = [P_bar_n_f; P_bar_n];
P_bar_n_conv_f = [P_bar_n_conv_f; P_bar_n_conv];
st_ACR_f = [st_ACR_f; st_ACR];
st_ACR_conv_f = [st_ACR_conv_f; st_ACR_conv];

ACR_n_f = [ACR_n_f;  ACR_n];
ACR_n_conv_f = [ACR_n_conv_f; ACR_n_conv];
ACR_GT_f = [ACR_GT_f; ACR_GT];

E_x_f = [E_x_f; E_x];
E_p_f = [E_p_f; E_p];





P_bar_n = P_bar_n_f;
P_bar_n_conv = P_bar_n_conv_f;
st_ACR = st_ACR_f;
st_ACR_conv = st_ACR_conv_f;

ACR_n = ACR_n_f;
ACR_n_conv = ACR_n_conv_f;
ACR_GT = ACR_GT_f;

E_x = E_x_f;
E_p = E_p_f;

eta = 0.1:0.1:5;

