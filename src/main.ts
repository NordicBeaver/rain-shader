import './style.css';
import * as THREE from 'three';
import rainVertShader from './rain.vert.glsl?raw';
import rainFragShader from './rain.frag.glsl?raw';

const app = document.querySelector<HTMLDivElement>('#app')!;

const scene = new THREE.Scene();

const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
camera.position.z = 5;

const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
app.appendChild(renderer.domElement);

const cubeGeometry = new THREE.BoxGeometry();
const cubeMaterial = new THREE.ShaderMaterial({
  vertexShader: rainVertShader,
  fragmentShader: rainFragShader,
});
const cube = new THREE.Mesh(cubeGeometry, cubeMaterial);
scene.add(cube);

function animationFrame() {
  renderer.render(scene, camera);
  requestAnimationFrame(animationFrame);
}
requestAnimationFrame(animationFrame);
