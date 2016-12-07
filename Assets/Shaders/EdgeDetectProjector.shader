Shader "EdgeDetectProjector" {
  Properties {
    _Color ("MainColor", Color) = (1,1,1,1)
      _MainTex ("MainTex", 2D) = "white" {}
    _DeltaX ("DeltaX", Float) = 0.01
      _DeltaY("DeltaY", Float) = 0.01
      _LowerCutoff ("LowerCutoff", Range(0,1)) = 0.0
      _UpperCutoff ("UpperCutoff", Range(0,1)) = 1.0
      }

  Subshader {
    Tags {"Queue"="Transparent"}
    Pass {

      Blend One Zero

	CGPROGRAM

#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

	sampler2D _MainTex;

      //Edge detection variables
      float _DeltaX;
      float _DeltaY;
      float _LowerCutoff;
      float _UpperCutoff;

      //Change the color of the edges
      float4 _Color;

      struct v2f {
	float4 uvMainTex : TEXCOORD0;
	float4 pos : SV_POSITION;
      };
      
      //Edge detection algorithmn
      float sobel(sampler2D tex, float2 uv) {
	float2 delta = float2(_DeltaX, _DeltaY);

	float4 hr = float4(0,0,0,0);
	float4 vt = float4(0,0,0,0);

	hr += tex2D(tex, (uv + float2(-1.0, -1.0) * delta)) *  1.0; //Lower left
	hr += tex2D(tex, (uv + float2( 0.0, -1.0) * delta)) *  0.0;
	hr += tex2D(tex, (uv + float2( 1.0, -1.0) * delta)) * -1.0;
	hr += tex2D(tex, (uv + float2(-1.0,  0.0) * delta)) *  2.0;
	hr += tex2D(tex, (uv + float2( 0.0,  0.0) * delta)) *  0.0;
	hr += tex2D(tex, (uv + float2( 1.0,  0.0) * delta)) * -2.0;
	hr += tex2D(tex, (uv + float2(-1.0,  1.0) * delta)) *  1.0;
	hr += tex2D(tex, (uv + float2( 0.0,  1.0) * delta)) *  0.0;
	hr += tex2D(tex, (uv + float2( 1.0,  1.0) * delta)) * -1.0; //Upper right

	//Vertical
	vt += tex2D(tex, (uv + float2(-1.0, -1.0) * delta)) *  1.0;
	vt += tex2D(tex, (uv + float2( 0.0, -1.0) * delta)) *  2.0;
	vt += tex2D(tex, (uv + float2( 1.0, -1.0) * delta)) *  1.0;
	vt += tex2D(tex, (uv + float2(-1.0,  0.0) * delta)) *  0.0;
	vt += tex2D(tex, (uv + float2( 0.0,  0.0) * delta)) *  0.0;
	vt += tex2D(tex, (uv + float2( 1.0,  0.0) * delta)) *  0.0;
	vt += tex2D(tex, (uv + float2(-1.0,  1.0) * delta)) * -1.0;
	vt += tex2D(tex, (uv + float2( 0.0,  1.0) * delta)) * -2.0;
	vt += tex2D(tex, (uv + float2( 1.0,  1.0) * delta)) * -1.0;

	return sqrt(hr * hr + vt * vt);

      }

      float4x4 unity_Projector;
      
      //Vertex shader
      v2f vert (float4 vertex : POSITION){
	v2f o;
	o.pos = mul(UNITY_MATRIX_MVP, vertex);
	o.uvMainTex = mul(unity_Projector, vertex);
	return o;
      }
      //Fragment shader
      float4 frag (v2f i) : SV_Target {

	float s = sobel(_MainTex, i.uvMainTex);

	if(s < _LowerCutoff || s > _UpperCutoff){
	  discard;
	}

	fixed4 texS = tex2Dproj(_MainTex, UNITY_PROJ_COORD(i.uvMainTex));
	texS.rgb *= _Color.rgb;
	texS.a = s;

	fixed4 res = texS + _Color;

	return res;
	
      }
      ENDCG
	}
  }
}
      
     

      
	
