import './style.css';
import * as THREE from 'three';

const app = document.querySelector<HTMLDivElement>('#app')!;

const scene = new THREE.Scene();
const camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
const renderer = new THREE.WebGLRenderer();
renderer.setSize(window.innerWidth, window.innerHeight);
app.appendChild(renderer.domElement);

renderer.render(scene, camera);
