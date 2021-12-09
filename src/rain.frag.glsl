in vec2 uvInterpolator;

vec2 Drops(vec2 uv) {
  vec2 uvRepeated = fract(uv * 10.0);
  return uvRepeated;
}

void main() {
  vec2 drops = Drops(uvInterpolator.xy);
  gl_FragColor = vec4(drops, 0, 1);
}