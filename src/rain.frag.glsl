in vec2 uvInterpolator;
uniform float u_time;
uniform sampler2D u_texture;

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
  dropIntensity = clamp(dropIntensity, 0.0, 1.0);
  float isInsideDrop = 1.0 - step(0.1, distanceFromCenter);

  vec2 vecToCenter = normalize(cellUv - cellCenter);
  vec2 dropValue = vecToCenter * distanceFromCenter * distanceFromCenter;

  vec2 drop = dropValue * isInsideDrop * isDropShown * dropIntensity;
  return drop;
}

void main() {
  vec2 uv = uvInterpolator;
  vec2 drops = vec2(0.0);
  for(int i = 0; i < 10; i++) {
    drops += Drops(uv, 42424.43 + float(i) * 12313.432);
  }

  uv -= drops * 100.0;

  vec4 color = texture2D(u_texture, uv);

  gl_FragColor = color;
}