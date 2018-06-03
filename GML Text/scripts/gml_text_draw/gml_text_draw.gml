/// @desc Draw parsed text
/// @func gml_text_draw()
/// @arg x,y,map

/* Used for benchmarking this script
var _t = get_timer();
*/

var
_instruction_list = argument2[? Gml_Text.Instructions],
_size = ds_list_size(_instruction_list),
_x_off = argument0,
_y_off = argument1,
_x_adjust = 0,
_y_adjust = 0,
_mode = -1,
_value = 0;

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

for ( var i = 0; i < _size; ++ i; ) {
	
	switch ( _instruction_list[| i] ) {
		case "<text>":
			if ( _mode == -1 ) {
				_mode = 0;
			}
			
			++ i;
			switch ( _mode ) {
		
				case 0:
				draw_text(_x_off + _x_adjust,_y_off + _y_adjust,_instruction_list[| i]);
				++ i;
				_x_off += _instruction_list[| i];
				_mode = -1;
				break;
		
				case 1:
				draw_text(_x_off + _x_adjust + irandom_range(-_value,_value),_y_off + _y_adjust + irandom_range(-_value,_value),_instruction_list[| i]);
				++ i;
				_x_off += _instruction_list[| i];
				_mode = -1;
				break;
		
			}
		break;
		
		case "<color>":
			draw_set_color(_instruction_list[| i+1]);
			++ i;
		break;
		
		case "<font>":
			draw_set_font(_instruction_list[| i+1]);
			++ i;
		break;
		
		case "<newline>":
			_x_off = argument0;
			_y_off += string_height("M");
		break;
		
		case "<offset_y>":
			++ i;
			_y_adjust = _instruction_list[| i];
		break;
		
		case "<sprite>":
			++ i;
			draw_sprite(_instruction_list[| i],0,_x_off + _x_adjust,_y_off + _y_adjust);
			++ i;
			_x_off += _instruction_list[| i];
		break;
		
		case "<shake>":
			++ i;
			_mode = 1;
			_value = _instruction_list[| i];
			if ( _value == 0 ) {
				_mode = -1;
			}
		break;
	}
	
}

/* Used for benchmarking this script
show_debug_message(get_timer() - _t);
*/