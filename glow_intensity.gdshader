shader_type canvas_item;

//uniform vec4 glow_color : source_color = vec4(0.4, 1.0, 0.89, 1.0); // Ваш цвет R0.4 G1 B0.89 A1
//uniform float glow_intensity : hint_range(0.0, 5.0) = 2.0;
//uniform float glow_threshold : hint_range(0.0, 1.0) = 0.3; // Более низкий порог для вашего цвета
//uniform float color_tolerance : hint_range(0.0, 1.0) = 0.2; // Допуск для сравнения цветов
//
//void fragment() {
    //vec4 original_color = texture(TEXTURE, UV);
    //
    //// Определяем, является ли пиксель целевым цветом для подсветки
    //float target_color = 0.0;
    //
    //// Сравниваем с вашим целевым цветом с допуском
    //vec3 target_rgb = vec3(0.4, 1.0, 0.89); // Ваш цвет
    //
    //// Вычисляем разницу между текущим цветом и целевым
    //float color_diff = distance(original_color.rgb, target_rgb);
    //
    //// Если цвет близок к целевому - подсвечиваем
    //if (color_diff < color_tolerance) {
        //target_color = 1.0 - (color_diff / color_tolerance); // Плавный переход
    //}
    //
    //// Смешиваем оригинальный цвет с подсветкой
    //vec3 glow = glow_color.rgb * glow_intensity * target_color;
    //COLOR = vec4(original_color.rgb + glow, original_color.a);
//}
