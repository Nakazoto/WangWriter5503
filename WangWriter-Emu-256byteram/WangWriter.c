#include <unistd.h>
#include <SDL.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define CHIPS_IMPL
#include "chips/z80.h"
#include "chips/z80ctc.h"
#include "chips/z80pio.h"
#include "chips/upd765.h"
#include "VTAC.h"
#include "WangWriter.h"

/* CPU Parameters */
#define F_CPU 4000000

/* CRT Parameters */
#define ROWS 24
#define COLUMNS 80

#define HPIXELS (COLUMNS * 8)
#define VPIXELS (ROWS * 16)
#define STATUSBAR 50


/* I/O ports */
#define P_COUNTER 0x00
#define P_CTRL 0x08
#define P_BANK 0x10
#define P_VADDR 0x18
#define P_KBD 0x20

/* Mask for P_CONTROL port */
#define M_COLOUR 0x07
#define M_BORDER 0x08
#define M_BLANK 0x10
#define M_VSYNC 0x20

/* Machine memory */
uint8_t *ram, *bankram[7], *rom, *charrom, *vram;
uint32_t *framebuffer;

/* Machine specific I/O registers */
uint8_t prom_sel = 0;
uint8_t ram_sel = 0;
uint8_t disk_control = 0;
uint8_t led_display = 0xFF;

int emulate(uint16_t origin);
void update_framebuffer (uint32_t *fb);

#ifdef WIN32
#include <windows.h>
int APIENTRY WinMain(HINSTANCE hInst, HINSTANCE hInstPrev, PSTR cmdline, int cmdshow)
#else
int main(int argc, char *argv[])
#endif
{
	int execute = 1;
	uint16_t origin = 0xC000;
	FILE *fp;

	ram = malloc (32768);		// Main RAM below 0x8000
	for (int i = 0; i < 7; i++)
	{
		bankram[i] = malloc (16384);			// Bank switch RAM
	}

	rom = malloc (2048);
	charrom = malloc (1024);
	vram = malloc (16384);
	// SDL Framebuffer
	framebuffer = malloc(sizeof(uint32_t)*HPIXELS*(VPIXELS+STATUSBAR));

	if (ram == NULL || rom == NULL || charrom == NULL || vram == NULL || framebuffer == NULL)
	{
		fprintf (stderr, "Unable to allocate RAM for emulation!\n");
		execute = 0;
	}

	fp = fopen("D2716.BIN", "rb");
	if (fp == NULL)
	{
		fprintf (stderr, "Unable to open D2716.BIN\n");
		execute = 0;
	}
	else
	{
		fread (rom, 1, 2048, fp);
		fclose (fp);
	}

	fp = fopen("MM2708C.BIN", "rb");
	if (fp == NULL)
	{
		fprintf (stderr, "Unable to open MM2708C.BIN\n");
		execute = 0;
	}
	else
	{
		fread (charrom, 1, 1024, fp);
		fclose (fp);
	}

	/*fp = fopen("NotSystemDisk.cim", "rb");
	if (fp != NULL)
	{
		fread (ram + 0x200, 1, 1024, fp);
		fclose (fp);
		origin = 0x200;
		printf ("Loading boot sector\n");
	}*/

	if (execute)
	{
		memset (framebuffer, 0, sizeof(uint32_t)*HPIXELS*VPIXELS);
		memset (framebuffer + HPIXELS*VPIXELS, 0x00888888, sizeof(uint32_t)*HPIXELS*STATUSBAR);

		// Clear a space for the LED display
		for (int y = 10; y < 40; y++)
		{
			for (int x = 5; x < 30; x++)
				framebuffer[x+(y*HPIXELS) + HPIXELS*VPIXELS] = 0;
		}

		for (int i = 0; i < 16384; i++)
			vram[i] = rand();

		printf ("Emulation starts...\n");
		emulate (origin);
	}

	printf ("Terminate\n");
	for (int i = 0; i < 7; i++)
	{
		free (bankram[i]);	// Bank switch RAM
	}
	free(vram);
	free(charrom);
	free(ram);
	free(rom);
	return 0;
}

