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

vec3 BaseColor(vec2 uv) {
  uv *= 30.0;
  uv = fract(uv);
  float horizontalLines = step(0.9, uv.y);
  float verticalLines = step(0.9, uv.x);
  float intensity = clamp(horizontalLines + verticalLines, 0.0, 1.0);
  return vec3(intensity);
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
  dropIntensity = clamp(dropIntensity, 0.0, 1.0);
  float isInsideDrop = 1.0 - step(0.1, distanceFromCenter);

  vec2 dropValue = normalize(cellUv - cellCenter) * distanceFromCenter * distanceFromCenter;

  vec2 drop = dropValue * isInsideDrop * isDropShown * dropIntensity;
  return drop;
}

void main() {
  vec2 uv = uvInterpolator;
  vec2 drops1 = Drops(uv, 432424.43);
  vec2 drops2 = Drops(uv, 23213.465);
  vec2 drops3 = Drops(uv, 74654.432);
  vec2 drops = drops1 + drops2 + drops3;

  uv -= drops * 10.0;
  uv = fract(uv * 10.0);

  vec3 base = BaseColor(uv);
  // gl_FragColor = vec4(base, 1.0);
  gl_FragColor = vec4(uv, 0.0, 1.0);
}