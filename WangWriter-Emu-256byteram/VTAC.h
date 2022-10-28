/*
 * VTAC.h
 */

#ifndef VTAC_H_
#define VTAC_H_

#include <stdint.h>
#include <string.h>

typedef struct vtac
{
	uint8_t horiz_line_count;
	uint8_t sync_width;
	uint8_t scan_rows;
	uint8_t rows_frame;
	uint8_t lines_frame;
	uint8_t vertical_start;
	uint8_t last_data;
	uint8_t cursor_column;
	uint8_t cursor_row;
} vtac_t;

void vtac_load_horiz_line_count (vtac_t *vtac, uint8_t d);
void vtac_load_sync_width (vtac_t *vtac, uint8_t d);
void vtac_load_scans_row (vtac_t *vtac, uint8_t d);
void vtac_load_rows_frame (vtac_t *vtac, uint8_t d);
void vtac_load_scan_lines (vtac_t *vtac, uint8_t d);
void vtac_load_vertical_start (vtac_t *vtac, uint8_t d);
void vtac_load_last_data (vtac_t *vtac, uint8_t d);
uint8_t vtac_read_cursor_row (vtac_t *vtac);
uint8_t vtac_read_cursor_column (vtac_t *vtac);
void vtac_reset (vtac_t *vtac);
void vtac_upscroll (vtac_t *vtac);
void vtac_load_cursor_column (vtac_t *vtac, uint8_t d);
void vtac_load_cursor_row (vtac_t *vtac, uint8_t d);
void vtac_start_timing_chain (vtac_t *vtac);


#endif /* VTAC_H_ */