uint64_t cpu_tick (wangwriter_t *machine, uint64_t pins)
{
	int chain = 0;
	bool old = 0;

	pins = z80_tick (&machine->cpu, pins);

	// This is a hack to get past the interrupt counter
	if (machine->cpu.pc == 0xC55E)
	{
		machine->cpu.b = 0x44;
	}

	if (pins & Z80_MREQ)
	{
		const uint16_t addr = Z80_GET_ADDR(pins);
		if (pins & Z80_RD)
		{
			if (addr < 0x8000)
			{
				// Read from unbanked RAM
				Z80_SET_DATA(pins, ram[addr]);
			}
			else if (addr < 0xC000)
			{
				uint8_t d = bankram[ram_sel][addr-0x8000];
				Z80_SET_DATA(pins, d);
			}
			else
			{
				if (prom_sel & 0x80)
				{
					// Read from VRAM
					Z80_SET_DATA(pins, vram[addr-0xC000]);
				}
				else
				{
					// Read from boot ROM
					if (addr < 0xC800)
					{
						Z80_SET_DATA(pins, rom[addr-0xC000]);
					}
				}
			}
		}

		if (pins & Z80_WR)
		{
			const uint8_t data = Z80_GET_DATA(pins);
			if (addr < 0x8000)
			{
				// Write to unbanked RAM
				ram[addr] = data;
			}
			else if (addr < 0xC000)
			{
				// Write to banked RAM
				bankram[ram_sel][addr-0x8000] = data;
			}
			else
			{
				vram[addr-0xC000] = data;
			}
		}
	}

	/* Handle I/O */
	if ((pins & Z80_IORQ) && ((pins & Z80_M1) == 0))
	{
		const uint16_t addr = Z80_GET_ADDR(pins);
		if (pins & Z80_RD)
		{
			switch (addr & 0xFF)
			{
				case DISK_CONTROL:
				{
					Z80_SET_DATA(pins, disk_control);
					break;
				}

				case VTAC_READ_C_ROW:
				{
					Z80_SET_DATA(pins, vtac_read_cursor_row (&machine->vtac));
					break;
				}

				case VTAC_READ_C_COL:
				{
					Z80_SET_DATA(pins, vtac_read_cursor_column (&machine->vtac));
					break;
				}
			}
			//printf ("Read  I/O to %02X with %02X\n", addr & 0xFF, Z80_GET_DATA(pins), cpu.state.PC);
		}

		/* Write I/O */
		else
		{
			const uint8_t data = Z80_GET_DATA(pins);
			switch (addr & 0xFF)
			{
				case UPPER_BANK_SEL:
				{
					prom_sel = data;
					break;
				}
				case RAM_BANK_SEL:
				{
					printf ("Bank to %i\n", data);
					ram_sel = data & 7;
					break;
				}
				case DISK_CONTROL:
				{
					disk_control = data;
					if (data & (1<<D5))
					{
						printf ("FDC reset\n");
						upd765_reset (&machine->fdc);
					}

					if (data & (1<<D4))
					{
						printf ("FDC TC\n");
						machine->fdc_tc = true;
					}
					else
						machine->fdc_tc = false;
					break;
				}

				case VTAC_H_COUNT:
				{
					vtac_load_horiz_line_count (&machine->vtac, data);
					break;
				}

				case VTAC_SYNC:
				{
					vtac_load_sync_width (&machine->vtac, data);
					break;
				}

				case VTAC_SCANS_ROW:
				{
					vtac_load_scans_row (&machine->vtac, data);
					break;
				}

				case VTAC_ROWS_FRAME:
				{
					vtac_load_rows_frame (&machine->vtac, data);
					break;
				}

				case VTAC_LINES_FRAME:
				{
					vtac_load_scan_lines (&machine->vtac, data);
					break;
				}

				case VTAC_VERT_START:
				{
					vtac_load_vertical_start (&machine->vtac, data);
					break;
				}

				case VTAC_LAST_DATA:
				{
					vtac_load_last_data (&machine->vtac, data);
					break;
				}

				case VTAC_RESET:
				{
					vtac_reset (&machine->vtac);
					break;
				}

				case VTAC_UPSCROLL:
				{
					vtac_upscroll (&machine->vtac);
					break;
				}

				case VTAC_LOAD_C_COL:
				{
					vtac_load_cursor_column (&machine->vtac, data);
					break;
				}

				case VTAC_LOAD_C_ROW:
				{
					vtac_load_cursor_row (&machine->vtac, data);
					break;
				}

				case VTAC_START:
				{
					vtac_start_timing_chain (&machine->vtac);
					break;
				}

				case PRINTER_CONTROL:
				{
					if (data & (1<<D5))
						machine->printer_enable = true;
					else
						machine->printer_enable = false;
					break;
				}

				case ERROR_DISPLAY:
				{
					led_display = data;
				}
			}
			//printf ("Write I/O to %02X with %02X\n", addr & 0xFF, data);
		}
	}

	pins &= Z80_PIN_MASK;
	// CTC (highest priority INT)
	pins |= Z80_IEIO;
	//pins |= Z80CTC_CLKTRG0 | Z80CTC_CLKTRG1 | Z80CTC_CLKTRG3;
	if (machine->rtc_tick)
	{
		pins |= Z80CTC_CLKTRG2;
		machine->rtc_tick = false;
	}

	// A0 and A1 to CS pins
	if (pins & Z80_A0) pins |= Z80CTC_CS0;
	if (pins & Z80_A1) pins |= Z80CTC_CS1;

	if ((pins & Z80_IORQ) &&
		( ( (Z80_GET_ADDR(pins) & 0xFF) == CTC_CH0) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == CTC_CH1) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == CTC_CH2) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == CTC_CH3) ))
	{
		pins |= Z80CTC_CE;

		if (pins & Z80_WR)
		{
			printf ("CTC Write %02X to %02X\n", Z80_GET_DATA(pins), Z80_GET_ADDR(pins) & 0xFF);
		}
	}

	old = (pins & Z80_INT) ? true : false;
	pins = z80ctc_tick(&machine->ctc, pins);
	if (pins & Z80_IEIO) chain++;
	if (old != ((pins & Z80_INT) ? true : false))
		printf ("CTC asserted IRQ\n");

	// PIO A
	// Tie FDC IRQ to PIOA PA7

	pins &= Z80_PIN_MASK;
	if (machine->fdc_irq)
	{
		pins |= Z80PIO_PB7;
	}
	if (machine->fdc_drq)
	{
		pins |= Z80PIO_PB6;
	}
	// Tie Keyboard Strobe to data input write of PORTA
	if (machine->keyboard_strobe)
	{
		pins |= Z80PIO_ASTB;
	}

	if (pins & Z80_A0) pins |= Z80PIO_BASEL;
	if (pins & Z80_A1) pins |= Z80PIO_CDSEL;
	if ((pins & Z80_IORQ) &&
		( ( (Z80_GET_ADDR(pins) & 0xFF) == PIO_PORTA) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == PIO_PORTB) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == PIO_CMDA) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == PIO_CMDB) ))
	{
		pins |= Z80PIO_CE;
	}

	old = (pins & Z80_INT) ? true : false;
	pins = z80pio_tick (&machine->pioa, pins);
	if (pins & Z80_IEIO) chain++;
	if (old != ((pins & Z80_INT) ? true : false))
			printf ("PIOA asserted IRQ\n");

	// Connect output of PB1 to keyboard_strobe
	if (pins & Z80PIO_PB1)
		machine->keyboard_strobe = true;
	else
		machine->keyboard_strobe = false;

	// PRINTER
	pins &= Z80_PIN_MASK;

	// Tie Priter Enable to Printer PIO PB7
	if (machine->printer_enable)
		pins |= Z80PIO_PB7;
	else
		pins &= ~Z80PIO_PB7;

	if (pins & Z80_A0) pins |= Z80PIO_BASEL;
	if (pins & Z80_A1) pins |= Z80PIO_CDSEL;
	if ((pins & Z80_IORQ) &&
		( ( (Z80_GET_ADDR(pins) & 0xFF) == PRINTER_PORTA) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == PRINTER_PORTB) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == PRINTER_CMDA) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == PRINTER_CMDB) ))
	{
		pins |= Z80PIO_CE;
	}

	old = (pins & Z80_INT) ? true : false;
	pins = z80pio_tick (&machine->pio_printer, pins);
	if (pins & Z80_IEIO) chain++;
	if (old != ((pins & Z80_INT) ? true : false))
				printf ("Printer asserted IRQ\n");
	// FDC
	pins &= Z80_PIN_MASK;

	if (machine->fdc_tc)
		pins |= UPD765_TC;

	if ((pins & Z80_IORQ) != 0 &&
		( ( (Z80_GET_ADDR(pins) & 0xFF) == DISK_DATA) ||
		  ( (Z80_GET_ADDR(pins) & 0xFF) == DISK_STATUS) ))
	{
		pins |= UPD765_CS;
	}

	old = (pins & Z80_INT) ? true : false;
	pins = upd765_iorq(&machine->fdc, pins);
	if (old != ((pins & Z80_INT) ? true : false))
			printf ("FDC asserted IRQ\n");

	// Get FDC IRQ and DRQ
	machine->fdc_irq = (pins & UPD765_INT);
	machine->fdc_drq = (pins & UPD765_DRQ);

	fflush(stdout);
	return pins & Z80_PIN_MASK;
}

