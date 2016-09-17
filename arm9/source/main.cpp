/*---------------------------------------------------------------------------------

	Simple eeprom example
	-- davr

---------------------------------------------------------------------------------*/
#include <nds.h>
#include <string.h>
#include <stdio.h>
#include <unistd.h>
#include "nds/arm9/console.h"

void memcpy16( u16 *dst, u16 *src, int numbytes ) {
  int i= numbytes / 2;
  while( i>0 ) { *dst= *src; dst++; src++; i--; }
}

u16 palette[]= {
  /*0*/ RGB15( 0, 0, 0), // index 0 is transparant
  /*1*/ RGB15(31,31,31), // white background
  /*2*/ RGB15( 0, 0,31), // blue for cell borders
  /*3*/ RGB15(31, 0, 0)  // red for dot
};

u8 tiles[] = { 
  // completely white
  1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,
  1,1,1,1,1,1,1,1,
  // blue border
  0,0,0,0,0,0,0,2,
  0,0,0,0,0,0,0,2,
  0,0,0,0,0,0,0,2,
  0,0,0,0,0,0,0,2,
  0,0,0,0,0,0,0,2,
  0,0,0,0,0,0,0,2,
  0,0,0,0,0,0,0,2,
  2,2,2,2,2,2,2,2,
  // red dot
  0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,
  0,0,3,3,3,0,0,0,
  0,0,3,3,3,0,0,0,
  0,0,3,3,3,0,0,0,
  0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0,
  0,0,0,0,0,0,0,0
};


//---------------------------------------------------------------------------------
void dopause() {
//---------------------------------------------------------------------------------
	iprintf("Press start...\n");
	while(1) {
		scanKeys();
		if(keysDown() & KEY_START)
			break;
		swiWaitForVBlank();
	}
	scanKeys();
}

void turnScreenRed(void) {
	setBackdropColor( RGB15(31, 0, 0));
}

void turnScreenBlack(void) {
	setBackdropColor( RGB15(0, 0, 0));
}

typedef struct{
	char name[23]; // "/XXXX_ZZZZZZZZZZZZ.nds, 1+4+1+12+4+1
	u32 romID;
	u32 size;
	u32 writeoffset;
	u32 dumpoffset;
}dumphandle;

dumphandle dump;

char	*data;

extern const unsigned char key_tbl[0x4000];

//---------------------------------------------------------------------------------
int main(void) {
//---------------------------------------------------------------------------------
    nocashMessage("ARM9 main.cpp main");
	consoleDemoInit();
	
	defaultExceptionHandler();
	
	unsigned int * SCFG_ROM=	(unsigned int*)0x4004000;
	unsigned int * SCFG_CLK=	(unsigned int*)0x4004004; 
	unsigned int * SCFG_EXT=	(unsigned int*)0x4004008;
	
	iprintf( "SCFG_ROM %x\n", *SCFG_ROM ); // DS MODE 80	
	iprintf( "SCFG_CLK %x\n", *SCFG_CLK ); // DS MODE 80
	iprintf( "SCFG_EXT %x\n", *SCFG_EXT ); // DS MODE 8307F19F
	
	if(*SCFG_EXT==0) {
		iprintf( "NTR mode detected\n" ); // DS MODE 80
		iprintf( "Enabling special mode\n" ); // DS MODE 80
		
		*SCFG_EXT = 0x830F0100;
		
		if(*SCFG_EXT>0) {
			iprintf( "Special mode enabled\n" ); // DS MODE 80
			iprintf( "SCFG_ROM %x\n", *SCFG_ROM ); // DS MODE 80	
			iprintf( "SCFG_CLK %x\n", *SCFG_CLK ); // DS MODE 80
			iprintf( "SCFG_EXT %x\n", *SCFG_EXT ); // DS MODE 8307F19F
		}
	} 
	
	iprintf( "Boosting cpu speed\n" ); // DS MODE 80
	
	*SCFG_CLK=	*SCFG_CLK | 1;
	
	iprintf( "SCFG_CLK %x\n", *SCFG_CLK ); // DS MODE 80
	
	if(*SCFG_CLK==0x81) {
		iprintf( "Cpu speed boosted\n"); // DS MODE == 81
	} else {
		iprintf( "Cpu speed boost faild\n"); // DS MODE != 81
	}
	
	dopause();
	
	 // initialize video
	REG_DISPCNT = MODE_0_2D | DISPLAY_BG0_ACTIVE;
	vramSetBankA(VRAM_A_MAIN_BG);
	
	while (1==1) {	
		for (int i=0; i<1000000; i++) {
			turnScreenRed();
			bgUpdate();
		}
		
		for (int i=0; i<1000000; i++) {
			turnScreenBlack();
			bgUpdate();
		}
	}

	return 0;
}
