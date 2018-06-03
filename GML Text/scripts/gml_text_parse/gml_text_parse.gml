/// @desc Parses a string and stores the data within the texts data structure
/// @func gml_text_parse()
/// @arg map,string

var
_map = argument0,
_str = argument1,
_instruction_list = _map[? Gml_Text.Instructions],
_char = "",
_char_add = false,
_start_pos = string_pos("<",_str),
_end_pos = string_pos(">",_str),
_str_parse = "",
_str_length = string_length(_str),
_parse_pos_value = 0,
_parse_length_value = 0,
_tag = "";

for ( var i = 1; i < _str_length; ++ i; ) {
	_char = string_char_at(_str,i);
	if ( _char != "<" && _char != ">" && _char != "/" ) {
		// This is non-meta data text
		if ( _instruction_list[| ds_list_size(_instruction_list) - 1] != "<text>" ) {
			// Insert our text draw instruction
			ds_list_add(_instruction_list,"<text>");
			
			var _str_build = "";
			
			while ( _char != "<" && _char != ">" && _char != "/" && i < _str_length ) {
				_str_build = _str_build + _char;

				++ i;
				
				_char = string_char_at(_str,i);
			}
			
			-- i;
			ds_list_add(_instruction_list,_str_build);
			ds_list_add(_instruction_list,string_width(_str_build));
		}
		
	} else {
		
		if ( _char == "/" && string_char_at(_str,i + 1) == "n" ) {
			
			ds_list_add(_instruction_list,"<newline>");
			++ i;
			
		} else {
		
			// It's parsing time!
			_end_pos = string_pos(">",_str);
			_start_pos = string_pos("<",_str);
			_str_parse = string_copy(_str,_start_pos + 1,_end_pos - _start_pos - 1);
			_str = string_delete(_str,_start_pos,_end_pos - _start_pos + 1);
		
			_parse_pos_value = string_pos("=",_str_parse);
			_parse_length_value = string_length(_str_parse);
		
			_str_length -= _parse_length_value;
			-- i;
			
			_tag = string_delete(_str_parse,_parse_pos_value,_parse_length_value);
		
			switch ( _tag ) {
				
				// Use this to get the value after the = sign
				// string_copy(_str_parse,_parse_pos_value + 1,_parse_length_value - 5)
				
				case "font":
					ds_list_add(_instruction_list,"<font>");
					ds_list_add(_instruction_list,asset_get_index(string_copy(_str_parse,_parse_pos_value + 1,_parse_length_value - 5)));
					draw_set_font(_instruction_list[| ds_list_size(_instruction_list) - 1]);
				break;
				
				case "color":
					ds_list_add(_instruction_list,"<color>");
					ds_list_add(_instruction_list,global.Gml_Text_Colors[? string_copy(_str_parse,_parse_pos_value + 1,_parse_length_value - 5)]);
				break;
				
				case "offset_y":
					ds_list_add(_instruction_list,"<offset_y>");
					ds_list_add(_instruction_list,real(string_copy(_str_parse,_parse_pos_value + 1,_parse_length_value - 5)));
				break;
				
				case "sprite":
					ds_list_add(_instruction_list,"<sprite>");
					ds_list_add(_instruction_list,asset_get_index(string_copy(_str_parse,_parse_pos_value + 1,_parse_length_value - 5)));
					ds_list_add(_instruction_list,sprite_get_width(_instruction_list[| ds_list_size(_instruction_list) - 1]));
				break;
				
				case "newline":
					ds_list_add(_instruction_list,"<newline>");
				break;
				
				case "shake":
					ds_list_add(_instruction_list,"<shake>");
					ds_list_add(_instruction_list,real(string_copy(_str_parse,_parse_pos_value + 1,_parse_length_value - 5)));
				break;
			}
			
		}
	}
}