int emulate(uint16_t origin)
{
	SDL_Event event;
	SDL_Window *window;
	SDL_Renderer *renderer;
	SDL_Texture *texture;

	wangwriter_t machine = {0};
	uint64_t cpu_pins = 0;
	diskdrive_t disk = {0};

	disk.image_name = "First4k.bin";

	upd765_desc_t fdc_desc = {
		.seektrack_cb = fdc_seektrack,
		.seeksector_cb = fdc_seeksector,
		.read_cb = fdc_read,
		.trackinfo_cb = fdc_trackinfo,
		.driveinfo_cb = fdc_driveinfo,
		.user_data = &disk
	};

	if (SDL_Init(SDL_INIT_VIDEO|SDL_INIT_TIMER) != 0)
	{
		fprintf (stderr, "Unable to initialize SDL: %s", SDL_GetError());
	    return -1;
	}
	window = SDL_CreateWindow("WangWriter Emulator",SDL_WINDOWPOS_UNDEFINED,
		SDL_WINDOWPOS_UNDEFINED, HPIXELS, VPIXELS+STATUSBAR, 0);
	if (window == NULL)
	{
		fprintf (stderr, "Unable to create window\n");
		return -1;
	}
	renderer = SDL_CreateRenderer(window, -1, 0);
	if (renderer == NULL)
	{
		fprintf (stderr, "Unable to create renderer\n");
		return -1;
	}
	texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_ARGB8888,
		SDL_TEXTUREACCESS_STATIC, HPIXELS, VPIXELS+STATUSBAR);
	if (texture == NULL)
	{
		fprintf (stderr, "Unable to create texture\n");
		return -1;
	}

	z80_init(&machine.cpu);
	upd765_init (&machine.fdc, &fdc_desc);
	z80ctc_init (&machine.ctc);
	z80pio_init (&machine.pioa);
	z80pio_init (&machine.pio_printer);

	z80_prefetch (&machine.cpu, origin);	// WangWriter ROM begins at 0xC000

	machine.keyboard_strobe = false;
	while (1)
	{
		uint32_t entry_ticks = SDL_GetTicks();
		int sleep_us;
		for (int tick = 0; tick < (F_CPU / 60); tick++)
		{
			cpu_pins = cpu_tick (&machine, cpu_pins);
		}
		machine.rtc_tick = true;		// Tick the RTC


		/* Detect input events */
		SDL_PollEvent(&event);
		if (event.type == SDL_QUIT) break;
		if (event.type == SDL_KEYDOWN)
		{

			FILE *fp;
			fp = fopen("snapshot.bin", "wb");
			fwrite (ram, 1, 16384, fp);
			fclose (fp);
			printf ("Snapshot of RAM written\n");

			printf ("PC = %04X A = %02X B = %02X\n", machine.cpu.pc, machine.cpu.a, machine.cpu.b);
			fflush (stdout);
		}
		//if (event.type == SDL_KEYUP) keytab[event.key.keysym.scancode] = 0;

		update_framebuffer(framebuffer);
		SDL_UpdateTexture(texture, NULL, framebuffer, HPIXELS * sizeof(Uint32));
		SDL_RenderCopy(renderer, texture, NULL, NULL);
		SDL_RenderPresent(renderer);

		sleep_us = (16.7f - (SDL_GetTicks() - entry_ticks)) * 1000;
		if (sleep_us > 0) usleep(sleep_us);
	}

	if (disk.image)
		fclose (disk.image);

	SDL_DestroyTexture(texture);
	SDL_DestroyRenderer(renderer);
	SDL_DestroyWindow(window);
	SDL_Quit();

	return 0;
}

