//==============================================================================
//
// Title:		BUM
// Purpose:		A short description of the application.
//
// Created on:	07.08.2019 at 11:05:49 by Bezuglov.
// Copyright:	BINP SB RAS. All Rights Reserved.
//
//==============================================================================

//==============================================================================
// Include files

#include <ansi_c.h>
#include <cvirte.h>		
#include <userint.h>
#include "BUM.h"
#include "toolbox.h"

#include "functions.c"  
#include <formatio.h>
#include <rs232.h>
#include <utility.h>
//==============================================================================
// Constants

//==============================================================================
// Types

//==============================================================================
// Static global variables

static int panelHandle = 0;

//==============================================================================
// Static functions

//==============================================================================
// Global variables
static int com, BUM_CONNECTED_1 = 0;
//==============================================================================
// Global functions
 

//==============================================================================
//
//==============================================================================

/// HIFN The main entry-point function.
int main (int argc, char *argv[])
{
	int error = 0;
	
	/* initialize and load resources */
	nullChk (InitCVIRTE (0, argv, 0));
	errChk (panelHandle = LoadPanel (0, "BUM.uir", PANEL));
	
	/* display the panel and run the user interface */
	errChk (DisplayPanel (panelHandle));
	errChk (RunUserInterface ());

Error:
	/* clean up */
	if (panelHandle > 0)
		DiscardPanel (panelHandle);
	return 0;
}

//==============================================================================
// UI callback function prototypes

/// HIFN Exit when the user dismisses the panel.
int CVICALLBACK panelCB (int panel, int event, void *callbackData,
		int eventData1, int eventData2)
{
	if (event == EVENT_CLOSE)
		QuitUserInterface (0);
	return 0;
}

int CVICALLBACK connect (int panel, int control, int event,
						 void *callbackData, int eventData1, int eventData2)
{
	int com, rs, adr485, boudrate, connect = 0; 
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com); 	
		GetCtrlVal (panelHandle, PANEL_ComRate, &boudrate);
    	bum_inicom (com, boudrate, rs, adr485, &connect);
		if (connect == 1)
		{
		BUM_CONNECTED_1 = 1;
		SetCtrlAttribute (panelHandle, PANEL_PROTECT_TIMER, ATTR_ENABLED, 1);
		SetCtrlAttribute (panelHandle, PANEL_BUM_1_CONNECTED_MG, ATTR_VISIBLE, 0);
		}
			break;
	}
	return 0;
}















//==============================================================================  
int CVICALLBACK Read (int panel, int control, int event,
					  void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			
		int readBuf[61] = {0};
    	//ComRd (5, readBuf, 1); 
	//	readBuf[0] /= 2;
		int s;
		FlushInQ (5);  
		 s = ComRdByte(5);
	//	printf("%.0d\n" "%.0d\n", readBuf[0]);      
      	printf("%.0d\n" , s);   
		
			break;
	}
	return 0;
}
//==============================================================================  
int CVICALLBACK write (int panel, int control, int event,
					   void *callbackData, int eventData1, int eventData2)
{
	int x;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_NUMERIC, &x);
		// FlushOutQ (5);
		ComWrtByte(5, x);
		ComWrtByte(5, 64);
	//	GetOutQLen(5);   
	//	 FlushInQ (5);
			break;
	}
	return 0;
}
//==============================================================================  

