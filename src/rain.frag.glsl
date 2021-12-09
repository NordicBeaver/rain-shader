in vec2 uvInterpolator;

float Random11(float inputValue, float seed) {
  return fract(sin(inputValue * 345.456) * seed);
}

float Random21(vec2 inputValue, float seed) {
  return fract(sin(dot(inputValue, vec2(123.456, 43.12))) * seed);
}

vec2 Random22(vec2 inputValue) {
  return vec2(Random21(inputValue, 34245.43), Random21(inputValue, 76453.435));
}

vec2 Drops(vec2 uv) {
  float cellsResolution = 10.0;
  vec2 uvRepeated = uv * cellsResolution;
  vec2 cellIndex = floor(uvRepeated);
  vec2 shift = vec2(Random11(cellIndex.y, 89432.234), 0.0);
  vec2 cellUv = fract(uvRepeated + shift);
  return cellUv;
}

void main() {
  vec2 drops = Drops(uvInterpolator.xy);
  gl_FragColor = vec4(drops, 0.0, 1.0);
}