void update_framebuffer(uint32_t *fb)
{
	for (int r = 0; r < ROWS; r++)
	{
		for (int c = 0; c < COLUMNS; c++)
		{
			uint8_t ch = vram[r * 0x100 + c+ 0x2000];
			uint8_t attr = vram[r * 0x100 + c];
			uint32_t fore, back;

			back = 0;
			if (attr & (1<<D3))
				fore = 0x0099FF99;		// High intensity
			else
				fore = 0x0022AA22;		// Normal intensity

			if (attr & (1<<D2))
			{
				back = fore;
				fore = 0;
			}

			if (ch < 128)
			{
				for (int l = 0; l < 8; l++)
				{
					uint8_t d = charrom[ch * 8 + l];
					uint8_t sh = 0x80;
					for (int p = 0; p < 8; p++)
					{
						int pix = (r * HPIXELS * 16) + (l * HPIXELS * 2) + (c * 8) + p;
						if (d & sh)
						{
							fb[pix] = fore;
						}
						else
						{
							fb[pix] = back;
						}
						sh >>= 1;
					}
				}
			}
		}
	}

	for (int i = 0; i < 8; i++)
	{
		uint32_t *fbp = fb + HPIXELS*VPIXELS;
		int x = 0, y = 0;
		int p = led_display & (1<<i);

		switch (i)
		{
			case 0:		// A segment
			{
				x = 10;		// Width
				y = 2;		// Height
				fbp += (12 + HPIXELS * 12);	// Position
				break;
			}

			case 1:		// F segment
			{
				x = 2;
				y = 10;
				fbp += (10 + HPIXELS * 14);
				break;
			}

			case 2:		// E segment
			{
				x = 2;
				y = 10;
				fbp += (10 + HPIXELS * 26);
				break;
			}

			case 3:		// D segment
			{
				x = 10;
				y = 2;
				fbp += (12 + HPIXELS * 36);
				break;
			}

			case 4:		// C segment
			{
				x = 2;
				y = 10;
				fbp += (22 + HPIXELS * 26);
				break;
			}

			case 5:		// G segment
			{
				x = 10;
				y = 2;
				fbp += (12 + HPIXELS * 24);
				break;
			}

			case 6:		// B segment
			{
				x = 2;
				y = 10;
				fbp += (22 + HPIXELS * 14);
				break;
			}

		}

		for (int py = 0; py < y; py++)
		{
			for (int px = 0; px < x; px++)
			{
				if (p)
				{
					*(fbp++) = 0x00330000;		// BLACK
				}
				else
				{
					*(fbp++) = 0x00FF0000;		// RED
				}
			}
			fbp -= x;
			fbp += HPIXELS;
		}
	}
}

