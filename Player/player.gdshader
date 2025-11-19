shader_type canvas_item;

uniform vec4 in_color;


void fragment() {
	//COLOR = vec4(1.0 - COLOR.r, 1.0 - COLOR.g, 1.0 - COLOR.b, 1.0);
	//COLOR = vec4(1.0 - COLOR.rgb, 1.0); круто смотриться и это правельная версия выше
	//COLOR = COLOR.gggg; инвиз
	//COLOR = mix(COLOR, in_color, 0.9); для передачи из скрипта игрока
	//if(COLOR.a > 0.0){
		//COLOR = vec4(sin(TIME), cos(TIME), 0.5, 1.0);
	//}
	
	
	
}

