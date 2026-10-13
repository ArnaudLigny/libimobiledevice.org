#!/usr/bin/env node

// Copies the JavaScript files used by the layouts from node_modules to
// assets/vendor, as Cecil can only handle assets located in assets directory.

const fs = require('fs');
const path = require('path');

const root = path.resolve(__dirname, '..');
const files = [
	'jquery/dist/jquery.slim.min.js',
	'bootstrap/js/dist/util.js',
	'bootstrap/js/dist/alert.js',
	'bootstrap/js/dist/button.js',
	'bootstrap/js/dist/collapse.js',
	'bootstrap/js/dist/dropdown.js',
	'bootstrap/js/dist/tab.js',
	'popper.js/dist/umd/popper.min.js',
	'smoothscroll-polyfill/dist/smoothscroll.min.js',
	'waypoints/lib/jquery.waypoints.min.js',
	'waypoints/lib/shortcuts/inview.min.js',
];

for (const file of files) {
	const target = path.join(root, 'assets', 'vendor', file);
	fs.mkdirSync(path.dirname(target), { recursive: true });
	fs.copyFileSync(path.join(root, 'node_modules', file), target);
}
