/**************************************************************************/
/* LabWindows/CVI User Interface Resource (UIR) Include File              */
/*                                                                        */
/* WARNING: Do not add to, delete from, or otherwise modify the contents  */
/*          of this include file.                                         */
/**************************************************************************/

#include <userint.h>

#ifdef __cplusplus
    extern "C" {
#endif

     /* Panels and Controls: */

#define  PANEL                            1       /* callback function: panelCB */
#define  PANEL_Inicom                     2       /* control type: command, callback function: connect */
#define  PANEL_ComRing                    3       /* control type: ring, callback function: (none) */
#define  PANEL_ComRate                    4       /* control type: ring, callback function: (none) */
#define  PANEL_COMMANDBUTTON_2            5       /* control type: command, callback function: Read */
#define  PANEL_COMMANDBUTTON_3            6       /* control type: command, callback function: write */
#define  PANEL_NUMERIC                    7       /* control type: numeric, callback function: (none) */
#define  PANEL_ComRs                      8       /* control type: ring, callback function: (none) */
#define  PANEL_adres485                   9       /* control type: numeric, callback function: (none) */
#define  PANEL_READ_RING                  10      /* control type: ring, callback function: Read_Ring */
#define  PANEL_GET_READ_PARAM             11      /* control type: numeric, callback function: (none) */
#define  PANEL_Phase                      12      /* control type: numeric, callback function: PHASE_SET */
#define  PANEL_Shift6_6                   13      /* control type: numeric, callback function: SHIFT6_6_SET */
#define  PANEL_Frequance                  14      /* control type: numeric, callback function: FR_SET */
#define  PANEL_Nakoplenie                 15      /* control type: numeric, callback function: NAKOPLENIE_SET */
#define  PANEL_Magic_Key                  16      /* control type: numeric, callback function: MAGIC_KEY_SET */
#define  PANEL_Pulse_lenth                17      /* control type: numeric, callback function: PULSE_LENTH_SET */
#define  PANEL_NAKOPLENIE_SWITCH_R        18      /* control type: binary, callback function: Nakoplenie_OFF_R */
#define  PANEL_LED_Reset                  19      /* control type: command, callback function: LED_RESET_BOTTOM */
#define  PANEL_Reverse_Volt_LED           20      /* control type: LED, callback function: (none) */
#define  PANEL_U_Modulator                21      /* control type: LED, callback function: (none) */
#define  PANEL_Restart_Mark               22      /* control type: LED, callback function: (none) */
#define  PANEL_Protection_BUP             23      /* control type: LED, callback function: (none) */
#define  PANEL_Cross_over                 24      /* control type: LED, callback function: (none) */
#define  PANEL_Synhroniz_off              25      /* control type: LED, callback function: (none) */
#define  PANEL_Reverse_V_Sim              26      /* control type: command, callback function: Reverse_V_SIM */
#define  PANEL_Bur_Time                   27      /* control type: numeric, callback function: MAGIC_KEY_ADJ_SET */
#define  PANEL_RECT_PROTECT_OFF           28      /* control type: binary, callback function: Rect_protect_OFF */
#define  PANEL_REV_PROTECT_OFF            29      /* control type: binary, callback function: Rev_protect_OFF */
#define  PANEL_SLOW_UP_OFF                30      /* control type: binary, callback function: Slow_up_OFF */
#define  PANEL_Pulse_LENTH_1Stor          31      /* control type: numeric, callback function: Pulse_lenth_1Stor */
#define  PANEL_U_Reverce                  32      /* control type: numeric, callback function: U_REVERSE_SET */
#define  PANEL_U_Reverce_noStor           33      /* control type: numeric, callback function: U_REVERSE_SET_noStor */
#define  PANEL_BUM_1_CONNECTED_MG         34      /* control type: textMsg, callback function: (none) */
#define  PANEL_GET_V_Line_BOTTON          35      /* control type: command, callback function: Get_V_LINE */
#define  PANEL_GET_V_Line                 36      /* control type: numeric, callback function: (none) */
#define  PANEL_PROTECT_TIMER              37      /* control type: timer, callback function: Protection_Check */


     /* Control Arrays: */

          /* (no control arrays in the resource file) */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */

int  CVICALLBACK connect(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK FR_SET(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Get_V_LINE(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK LED_RESET_BOTTOM(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK MAGIC_KEY_ADJ_SET(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK MAGIC_KEY_SET(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Nakoplenie_OFF_R(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK NAKOPLENIE_SET(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK panelCB(int panel, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK PHASE_SET(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Protection_Check(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Pulse_lenth_1Stor(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK PULSE_LENTH_SET(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Read(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Read_Ring(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Rect_protect_OFF(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Rev_protect_OFF(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Reverse_V_SIM(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK SHIFT6_6_SET(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK Slow_up_OFF(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK U_REVERSE_SET(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK U_REVERSE_SET_noStor(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK write(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif
