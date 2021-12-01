in vec2 uvInterpolator;

void main() {
  gl_FragColor = vec4(uvInterpolator.xy, 0, 1);
}