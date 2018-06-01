gml_text_ini();

// Colors
gml_text_color_add("white",$ffffff);
gml_text_color_add("red",$0000ff);
gml_text_color_add("blue",$ff8500);
gml_text_color_add("orange",$007cff);
gml_text_color_add("green",$00ff10);
gml_text_color_add("pink",$7300ff);
gml_text_color_add("purple",$ff00ee);
gml_text_color_add("yellow",$00ffff);

var _str = "<font=font_main>I like the <font=font_main_alt><color=pink><offset_y=12><shake=1>w<shake=1>e<shake=1>a<shake=1>t<shake=1>h<shake=1>e<shake=1>r<shake=0><font=font_main><offset_y=0><color=white>.<newline>It is <font=font_other><color=yellow><offset_y=-12><shake=1>sunny<shake=0><font=font_main><color=white><offset_y=0> today and it makes my skin burn.<newline><font=font_special><offset_y=-10>I'm not a vampire<font=font_main><offset_y=6>, I don't think.<newline>";
_str = _str + "Look at these <sprite=spr_test> (swords)!";

gml_text_create("test",_str);