int CVICALLBACK Read_Ring (int panel, int control, int event,
						   void *callbackData, int eventData1, int eventData2)
{
	int rs, adr485, com, nfad, vall;     
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		GetCtrlVal (panelHandle, PANEL_READ_RING, &nfad);
				switch (nfad)
 	 				{
       					case 1:  bum_GET_FR (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;  
       					case 2:  bum_GET_Phase (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;
       					case 3:  bum_GET_Nak (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break; 
       					case 4:  bum_GET_PulseLn (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;
       					case 5:  bum_GET_ReverseVt (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;
       					case 6:  bum_GET_Ident (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;
       					case 7:  bum_GET_485adr (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;  
       					case 8:  SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, 0); break;
       					case 9:  bum_GET_Shift6_6 (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;   
       					case 10: bum_GET_Magic (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;
       					case 11: bum_GET_BUR (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;
       					case 12: bum_GET_NAKOFF (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;
       					case 13: bum_GET_Del_Nak (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break; 
       					//case 14:  bum_GETFIRMWARE (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break;
       					//case 15:  bum_GETFIRMWARE (com, rs, adr485, &vall); SetCtrlVal (panelHandle, PANEL_GET_READ_PARAM, vall); break; 
      				 break;
     				}       
			break;
	}
	return 0;
}
//==============================================================================  
int CVICALLBACK PHASE_SET (int panel, int control, int event,
						   void *callbackData, int eventData1, int eventData2)
{
	int nfad, com;
	//long data;
 	int rs, adr485;
	
	switch (event)
	{
		case EVENT_COMMIT:
		   GetCtrlVal (panelHandle, PANEL_Phase, &nfad);
		//data=nfad/184.5;
		   GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		   GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		   GetCtrlVal (panelHandle, PANEL_ComRing, &com);
 		   bum_Write_to_phase (com, rs, adr485, nfad);
			break;
	}
	return 0;
}
//==============================================================================  
int CVICALLBACK SHIFT6_6_SET (int panel, int control, int event,
							  void *callbackData, int eventData1, int eventData2)
{
	int nfad, com;
	//long data;
 	int rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_Shift6_6, &nfad);
			//data=255-(nfad/5.787);  
			GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 			GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
			GetCtrlVal (panelHandle, PANEL_ComRing, &com);
			bum_PulseLenth_noStor (com, rs, adr485, nfad);
			break;
	}
	return 0;
}
//============================================================================== 
int CVICALLBACK FR_SET (int panel, int control, int event,
						void *callbackData, int eventData1, int eventData2)
{
	static float fr;
	//long data;
	int rs, adr485, com;
	
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_Frequance, &fr);
				//data=fr;
			GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 			GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
			GetCtrlVal (panelHandle, PANEL_ComRing, &com);
			bum_Write_to_fr (com, rs, adr485, fr);
			break;
	}
	return 0;
}
//==============================================================================       
int CVICALLBACK NAKOPLENIE_SET (int panel, int control, int event,
								void *callbackData, int eventData1, int eventData2)
{
	int nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_Nakoplenie, &nfad);
			//data=65535-((16000-nfad)/0.7234); gdf
			GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 			GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
			GetCtrlVal (panelHandle, PANEL_ComRing, &com);
 			bum_EnMod (com, rs, adr485, nfad);
			break;
	}
	return 0;
}
//==============================================================================       
int CVICALLBACK MAGIC_KEY_SET (int panel, int control, int event,
							   void *callbackData, int eventData1, int eventData2)
{
	int nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_Magic_Key, &nfad);
		//data=nfad/184.5;
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_MAGIC_KEY_SET (com, rs, adr485, nfad);
			break;
	}
	return 0;
}
//==============================================================================       
int CVICALLBACK PULSE_LENTH_SET (int panel, int control, int event,
								 void *callbackData, int eventData1, int eventData2)
{
	int nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_Pulse_lenth, &nfad);
		//data=255-(nfad/5.787);  
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_PulseLenth (com, rs, adr485, nfad);
			break;
	}
	return 0;
}
//==============================================================================       
int CVICALLBACK Nakoplenie_OFF_R (int panel, int control, int event,
								  void *callbackData, int eventData1, int eventData2)
{
	int nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_NAKOPLENIE_SWITCH_R, &nfad);
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_NAK_ON_OFF (com, rs, adr485, nfad);
			break;
	}
	return 0;
}

int CVICALLBACK LED_RESET_BOTTOM (int panel, int control, int event,
								  void *callbackData, int eventData1, int eventData2)
{
	int nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
				
		SetCtrlVal (panelHandle, PANEL_Reverse_Volt_LED, 0);		  	  
		SetCtrlVal (panelHandle, PANEL_U_Modulator, 0);
		SetCtrlVal (panelHandle, PANEL_Protection_BUP, 0);
		SetCtrlVal (panelHandle, PANEL_Cross_over, 0);
		SetCtrlVal (panelHandle, PANEL_Synhroniz_off, 0);
		SetCtrlVal (panelHandle, PANEL_Restart_Mark, 0);
		bum_WriteToResetReg (com, rs, adr485, 159);
		break;
	}
	return 0;
}

int CVICALLBACK Reverse_V_SIM (int panel, int control, int event,
							   void *callbackData, int eventData1, int eventData2)
{
	int rs, adr485, com;  
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_Write_to_ReverseVSim (com, rs, adr485);
			break;
	}
	return 0;
}

int CVICALLBACK MAGIC_KEY_ADJ_SET (int panel, int control, int event,
								   void *callbackData, int eventData1, int eventData2)
{
	int nfad, com;
	//long data;
 	int rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_Bur_Time, &nfad);
		//data=nfad*1.38;
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
 		bum_Write_to_Bur_Time (com, rs, adr485, nfad);
			break;
	}
	return 0;
}

