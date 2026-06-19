// Centro da pizza/prato
var cx = x;
var cy = y;

// Desenha o prato primeiro (aplicando a escala da instância para manter fidelidade de tamanho)
draw_sprite_ext(spr_plate, 0, cx, cy, image_xscale, image_yscale, 0, c_white, 1);

if (!instance_exists(obj_pizza)) exit;

var _slices = obj_pizza.slices;
var _num_slices = array_length(_slices);
var _slice_size = obj_pizza.slice_size;

for (var i = 0; i < _num_slices; i++)
{
	// Se o pedaço estiver visível na pizza principal ou estiver sendo animado, não desenha ele no prato
    if (_slices[i].visible || !_slices[i].onplate) continue;

	// Pega os ângulos de início e fim do pedaço
    var ang1 = i * _slice_size;
    var ang2 = (i + 1) * _slice_size;
	
    shader_set(sh_slice);

	// Envia para o shader os ângulos inicial e final do pedaço, junto com as coordenadas do centro da pizza
    shader_set_uniform_f(u_angle_start, ang1);
    shader_set_uniform_f(u_angle_end, ang2);
    shader_set_uniform_f(u_center_x, cx);
    shader_set_uniform_f(u_center_y, cy);
	
    draw_sprite(sprite_index, image_index, cx, cy);

    shader_reset();
}

draw_set_color(c_red);

var radius = sprite_width * 0.5;

for (var i = 0; i < _num_slices; i++)
{
	var _prev_i = (i + _num_slices - 1) mod _num_slices;
	
	if (!_slices[i].onplate && !_slices[_prev_i].onplate) continue;
	if (_slices[i].visible && _slices[_prev_i].visible) continue;
	
    var ang = i * _slice_size;

    var x2 = cx + lengthdir_x(radius, ang);
    var y2 = cy + lengthdir_y(radius, ang);
	
	// Desenha os cortes na pizza
    draw_line(cx, cy, x2, y2);
}