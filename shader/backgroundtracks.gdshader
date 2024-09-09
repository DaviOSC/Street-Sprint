shader_type canvas_item;

uniform float speed;

void vertex() {
    UV.y -= TIME * speed;
}
