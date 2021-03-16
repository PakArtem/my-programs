#include <rs232.h>
#include <utility.h>
#include <userint.h>
			
#define TRUE	1
#define FALSE	0
int TryMax; 
int com_activated = FALSE;  

int ReadFromBuis(int com, int adr485, long command, long *data);
int WriteToCom(int com_number, int data);
int ReadFromCom(int com_number, int *data);
//==============================================================================
//
//==============================================================================
void bum_inicom(int com, int boudrate, int rs, int adr485, int *connect)  
{
 long data;
 int try=0;
 int TryMax=10;
  char x =  'a';
 if (com==1) OpenComConfig (1, "com1", boudrate, 2, 8, 1, 512, 512);
 if (com==2) OpenComConfig (2, "com2", boudrate, 2, 8, 1, 512, 512);
 if (com==3) OpenComConfig (3, "com3", boudrate, 2, 8, 1, 512, 512);
 if (com==4) OpenComConfig (4, "com4", boudrate, 2, 8, 1, 512, 512);
 if (com==5) OpenComConfig (5, "com5", boudrate, 2, 8, 1, 512, 512);
 if (com==6) OpenComConfig (6, "com6", boudrate, 2, 8, 1, 512, 512);
 if (com==7) OpenComConfig (7, "com7", boudrate, 2, 8, 1, 512, 512);
 if (com==8) OpenComConfig (8, "com8", boudrate, 2, 8, 1, 512, 512);
 if (com==9) OpenComConfig (9, "com9", boudrate, 2, 8, 1, 512, 512);
 if (com==10) OpenComConfig (10, "com10", boudrate, 2, 8, 1, 512, 512);
 if (com==11) OpenComConfig (11, "com11", boudrate, 2, 8, 1, 512, 512);
 if (com==12) OpenComConfig (12, "com12", boudrate, 2, 8, 1, 512, 512);
 if (com==14) OpenComConfig (14, "com14", boudrate, 2, 8, 1, 512, 512);
 if (com==18) OpenComConfig (18, "com18", boudrate, 2, 8, 1, 512, 512);
//  SetXMode(5,0);
 com_activated = TRUE; 
 ReadFromBuis(com, adr485, 127, &data);
 if (data==1131 || data==1208) *connect = 1;
}
//==============================================================================
//
//==============================================================================
int ReadFromBuis(int com, int adr485, long command, long *data)
{
int stop = 0;
int bufL;
int bufH;
int commint;
int dataint;
int try=0;
TryMax = 10;
commint = command;
dataint = *data;
 //FlushOutQ (5); 
if (WriteToCom(com, adr485)==-10) return(-10);
if (ReadFromCom(com, &bufL)==-10) return(-10);
if (bufL != 0xF) return(-10);
commint = commint | 0x80;
if (WriteToCom(com, commint)==-10) return(-10);
if (ReadFromCom(com, &bufL)==-10) return(-10);
if (bufL != commint) return(-1);
if (ReadFromCom(com, &bufL)==-10) return(-10);
if (WriteToCom(com, bufL)==-10) return(-10);
if (ReadFromCom(com, &bufH)==-10) return(-10);
if (WriteToCom(com, bufH)==-10) return(-10);
if (ReadFromCom(com, &stop)==-10) return(-10);
if (stop != 0xBB) return(-1);


dataint = bufH << 8;
dataint = dataint | bufL;
*data   = dataint;
return(0);
}
//==============================================================================
//
//==============================================================================
int WriteToBuis(int com, int adr485, long command, long data)
{
 int buf, temp = 0;
 int bufL, bufH;
 int comint;
 int dataint;

 comint  = command ;
 dataint = data;
 
 bufL = dataint & 0xFF;
 bufH = (dataint >> 8) & 0xFF;
 temp = 0xBB;

 if (WriteToCom(com, adr485)==-10) return(-10);
 if (ReadFromCom(com, &buf)==-10) return(-10);
 if (buf != 0xF) return(-1);
 if (WriteToCom(com, comint)==-10) return(-10);
 if (ReadFromCom(com, &buf)==-10)  return(-10);
 if (buf != comint) return(-1);
 //buf1=dataint & 0xFF;
 //if (buf1==71) {buf1=74; temp=0xBC;}
 //if (buf1==72) {buf1=75; temp=0xBD;}
 
 if (WriteToCom(com, bufL)==-10) return(-10);
 if (ReadFromCom(com, &buf)==-10) return(-10);
 if (buf != bufL) return(-1);
 //buf1=(dataint >> 8) & 0xFF;
 //if (buf1==71) {buf1=74; temp=0xBC;}
 //if (buf1==72) {buf1=75; temp=0xBD;}
 
 if (WriteToCom(com, bufH)==-10) return(-10);
 if (ReadFromCom(com, &buf)==-10) return(-10); 
 if (buf != bufH) return(-1);
 if (WriteToCom(com, temp)==-10) return(-10);
 return(0);

}
//==============================================================================
//
//==============================================================================
int WriteToCom(int com_number, int data)
{
double s;
int x;
/*outp(basecom+0x8,data);
s=Timer();
while (inp(basecom+0xD) & 0x20 == 0)
           {

             if ((Timer()-s)>timecu)  return(-10);

           }
 return(0);*/
//if (com_activated == FALSE ) return(-10);
//s = Timer();    
//FlushOutQ (5);

//FlushInQ (5);
//ComWrtByte (5, data);
//FlushOutQ (5);
//FlushInQ (com_number);     
ComWrtByte (5, data);
//FlushInQ (com_number);
/*
while(GetOutQLen(5))
{
Delay(0.001);
}
*/
s=Timer();  
//x = GetOutQLen(5);
/* while (GetOutQLen (com_number)!=0)
	   {

             if ((Timer()-s)>timecu) return(-10);

           }	 */
return(0); 
}
//==============================================================================
//
//==============================================================================
int ReadFromCom(int com_number, int *data)
{
double s;
if (com_activated == FALSE ) return(-10); 
//s = Timer();
/*while (((inp(basecom+0xD) & 1) != 1) | ((inp(basecom+0xD) & 0xE) != 0))
               {
                if ((Timer()-s)>timecu) {return(-10);} 
               }
*data=inp(basecom+0x8) & 0xFF;
return(0);  */
/*while (GetInQLen (com_number)==0)
	   {
			 
             if ((Timer()-s)>timecu) return(-10);

           }	 */

*data = ComRdByte (com_number);
//  FlushInQ (5);  
return(0); 
}
//==============================================================================
//
//==============================================================================
int bum_GET_FR (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
 if (rs==232)
{
while(ReadFromBuis(com, adr485, 25, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
*fw=data;
}
 		
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_Phase (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int temp;
 int try=0;
 
 if (rs==232)
{
 while(ReadFromBuis(com, adr485, 27, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
 temp=data;
}
//*fw=(255-data)*92.6;
 *fw = data; 
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_Nak (int com, int rs, int adr485, int *fw)	 
{
 long data;
 //int temp;
 int try=0;
 
if (rs==232)
{
 while(ReadFromBuis(com, adr485, 23, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
 //temp=data;
}
*fw=(65535-data)*0.7234;
//data=65535-(tnak/0.7234);
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_PulseLn (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
if (rs==232)
{
while(ReadFromBuis(com, adr485, 21, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
//*fw=data;
}
*fw=(65535-data)*0.0904;
				//data=65535-(pulsl/0.0904);
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_ReverseVt (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
if (rs==232)
{
while(ReadFromBuis(com, adr485, 30, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
//*fw=data*1000;
}
			
*fw=data*5000/0x7F;
				//data=0x7F*volt/5.0;
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_Ident (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
 if (rs==232)
{
 while(ReadFromBuis(com, adr485, 127, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
 //*fw=data*1000;
}
 		
*fw=data;
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_485adr (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
if (rs==232)
{
 while(ReadFromBuis(com, adr485, 126, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
 //*fw=data*1000;
}
*fw=data;
 return(0);
}

//==============================================================================
//
//==============================================================================
int bum_GET_Shift6_6 (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
if (rs==232)
{
 while(ReadFromBuis(com, adr485, 26, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
//*fw=data*1000;
						
}
 			
*fw=(255-data)*92.6;
				//data=255-shift6_6/92.6;
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_Magic (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
if (rs==232)
{
 while(ReadFromBuis(com, adr485, 22, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
 //*fw=data*1000;
						
}
 			
*fw=(65535-data)*0.7234;
//data=65535-(magic/0.7234);
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_BUR (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
if (rs==232)
{
while(ReadFromBuis(com, adr485, 19, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
//*fw=data*1000;
}
		
 *fw=(65535-data)*0.7234;
//data=65535-(time/0.7234);
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GETFIRMWARE (int com, int rs, int adr485, int *fw)	 //Acyou ec BUM iiia? i?ia?aiiu (i?eia? 1942, icia?aao i?ia?aiia ?1 ia ieaoa ?942)
{
 long data;
 int try=0;
 
if (rs==232)
{
while(ReadFromBuis(com, adr485, 125, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
*fw=data;
}
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_NAKOFF (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
if (rs==232)
{
while(ReadFromBuis(com, adr485, 20, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
//*fw=data;
}
			
if (data==35) *fw=0;
if (data==155) *fw=1;
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_GET_Del_Nak (int com, int rs, int adr485, int *fw)	 
{
 long data;
 int try=0;
 
if (rs==232)
{
while(ReadFromBuis(com, adr485, 24, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
//*fw=data*1000;
}
*fw=(65535-data)*0.7234;
				//data=65535-((16000-tnak)/0.7234);
 return(0);
}

//==============================================================================
//
//==============================================================================
int bum_Protection (int com, int rs, int adr485, long *d)
{
	int try=0;
	long data;

if (rs==232)
{
while(ReadFromBuis(com, adr485, 29,&data) != 0) {try=try+1; if (try>TryMax) return(-1);}
*d=data;
}
	return(0);
}
//==============================================================================
//
//==============================================================================
//==============================================================================
//
//==============================================================================
int bum_Write_to_phase (int com, int rs, int adr485, int phase)
{
int try=0;
long data;
if (phase<0) phase=0;
data = phase;

if (rs==232)
{
while (WriteToBuis(com, adr485, 1, data) != 0) {try++; if (try>TryMax) return(-1);}
}
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_Write_to_Shift6_6 (int com, int rs, int adr485, int shift6_6)
{
int try=0;
long data;
if (shift6_6 < 0) shift6_6 = 0;
data = shift6_6;

if (rs==232)
{
while (WriteToBuis(com, adr485, 2, data) != 0) {try++; if (try>TryMax) return(-1);}
}
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_Write_to_fr (int com, int rs, int adr485, long data)
{
int try=0;
if (rs==232)
{
while (WriteToBuis(com, adr485, 3, data) != 0) {try++; if (try>TryMax) return(-1);}
}
return(0);
}  
//==============================================================================
//
//==============================================================================
int bum_EnMod (int com, int rs, int adr485, int tnak)
{
	int try=0;
	long data;

	if (tnak < 3000) tnak=3000;
	if (tnak > 16998) tnak=16998;
	
	data = 17000 - tnak;

	if (rs==232)
	{
 		while (WriteToBuis(com, adr485, 4,data) != 0) {try++; if (try>TryMax) return(-1);}
	}
	Delay(0.05);
	data = tnak;
	
	if (rs==232)
	{
 		while (WriteToBuis(com, adr485, 5,data) != 0) {try++; if (try>TryMax) return(-1);}
	}
 
	return(0);
	
}
//==============================================================================
//
//==============================================================================
int bum_MAGIC_KEY_SET (int com, int rs, int adr485, int magic)
{
int try=0;
long data;

if (magic<2000) magic=2000;
if (magic>20000) magic=20000;
data = magic;

if (rs==232)
{
	while (WriteToBuis(com, adr485, 6,data) != 0) {try++; if (try>TryMax) return(-1);}
}
 				
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_PulseLenth (int com, int rs, int adr485, int pulsl)
{
	int try=0;
	long data;

	if (pulsl < 300) pulsl = 300;
	if (pulsl > 1000) pulsl = 1000;
//	data=65535-(pulsl/0.0904);
	data = pulsl; 
	if (rs==232)
	{
 		while (WriteToBuis(com, adr485, 7,data) != 0) {try++; if (try>TryMax) return(-1);}
	}
 	
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_NAK_ON_OFF (int com, int rs, int adr485, int nfad)
{
	int try=0;

	if (nfad==1)
	{
		if (rs==232)
	 	{
 		while (WriteToBuis(com, adr485, 8, 155) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
	if (nfad==0)
	{
		if (rs==232)
	 	{
 		while (WriteToBuis(com, adr485, 8, 35) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_WriteToResetReg (int com, int rs, int adr485, long data)
{
	int try=0;
	//data=155;//d & 0xFF;

	if (rs==232)
	{
 	while (WriteToBuis(com, adr485, 9, data) != 0) {try++; if (try>TryMax) return(-1);}
	}
 
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_Write_to_ReverseVSim (int com, int rs, int adr485)
{
int try;
//long data;
try=0;
	if (rs==232)
	{
 		while (WriteToBuis(com, adr485, 11, 199) != 0) {try++; if (try>TryMax) return(-1);}
	}
 				
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_Write_to_Bur_Time (int com, int rs, int adr485, int time)
{
int try=0;
long data;

if (time<20) time=20;
if (time>3000) time=3000; 
data=65535-(time/0.7234);

if (rs==232)
{
	while (WriteToBuis(com, adr485, 12,data) != 0) {try++; if (try>TryMax) return(-1);}
}
 				
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_RECT_PROT_OFF (int com, int rs, int adr485, int nfad)
{
	int try=0;

	if (nfad==1)
	{
		if (rs==232)
	 	{
 			while (WriteToBuis(com, adr485, 13, 36) != 0) {try++; if (try>TryMax) return(-1);}
		}
 			
	}
	if (nfad==0)
	{
		if (rs==232)
	 	{
 			while (WriteToBuis(com, adr485, 13, 156) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_REV_PROT_OFF (int com, int rs, int adr485, int nfad)
{
	int try=0;

	if (nfad==1)
	{
		if (rs==232)
	 	{
 			while (WriteToBuis(com, adr485, 14, 37) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
	if (nfad==0)
	{
		if (rs==232)
	 	{
 			while (WriteToBuis(com, adr485, 14, 157) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_SLOW_UP_OFF (int com, int rs, int adr485, int nfad)
{
	int try=0;

	if (nfad==1)
	{
		if (rs==232)
	 	{
 			while (WriteToBuis(com, adr485, 15, 38) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
	if (nfad==0)
	{
		if (rs==232)
	 	{
 			while (WriteToBuis(com, adr485, 15, 158) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
return(0);
}
//==============================================================================
//
//==============================================================================
/*int bum_REV_V_ON (int com, int rs, int adr485, int nfad)
{
	int try=0;

	if (nfad==1)
	{
		if (rs==232)
	 	{
 			while (WriteToBuis(com, adr485, 16, 39) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
	if (nfad==0)
	{
		if (rs==232)
	 	{
 			while (WriteToBuis(com, adr485, 16, 159) != 0) {try++; if (try>TryMax) return(-1);}
		}
	}
return(0);
}*/
//==============================================================================
//
//==============================================================================
int bum_PulseLenth_noStor (int com, int rs, int adr485, int pulsl)
{
	int try=0;
	long data;

	if (pulsl<300) pulsl=300;
	if (pulsl>1000) pulsl=1000;
	data = pulsl;
	if (rs==232)
	{
 		while (WriteToBuis(com, adr485, 17,data) != 0) {try++; if (try>TryMax) return(-1);}
	}
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_PulseLenth_Stor (int com, int rs, int adr485, int pulsl)
{
	int try=0;
	long data;

	if (pulsl<300) pulsl=300;
	if (pulsl>1000) pulsl=1000;
	data = pulsl;
	if (rs==232)
	{
 		while (WriteToBuis(com, adr485, 18,data) != 0) {try++; if (try>TryMax) return(-1);}
	}
return(0);
}
//==============================================================================
//
//==============================================================================
int bum_Write_to_ReverseV (int com, int rs, int adr485, float volt)
{
 long data;
 int try=0;
 
 if (volt>10) volt=10;
 if (volt<0) volt=0;
 data=0x7F*volt/5.0; 
	if (rs==232)
	{
 		while (WriteToBuis(com, adr485, 50,data) != 0) {try++; if (try>TryMax) return(-1);}
	}
 				
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_Write_to_ReverseV_noStor (int com, int rs, int adr485, float volt)
{
 long data;
 int try=0;
 
 if (volt>10) volt=10;
 if (volt<0) volt=0;
 data=0x7F*volt/5.0; 
 if (rs==232)
 {
 	while (WriteToBuis(com, adr485, 51,data) != 0) {try++; if (try>TryMax) return(-1);}
 }
 				
 return(0);
}
//==============================================================================
//
//==============================================================================
int bum_Get_V_LINE (int com, int rs, int adr485, double *nfad)  
{														 
	long data;
	double temp;
	int try = 0;

	if (rs == 232)
	{
 		while(ReadFromBuis(com, adr485, 28, &data) != 0) {try=try+1; if (try>TryMax) return(-1);}
 		temp = data;
		*nfad = temp;
	}
//	if (temp >= 0x80) * nfad = (0xFF - temp) * -5.0 / 0x7F + 0.2;
//	else *nfad = temp * 5.0 / 0x7F + 0.2; 
return(0);
}
