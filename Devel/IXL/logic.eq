% TC equations for the Track Ciruit
TC_01 <= ~SE_UP_01 * ~SE_UP_19 * ~SE_DO_02 * ~SE_DO_08 * (TC_01 + SE_DO_01 + SE_DO_19 + SE_UP_02 + SE_UP_08);
TC_02 <= ~SE_UP_02 * ~SE_DO_03 * (TC_02 + SE_DO_02 + SE_UP_03);
TC_03 <= ~SE_UP_03 * ~SE_DO_04 * (TC_03 + SE_DO_03 + SE_UP_04);
TC_04 <= ~SE_UP_04 * ~SE_UP_10 * ~SE_DO_05 * ~SE_DO_20 * (TC_04 + SE_DO_04 + SE_DO_10 + SE_UP_05 + SE_UP_20);
TC_05 <= ~SE_UP_05 * ~SE_DO_06 * (TC_05 + SE_DO_05 + SE_UP_06);
TC_06 <= ~SE_UP_06 * ~SE_DO_01 * (TC_06 + SE_DO_06 + SE_UP_01);
TC_07 <= ~SE_UP_08 * ~SE_DO_09 * (TC_07 + SE_DO_08 + SE_UP_09);
TC_08 <= ~SE_UP_09 * ~SE_DO_10 * (TC_08 + SE_DO_09 + SE_UP_10);
TC_09 <= ~SE_UP_11 * ~SE_DO_12 * (TC_09 + SE_DO_11 + SE_UP_12);
TC_10 <= ~SE_UP_12 * ~SE_DO_07 * (TC_10 + SE_DO_12 + SE_UP_07);
TC_11 <= ~SE_UP_07 * ~SE_UP_13 * ~SE_DO_14 * ~SE_DO_19 * (TC_11 + SE_DO_07 + SE_DO_13 + SE_UP_14 + SE_UP_19);
TC_12 <= ~SE_UP_14 * ~SE_DO_15 * (TC_12 + SE_DO_14 + SE_UP_15);
TC_13 <= ~SE_UP_15 * ~SE_DO_16 * (TC_13 + SE_DO_15 + SE_UP_16);
TC_14 <= ~SE_UP_16 * ~SE_UP_20 * ~SE_DO_11 * ~SE_DO_17 * (TC_14 + SE_DO_16 + SE_DO_20 + SE_UP_11 + SE_UP_17);
TC_15 <= ~SE_UP_17 * ~SE_DO_18 * (TC_15 + SE_DO_17 + SE_UP_18);
TC_16 <= ~SE_UP_18 * ~SE_DO_13 * (TC_16 + SE_DO_18 + SE_UP_13);

% Switch equations
% Switch 01
SW_AUT_RI_01 <= SW_CMD_RI_01 * TC_01 * TC_02 * TC_06 * TC_07 * TC_11;
SW_AUT_LE_01 <= SW_CMD_LE_01 * TC_01 * TC_02 * TC_06 * TC_07 * TC_11;

% Switch 02
SW_AUT_RI_02 <= SW_CMD_RI_02 * TC_01 * TC_02 * TC_06 * TC_07 * TC_11;
SW_AUT_LE_02 <= SW_CMD_LE_02 * TC_01 * TC_02 * TC_06 * TC_07 * TC_11;
	
% Switch 03
SW_AUT_RI_03 <= SW_CMD_RI_03 * TC_01 * TC_11 * TC_07 * TC_10 * TC_12;
SW_AUT_LE_03 <= SW_CMD_LE_03 * TC_01 * TC_11 * TC_07 * TC_10 * TC_12;

% Switch 04
SW_AUT_RI_04 <= SW_CMD_RI_04 * TC_01 * TC_11 * TC_16 * TC_10 * TC_12;
SW_AUT_LE_04 <= SW_CMD_LE_04 * TC_01 * TC_11 * TC_16 * TC_10 * TC_12;

% Switch 05
SW_AUT_RI_05 <= SW_CMD_RI_05 * TC_03 * TC_04 * TC_05 * TC_08 * TC_09;
SW_AUT_LE_05 <= SW_CMD_LE_05 * TC_03 * TC_04 * TC_05 * TC_08 * TC_09;

% Switch 06
SW_AUT_RI_06 <= SW_CMD_RI_06 * TC_03 * TC_04 * TC_05 * TC_08 * TC_09;
SW_AUT_LE_06 <= SW_CMD_LE_06 * TC_03 * TC_04 * TC_05 * TC_08 * TC_09;

% Switch 07
SW_AUT_RI_07 <= SW_CMD_RI_07 * TC_04 * TC_09 * TC_13 * TC_14 * TC_15;
SW_AUT_LE_07 <= SW_CMD_LE_07 * TC_04 * TC_09 * TC_13 * TC_14 * TC_15;

% Switch 08
SW_AUT_RI_08 <= SW_CMD_RI_08 * TC_04 * TC_09 * TC_13 * TC_14 * TC_15;
SW_AUT_LE_08 <= SW_CMD_LE_08 * TC_04 * TC_09 * TC_13 * TC_14 * TC_15;
