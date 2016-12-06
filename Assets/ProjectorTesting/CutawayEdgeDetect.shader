Shader "CutawayEdge Detection" {

    Properties {
	_MainTex ("Base (RGB)", 2D) = "white" {}
	_DeltaX ("Delta X", Float) = 0.01
	_DeltaY ("Delta Y", Float) = 0.01
	_LowerCutoff ("Lower Cutoff", Range(0,1)) = 0.0
	_UpperCutoff ("Upper Cutoff", Range(0,1)) = 1.0
	_ColorPicker ("Color", Color) = (1,1,1,1)
    }
    
    SubShader {
	Tags { "RenderType"="Transparent" }
	LOD 200
	
	CGINCLUDE
	
#include "UnityCG.cginc"
	
	sampler2D _MainTex;
	float _DeltaX;
	float _DeltaY;
	float _LowerCutoff;
	float _UpperCutoff;
	float4 _ColorPicker;

	float sobel (sampler2D tex, float2 uv) {
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
	
	float4 frag (v2f_img IN) : COLOR {
	    float s = sobel(_MainTex, IN.uv);
	    if(s < _LowerCutoff || s > _UpperCutoff){
		discard;
	    }
	    return float4(s, s, s, 1) +  _ColorPicker;
	}
	
	ENDCG
	
	Pass {
	    CGPROGRAM
#pragma vertex vert_img
#pragma fragment frag
	    ENDCG
	}
	
    } 
    FallBack "Projector/Light"
}
