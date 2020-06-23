/*
 Imagen creada por Harold Aguilar Mejia
 Imagen de una pelota de tenis iluminada por una lámpara
 usando una textura para representar la pelota, 
 en conjunto con el archivo funcion_pelota.ini se le da animación 
 de rebote. 
*/

#include "colors.inc"
#include "textures.inc"
#include "finish.inc"   
#include "transforms.inc"

///-----------------------------------------------------------------------------------------------///
//-----CÓDIGO SACADO DE LA PÁGINA-- http://www.f-lohmueller.de/pov_tut/backgrnd/pov/p_sky05.txt --//

camera {
    angle 70
    right    x*image_width/image_height
    location <0, 5, -10>
    look_at <0, 1.5, 0>
}

light_source { <3000, 5000, -3500>  rgb<1,1,1> }
   // sun height over the clouds produces cloud shadows

// ***************************************************************
// a brighter version of Darin Dugger's T_Clouds from "skies.inc"
// modified by Friedrich A. Lohmueller for using with "fog": 
// ***************************************************************
#declare T_Cloud2_Lo =
texture {
    pigment { bozo
        turbulence 1.5
        octaves 10
        omega 0.5
        lambda 2.5
        color_map { [0.0 color rgbf<0.85, 0.85, 0.85, 0.00>*1.0 ]
                    [0.5 color rgbf<0.95, 0.95, 0.95, 0.90>*1.12  ]
                    [0.7 color rgbf<1, 1, 1, 1> ]
                    [1.0 color rgbf<1, 1, 1, 1> ] }
    }
        #if (version = 3.7 )  finish {emission 0.95 diffuse 0}
        #else                 finish { ambient 0.95 diffuse 0}
        #end 
}
//--------------------------- 
#declare T_Cloud3_Lo =
texture {
    pigment { bozo
        turbulence 0.8 //0.6
        octaves 10
        omega 0.5
        lambda 2.5
        color_map { [0.0 color rgbf<0.95, 0.95, 0.95, 0.00>*1.2]
                    [0.4 color rgbf<0.90, 0.90, 0.90, 0.90>*1]
                    [0.7 color rgbf<1, 1, 1, 1> ]
                    [1.0 color rgbf<1, 1, 1, 1> ] }
           }
        #if (version = 3.7 )  finish {emission 1 diffuse 0}
        #else                 finish { ambient 1 diffuse 0}
        #end 
}
texture {
    pigment { bozo
        turbulence 0.8 //0.6
        octaves 10
        omega 0.5
        lambda 2.5
        color_map { [0.00 color rgbf<.85, .85, .85, 0.5>*1.5]
                    [0.35 color rgbf<.95, .95, .95, .95>*1.1]
                    [0.50 color rgbf<1, 1, 1, 1> ]
                    [1.00 color rgbf<1, 1, 1, 1> ] }        
        }
        finish {emission 1 diffuse 0}
scale 0.9
translate y*-0.15
}


// Darin Dugger's DD_Cloud_Sky texture mapped onto a pair of planes
//  first cloud level  500
// second cloud level 3000 

// "hollow" added by Friedrich A.Lohmueller,2000
// for using together with fog!


#declare O_Cloud2_Lo =
union {
 plane { <0,1,0>, 500 hollow //!!!!
        texture { T_Cloud3_Lo  scale 500}}
    
 plane { <0,1,0>, 3000 hollow  //!!!!
        texture {T_Cloud2_Lo scale <900,1,3000> 
                 translate <3000,0,0> rotate <0,-30,0>}}

 plane { <0,1,0> , 10000  hollow
        texture{ pigment {color SkyBlue*0.20}
                 finish {ambient 1 diffuse 0}}}
scale<1.5,1,1.25>
}//--------------------------------------------------



object{O_Cloud2_Lo rotate<0,0,0> translate<0,0,0>}


//---------------------------------------------------
 
// fog at the horizon
fog{fog_type   2
    distance   100
    color      rgb<1,1,1>*0.75
    fog_offset 0.1
    fog_alt    5
    turbulence 0.8}
 
//----------------------------------------------------


// ground
plane { <0,1,0>, 0 
        texture{ pigment{color rgb<0.35,0.65,0.0>*0.7}
	         normal {bumps 0.75 scale 0.015}
               } // end of texture
      } // end of plane
//----------------------------------------------------

//----TERMINA EL CÓDIGO DE LA PÁGINA -- http://www.f-lohmueller.de/pov_tut/backgrnd/pov/p_sky05.txt --//
///-----------------------------------------------------------------------------------------------------//
///-----------------------------------------------------------------------------------------------------//
///-----------------------------------------------------------------------------------------------------//
///--------------------------------CÓDIGO DE HAROLD AGUILAR---------------------------------------------//

// Macro: -------------------------
#macro  Rebote( X )
 #if(X<1/2) (sin(pi*( X + 1/2)))
 #else      (sin(pi*(1-X + 1/2)))
 #end
#end

// En una primera parte se coloca clock + 0 y en una segunda se coloca clock + 1
#declare Time = clock +1.00  ;

// Esfera: ------------------------
sphere{ <1,0.8,0>, 0.7
  texture{
     pigment{
        image_map{
            jpeg "pt.jpeg"
        }
     }
     scale <-1.5,3.5,1>
  }
  translate <1+3*Time, Rebote(Time)*(1-0.15)+0.15,0> 
  finish{
    diffuse 2
    ambient 0.3
  }
} 

// Texto: ------------------------
text { ttf "arial.ttf", "HAM_ICO", 0.1 , 0
    material{
        texture{ 
            pigment{ 
                color rgbt<0,0,0.8,0.5>
            }
            normal{ 
                bumps 0.5 scale 0.025 
            }
            finish{ 
                phong 1.0
            }
        }
        interior{ 
            ior 1.5
            caustics 0.25
        }
    }
    scale<1,1.8,1>*0.75
    translate<-4 ,0.50, -0.0 >
    rotate<0,-360*(clock+0.00),0>
}
                                         

