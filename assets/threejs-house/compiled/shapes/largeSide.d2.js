"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.LargeSideD2 = void 0;
var materials_1 = require("../materials");
var wallWidth = 10;
var wallHeight = 2;
var wallDepth = 0.25;
var doorSettings1 = {
    width: 0.15,
    height: 0.5,
    depth: 1,
    offsetLeft: 0.3,
    offsetGround: 0,
    balcony: undefined,
};
var doorSettings2 = {
    width: 0.1,
    height: 0.5,
    depth: 1,
    offsetLeft: 0.8,
    offsetGround: 0,
    balcony: undefined,
};
exports.LargeSideD2 = {
    width: wallWidth,
    height: wallHeight,
    depth: wallDepth,
    material: materials_1.wallMaterial,
    doors: [doorSettings1, doorSettings2],
    windows: undefined,
    stairs: undefined,
    position: {
        x: 0,
        y: 0,
        z: 0
    }
};
//# sourceMappingURL=largeSide.d2.js.map