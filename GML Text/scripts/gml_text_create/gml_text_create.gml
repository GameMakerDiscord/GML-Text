/// @desc Create the text and parse it for later use
/// @func gml_text_create()
/// @arg name,string

ds_map_add(global.Gml_Text_Map,argument0,ds_map_create());

// Initialize a local variable to improve reference time
var _map = global.Gml_Text_Map[? argument0];

// Required data structure values
ds_map_add(_map,Gml_Text.String,argument1);
ds_map_add_list(_map,Gml_Text.Instructions,ds_list_create());

// Parse the string and store it in memory
gml_text_parse(_map,argument1);

return _map;