out vec2 uvInterpolator;

void main() {
  uvInterpolator = uv;
  gl_Position = projectionMatrix * modelViewMatrix * vec4(position, 1.0);
}