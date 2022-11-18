/*
 * WangWriter.h
 */

#ifndef WANGWRITER_H_
#define WANGWRITER_H_

#define D0 0
#define D1 1
#define D2 2
#define D3 3
#define D4 4
#define D5 5
#define D6 6
#define D7 7

#include "VTAC.h"

// Port definitions

#define CLICKER			0x00
#define BEEPER			0x01
#define UPPER_BANK_SEL	0x03
#define RAM_BANK_SEL	0x05
#define CTC_RESET		0x06
#define DEVICE_OPTIONS	0x07
#define DISK_CONTROL	0x0A
#define DISK_DATA		0x0B
#define DISK_STATUS		0x0C

#define	CTC_CH0			0x20
#define CTC_CH1			0x21
#define	CTC_CH2			0x22
#define CTC_CH3			0x23

#define PIO_PORTA		0x30
#define	PIO_PORTB		0x31
#define PIO_CMDA		0x32
#define PIO_CMDB		0x33

#define VTAC_H_COUNT	0x40
#define VTAC_SYNC		0x41
#define VTAC_SCANS_ROW	0x42
#define VTAC_ROWS_FRAME	0x43
#define VTAC_LINES_FRAME 0x44
#define VTAC_VERT_START	0x45
#define VTAC_LAST_DATA	0x46
#define VTAC_READ_C_ROW 0x48
#define VTAC_READ_C_COL 0x49
#define VTAC_RESET		0x4A
#define VTAC_UPSCROLL	0x4B
#define VTAC_LOAD_C_COL 0x4C
#define VTAC_LOAD_C_ROW 0x4D
#define VTAC_START		0x4E

#define PRINTER_PORTA	0x50
#define PRINTER_PORTB	0x51
#define PRINTER_CMDA	0x52
#define PRINTER_CMDB	0x53

#define PRINTER_CONTROL	0x5C
#define ERROR_DISPLAY	0x5F

#define DISK_TRACKS		35
#define DISK_SECTORS	16
#define DISK_BYTES		256

typedef struct wangwriter
{
	z80_t cpu;
	z80pio_t pioa;
	z80pio_t pio_printer;
	z80ctc_t ctc;
	upd765_t fdc;
	vtac_t vtac;

	bool keyboard_strobe;
	bool printer_enable;
	bool fdc_irq;
	bool fdc_drq;
	bool fdc_tc;
	bool rtc_tick;
} wangwriter_t;

typedef struct diskdrive
{
	char image_name[256];
	FILE *image;
	uint8_t buffer[512];
	int data_p;
	int drive;
	int sector;
	int multi_sector;
	int track;
	int sector_size;
	uint8_t cmd;
} diskdrive_t;

int fdc_seektrack (int drive, int track, void* user_data);
int fdc_seeksector (int drive, int side, upd765_sectorinfo_t* inout_info, void* user_data);
int fdc_read (int drive, int side, void* user_data, uint8_t* out_data);
int fdc_trackinfo (int drive, int side, void* user_data, upd765_sectorinfo_t* out_info);
void fdc_driveinfo (int drive, void* user_data, upd765_driveinfo_t* out_info);


#endif /* WANGWRITER_H_ */
