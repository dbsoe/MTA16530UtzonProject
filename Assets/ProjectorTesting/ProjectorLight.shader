// Upgrade NOTE: replaced '_Projector' with 'unity_Projector'
// Upgrade NOTE: replaced '_ProjectorClip' with 'unity_ProjectorClip'

Shader "Projector/Light" {
  Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
      _ShadowTex ("Cookie", 2D) = "white" {}
    _FalloffTex ("FallOff", 2D) = "" {}
    _MainTex ("Base (RGB)", 2D) = "white"{}
    _DeltaX ("Delta X", Float) = 0.01
      _DeltaY ("Delta Y", Float) = 0.01
      _LowerCutoff ("Lower Cutoff", Range(0,1)) = 0.0
      _UpperCutoff ("Upper Cutoff", Range (0,1)) = 1.0
      }
	
  Subshader {
    Tags {"Queue"="Transparent"}
    Pass {
      ZWrite Off
	ColorMask RGB
	Blend One Zero
	Offset -1, -1
	
	CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#pragma multi_compile_fog
#include "UnityCG.cginc"

	sampler2D _MainTex;
      float _DeltaX;
      float _DeltaY;
      float _LowerCutoff;
      float _UpperCutoff;
      float4 _ColorPicker;
			  
      float sobel(sampler2D tex, float2 uv) {
	float2 delta = float2(_DeltaX, _DeltaY);
	    
	float4 hr = float4(0, 0, 0, 0);
	float4 vt = float4(0, 0, 0, 0);

	//Horisontal
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
			
      struct v2f {
	float4 uvShadow : TEXCOORD0;
	float4 uvFalloff : TEXCOORD1;
	UNITY_FOG_COORDS(2)
	float4 pos : SV_POSITION;
      };
			
      float4x4 unity_Projector;
      float4x4 unity_ProjectorClip;
			
      v2f vert (float4 vertex : POSITION)
      {
	v2f o;
	o.pos = mul (UNITY_MATRIX_MVP, vertex);
	o.uvShadow = mul (unity_Projector, vertex);
	o.uvFalloff = mul (unity_ProjectorClip, vertex);
	UNITY_TRANSFER_FOG(o,o.pos);
	return o;
      }
			
      fixed4 _Color;
      sampler2D _ShadowTex;
      sampler2D _FalloffTex;
      
      float4 frag (v2f i) : SV_Target
	{

	  
	  float s = sobel(_ShadowTex, i.uvShadow);
	  if(s < _LowerCutoff || s > _UpperCutoff){
	    discard;
	  }
	  
	  
	  fixed4 texS = tex2Dproj (_ShadowTex, UNITY_PROJ_COORD(i.uvShadow));
	  texS.rgb *= _Color.rgb;
	  texS.a = s;

	    //1.0-texS.a;
	
	  fixed4 texF = tex2Dproj (_FalloffTex, UNITY_PROJ_COORD(i.uvFalloff));
	  fixed4 res = (texS * texF.a) + _Color;

	  UNITY_APPLY_FOG_COLOR(i.fogCoord, res, fixed4(0,0,0,0));
	  return res;
	}
      ENDCG
	}
  }
}
