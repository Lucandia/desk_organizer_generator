# Desk Organizer Generator
Generate a 3D model for a custom Desk Organizer from simple building blocks. Visit the instructions on the [Printables page](https://www.printables.com/it/model/498850-desk-organizer-generator)!

## Try the web app:

[3d_pattern](https://lmonari5-3d-pattern.streamlit.app/) powered by streamlit

[![Streamlit App](https://static.streamlit.io/badges/streamlit_badge_black_white.svg)](https://lmonari5-3d-pattern.streamlit.app/)

The program is designed to run in Streamlit, but follow the below instructions to use the libraries directly in Openscad.

### Generate your organizer:

The program uses two Openscad libraries: `honeycomb.scad` from [Gael Lafond](https://www.printables.com/it/@GaelLafond) and `desk_organizer.scad`

Include them in the Openscad script and add a normal block with:
```
rbox(SIZE_INT, SIZE_EXT, HEIGHT, r=R, rp=true, base=BASE_THICK);
```
where:
- SIZE_INT is the internal dimension array ([x,y])
- SIZE_EXT is the internal dimension array ([x,y], usually is calculated as SIZE_INT + [X_WALL\*2, Y_WALL\*2])
- HEIGHT is the height of the block
- R is the radius of the curvature of the square perimeter corners (default: 7)
- rp is a boolean value: it false the program interprets R as a value in mm, if true consider R as the percentage over the length of the square side (default: true)
- BASE_THICK is the thickness of the base (default: 2)

Add a honeycomb block with:
```
hbox(SIZE_INT, SIZE_EXT, HEIGHT, r=R, rp=true, base=BASE_THICK, h_dia=H_DIA, h_thick=H_THICK) ;
```
where:
- SIZE_INT is the internal dimension array ([x,y])
- SIZE_EXT is the internal dimension array ([x,y], usually is calculated as SIZE_INT + [X_WALL\*2, Y_WALL\*2])
- HEIGHT is the height of the block
- R is the radius of the curvature of the square perimeter corners (default: 7)
- rp is a boolean value: it false the program interprets R as a value in mm, if true consider R as the percentage over the length of the square side (default: true)
- BASE_THICK is the thickness of the base (default: 2)
- H_DIA is the honeycomb diameter (default: 4)
- H_THICK is the honeycomb line thickness (default: 1)
 
## Support

I enjoy working on this project in my free time, if you want to support me with a coffee just [click here!](https://www.paypal.com/donate/?hosted_button_id=V4LJ3Z3B3KXRY)

## License

Code and Models are licensed under the Creative Commons Non-Commercial Share Alike License 4.0 ([CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/))

[![License: CC BY-NC-SA 4.0](https://img.shields.io/badge/License-CC%20BY--NC--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Thanks

Thanks to Gael Lafond for sharing the OpenSCAD Honeycomb library [on Printables](https://www.printables.com/it/model/263718-honeycomb-library-openscad)! 
