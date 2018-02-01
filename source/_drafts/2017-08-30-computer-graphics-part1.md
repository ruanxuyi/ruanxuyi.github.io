title: "computer-graphics-part1"
date: 2017-08-30 12:47:23
tags:
- Computer Graphics
---


# Definition
**Render**: rendering converts 3D scene descriptions(data in disk/memory) to a 2D photo(single frame)  
**Modeling**: develop mathematical representation of surface of any object with specialized software  
**Animation**: making things move  
**Triangle Meshes**: unit of shape for which rendering happen for computer graphic, which ususally improve efficientcy  
**Full global illumination:** able to render the shadow/color through reflection/refraction by mirror/glass objects  

![](http://7xihzu.com1.z0.glb.clouddn.com/20170830/global-illumination.png)

**Object order alorithm**: iterate over the elements in the scene to be rendered  
**Image order algorithm**: iterate over the pixels in the image to be produced  
**[Homogeneous Coordinates](http://www.tomdalling.com/blog/modern-opengl/explaining-homogenous-coordinates-and-projective-geometry/):**  
- coordinate: $(x,y,z,w)$  
- $w$ is the distance from camera to screen  
- add $w$ so that we can do [figure translation](https://en.wikipedia.org/wiki/Translation_(geometry)) (require $ 4 \times 4 $ metrics for 3D)  
- [Affine Transformation](https://www.mathworks.com/discovery/affine-transformation.html) includes: Translation, Scale, Rotation, etc...  
- when $w<1$, projector/camera move **closer** to screen , 2d image becomes **smaller**  
- when $w=1$ same size, has no effect on $x, y, z$ values  
- If $W=1$, then it is a point light  
- If $W=0$, then it is a directional light (point lights that are **infinitely** far)  
**[Change of basis matrix](https://www.youtube.com/watch?v=1j5WnqwMdCk)**: change from one coordinate to another by multipling change of basis matrix  
**Euclidean plane**: 2d space  ($R^2$)




# Realistic rendering
Rendering converts 3D scene descriptions (data in disk/memory) to a 2D photo(single frame) to display on screen.   

## Introduction to rendering
Two different strategies for image generation (rendering):     
1. Z-buffering, Restrazation (faster, but less details)  
2. Ray Tracing (slower, but more realistic)

### Z-buffering (Rasterization)  
- implemented in GPU  
- standard APIs (OpenGL, Direct3D)  
- **limited** photo-realism  
- faster -> uitable for real time rendering  
- full **global** illumination not possible with purelyobject order algorithm

### Ray Tracing
- slower, but more photo-realism  
- requires sophisticated data structures for fast scene access
- able to compute in parallel  
- full **global** illumination possible  

**Two methods to trace ray:**  
1. trace from light source to camera  
2. trace from camera to light source  

Method 1 is not pratical becuase **majority** of the rays reflect by objects are **NOT** captured by camera. 

#### Algorithm (pseudocode)

```rayTrace() {  construct scene representation  for each pixel    ray = computePrimary( pixel )    hit = first intersection with scene    color = shade( hit ) // if an object exist between [hit point] & [light source], it represents shadow    set pixel color}
```
![picture1](https://upload.wikimedia.org/wikipedia/commons/8/83/Ray_trace_diagram.svg)


# Real-time rendering, VR# Modeling, 3D geometry acquisition and processing


# Reference:

[Ray Tracing image](https://en.wikipedia.org/wiki/Ray_tracing_(graphics))  