int fdc_seektrack (int drive, int track, void* user_data)
{
	if (drive > 1) return UPD765_RESULT_NOT_READY;

	diskdrive_t *disk = user_data;
	disk->track = track;
	return UPD765_RESULT_SUCCESS;
}


int fdc_seeksector (int drive, int side, upd765_sectorinfo_t* inout_info, void* user_data)
{
	diskdrive_t *disk = user_data;
	int cyl = disk->track * ((side) ? 2 : 1);
	//disk->track = (inout_info->c * 2) + side;
	disk->sector = inout_info->r;
	disk->sector_size = (128 << inout_info->n);
	disk->data_p = 0;

	if (drive > 1) return UPD765_RESULT_NOT_READY;

	if (disk->image == NULL)
	{
		disk->image = fopen (disk->image_name, "rb");
		if (disk->image == NULL)
		{
			return UPD765_RESULT_NOT_READY;
		}
	}

	fseek (disk->image, ((cyl * DISK_SECTORS) + (disk->sector - 1)) * DISK_BYTES, SEEK_SET);
	fread (disk->buffer, 1, disk->sector_size, disk->image);

	return UPD765_RESULT_SUCCESS;
}

int fdc_read (int drive, int side, void* user_data, uint8_t* out_data)
{
	diskdrive_t *disk = user_data;
	if (drive > 1) return UPD765_RESULT_NOT_READY;

	*out_data = disk->buffer[disk->data_p];
	disk->data_p++;

	if (disk->data_p >= disk->sector_size)
	{
		// Continue reading sectors
		disk->data_p = 0;
		fread (disk->buffer, 1, disk->sector_size, disk->image);
	}
	return UPD765_RESULT_SUCCESS;
}

int fdc_trackinfo (int drive, int side, void* user_data, upd765_sectorinfo_t* out_info)
{
	//diskdrive_t *disk = user_data;

	if (drive > 1) return UPD765_RESULT_NOT_READY;

	out_info->st1 = 0;
	out_info->st2 = 0x04;
	return UPD765_RESULT_SUCCESS;
}

void fdc_driveinfo (int drive, void* user_data, upd765_driveinfo_t* out_info)
{
	//diskdrive_t *disk = user_data;
	printf ("DRIVEINFO\n");

}
