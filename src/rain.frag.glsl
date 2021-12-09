in vec2 uvInterpolator;
uniform float u_time;

float Random11(float inputValue, float seed) {
  return fract(sin(inputValue * 345.456) * seed);
}

float Random21(vec2 inputValue, float seed) {
  return fract(sin(dot(inputValue, vec2(123.456, 43.12))) * seed);
}

vec2 Random22(vec2 inputValue) {
  return vec2(Random21(inputValue, 34245.43), Random21(inputValue, 76453.435));
}

vec2 Drops(vec2 uv, float seed) {
  float shiftY = Random11(0.5, seed);
  uv.y += shiftY;

  float cellsResolution = 10.0;
  uv *= cellsResolution;

  float rowIndex = floor(uv.y);
  float shiftX = Random11(rowIndex, seed);
  uv.x += shiftX;

  vec2 cellIndex = floor(uv);
  vec2 cellUv = fract(uv);

  vec2 cellCenter = vec2(0.5);
  float distanceFromCenter = distance(cellUv, cellCenter);

  float isDropShown = step(0.8, Random21(cellIndex, seed + 14244.324));
  float dropIntensity = 1.0 - fract(u_time * 0.2 + Random21(cellIndex, seed + 32132.432) * 2.0) * 2.0;

  float drop = clamp(smoothstep(0.2, 0.0, distanceFromCenter) * isDropShown * dropIntensity, 0.0, 1.0);
  return vec2(drop);
}

void main() {
  vec2 drops1 = Drops(uvInterpolator.xy, 432424.43);
  vec2 drops2 = Drops(uvInterpolator.xy, 23213.465);
  vec2 drops3 = Drops(uvInterpolator.xy, 74654.432);
  vec2 drops = drops1 + drops2 + drops3;
  gl_FragColor = vec4(drops, 0.0, 1.0);
}