
// Ignora se estiver animando
if (anim_state != "idle") exit;

// Ignora clicks fora da pizza
var _dist = point_distance(x, y, mouse_x, mouse_y);
var _plate_radius = (sprite_get_width(spr_plate) * image_xscale) / 2;
if (_dist > _plate_radius) exit;

// Encontra a direção do clique com relação ao centro da pizza
var _ang = point_direction(x, y, mouse_x, mouse_y);
var _slices = obj_pizza.slices;
var _slice_size = obj_pizza.slice_size;

// Pega o indice do pedaço
var _slice_index = floor(_ang / _slice_size);

// Esconde o pedaço
if (!_slices[_slice_index].visible){
	_slices[_slice_index].visible = true;
	_slices[_slice_index].animated = true
	
	var inst = instance_create_layer (x, y, "Animations", obj_pizza_slice, {slice_index : _slice_index});
}