int CVICALLBACK Rect_protect_OFF (int panel, int control, int event,
								  void *callbackData, int eventData1, int eventData2)
{
	int nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_RECT_PROTECT_OFF, &nfad);
			GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 			GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
			GetCtrlVal (panelHandle, PANEL_ComRing, &com);
			bum_RECT_PROT_OFF (com, rs, adr485, nfad);
			break;
	}
	return 0;
}

int CVICALLBACK Rev_protect_OFF (int panel, int control, int event,
								 void *callbackData, int eventData1, int eventData2)
{
	int nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_REV_PROTECT_OFF, &nfad);
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_REV_PROT_OFF (com, rs, adr485, nfad);
			break;
	}
	return 0;
}

int CVICALLBACK Slow_up_OFF (int panel, int control, int event,
							 void *callbackData, int eventData1, int eventData2)
{
	int nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_SLOW_UP_OFF, &nfad);
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_SLOW_UP_OFF (com, rs, adr485, nfad);
			break;
	}
	return 0;
}

int CVICALLBACK Pulse_lenth_1Stor (int panel, int control, int event,
								   void *callbackData, int eventData1, int eventData2)
{
	int nfad, com;
	//long data;
 	int rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_Pulse_LENTH_1Stor, &nfad);
		//data=255-(nfad/5.787);  
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_PulseLenth_Stor (com, rs, adr485, nfad);
			break;
	}
	return 0;
}

int CVICALLBACK U_REVERSE_SET (int panel, int control, int event,
							   void *callbackData, int eventData1, int eventData2)
{
	int com, rs, adr485;
	float reverse_U;
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_U_Reverce, &reverse_U);
		//data=1024*reverse_U/5.0;
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_Write_to_ReverseV (com, rs, adr485, reverse_U);
			break;
	}
	return 0;
}

int CVICALLBACK U_REVERSE_SET_noStor (int panel, int control, int event,
									  void *callbackData, int eventData1, int eventData2)
{
	int com, rs, adr485;
	float reverse_U_noStor;
	
	switch (event)
	{
		case EVENT_COMMIT:
		GetCtrlVal (panelHandle, PANEL_U_Reverce_noStor, &reverse_U_noStor);
		//data=1024*reverse_U/5.0;
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_Write_to_ReverseV_noStor (com, rs, adr485, reverse_U_noStor);
			break;
	}
	return 0;
}

int CVICALLBACK Get_V_LINE (int panel, int control, int event,
							void *callbackData, int eventData1, int eventData2)
{
	double nfad;
	//long data;
 	int com, rs, adr485;
	switch (event)
	{
		case EVENT_COMMIT:
		 	GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 			GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
			GetCtrlVal (panelHandle, PANEL_ComRing, &com);
			bum_Get_V_LINE (com, rs, adr485, &nfad);
			SetCtrlVal (panelHandle, PANEL_GET_V_Line, nfad);
			break;
	}
	return 0;
}

int CVICALLBACK Protection_Check (int panel, int control, int event,
								  void *callbackData, int eventData1, int eventData2)
{
	int code=0,temp=0;
	int com;
	//long data;
 	int rs, adr485;
	
	switch (event)
	{
		case EVENT_TIMER_TICK:
		GetCtrlVal (panelHandle, PANEL_ComRs, &rs);
 		GetCtrlVal (panelHandle, PANEL_adres485, &adr485);
		GetCtrlVal (panelHandle, PANEL_ComRing, &com);
		bum_Protection (com, rs, adr485, &code);
				
		temp=code;
		temp=temp & 1;
		if (temp==1) SetCtrlVal (panelHandle, PANEL_Reverse_Volt_LED, 1);
		temp=code;
		temp=temp & 4;
		if (temp==4) SetCtrlVal (panelHandle, PANEL_U_Modulator, 1);
		temp=code;
		temp=temp & 2;
		if (temp==2) SetCtrlVal (panelHandle, PANEL_Protection_BUP, 1);
		temp=code;									  
		temp=temp & 8;
		if (temp==8) SetCtrlVal (panelHandle, PANEL_Synhroniz_off, 1);
		temp=code;
		temp=temp & 16;
		if (temp==16) SetCtrlVal (panelHandle, PANEL_Cross_over, 1);
		temp=code;
		temp=temp & 32;
		if (temp==32) SetCtrlVal (panelHandle, PANEL_Restart_Mark, 1);
		break;
	}
	return 0;
}
