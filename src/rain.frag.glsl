in vec2 uvInterpolator;

vec2 Drops(vec2 uv) {
  float cellsResolution = 10.0;
  vec2 uvRepeated = uv * cellsResolution;
  vec2 cellIndex = floor(uvRepeated);
  return cellIndex / cellsResolution;
}

void main() {
  vec2 drops = Drops(uvInterpolator.xy);
  gl_FragColor = vec4(drops, 0, 1);
}