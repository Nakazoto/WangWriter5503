/*
 * VTAC.c
 */

#include "VTAC.h"

void vtac_load_horiz_line_count (vtac_t *vtac, uint8_t d)
{
	vtac->horiz_line_count = d;
}

void vtac_load_sync_width (vtac_t *vtac, uint8_t d)
{
	vtac->sync_width = d;
}

void vtac_load_scans_row (vtac_t *vtac, uint8_t d)
{
	vtac->scan_rows = d;
}

void vtac_load_rows_frame (vtac_t *vtac, uint8_t d)
{
	vtac->rows_frame = d;
}

void vtac_load_scan_lines (vtac_t *vtac, uint8_t d)
{
	vtac->lines_frame = d;
}

void vtac_load_vertical_start (vtac_t *vtac, uint8_t d)
{
	vtac->vertical_start = d;
}

void vtac_load_last_data (vtac_t *vtac, uint8_t d)
{
	vtac->last_data = d;
}

uint8_t vtac_read_cursor_row (vtac_t *vtac)
{
	return vtac->cursor_row;
}

uint8_t vtac_read_cursor_column (vtac_t *vtac)
{
	return vtac->cursor_column;
}

void vtac_reset (vtac_t *vtac)
{
	memset (vtac, 0, sizeof(vtac_t));
}

void vtac_upscroll (vtac_t *vtac)
{
	// TODO: Implement
}

void vtac_load_cursor_column (vtac_t *vtac, uint8_t d)
{
	vtac->cursor_column = d;
}

void vtac_load_cursor_row (vtac_t *vtac, uint8_t d)
{
	vtac->cursor_row = d;
}

void vtac_start_timing_chain (vtac_t *vtac)
{
	// TODO: Implement
}

