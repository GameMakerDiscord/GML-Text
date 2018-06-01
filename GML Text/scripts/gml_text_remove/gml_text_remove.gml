/// @desc Remove parsed text from memory
/// @func gml_text_remove()
/// @arg name

var _map = gml_text_find(argument0);

ds_map_delete(global.Gml_Text_Map,argument0);
ds_list_destroy(_map[? Gml_Text.Instructions]);
ds_map_destroy(_map);