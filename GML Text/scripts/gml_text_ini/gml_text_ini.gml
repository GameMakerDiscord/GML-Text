/// @desc Initialize the GML text engine
/// @func gml_text_ini()

global.Gml_Text_Map = ds_map_create();
global.Gml_Text_Colors = ds_map_create();

enum Gml_Text {
	String,
	Instructions
}