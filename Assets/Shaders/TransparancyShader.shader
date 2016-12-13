Shader "Cg shader using blending" {

Properties{
	_Alpha ("Alpha value", Float) = 0.3
	_RGB ("RGB Values", Color) = (0, 1, 0, .3)
}

SubShader {
      Tags { "Queue" = "Transparent" } 
         // draw after all opaque geometry has been drawn
      Pass {
         ZWrite Off // don't write to depth buffer 
            // in order not to occlude other objects

//         Blend SrcAlpha OneMinusSrcAlpha // use alpha blending
	 Blend One OneMinusSrcAlpha


         CGPROGRAM 
 
         #pragma vertex vert 
         #pragma fragment frag

	 uniform float _Alpha;
	 uniform float4 _RGB;

         float4 vert(float4 vertexPos : POSITION) : SV_POSITION 
         {
            return mul(UNITY_MATRIX_MVP, vertexPos);
         }
 
         float4 frag(void) : COLOR 
         {
	 return float4(_RGB);
           // return float4(0.0, 1.0, 0.0, _Alpha); 
               // the fourth component (alpha) is important: 
               // this is semitransparent green
         }
 
         ENDCG  
      }
   }
}