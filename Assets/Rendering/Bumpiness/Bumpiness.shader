Shader "CatLikeCoding/Bumpiness"
{
	Properties {
		_Tint ("Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Albedo", 2D) = "white" {}
		[NoScaleOffset] _NormalMap ("Normals", 2D) = "bump" {}
		_BumpScale ("Bump Scale", Float) = 1
		[Gamma] _Metallic ("Metallic", Range(0, 1)) = 0
		_Smoothness ("Smoothness", Range(0, 1)) = 0.5
		_DetailTex ("Detail Texture", 2D) = "gray" {}
		[NoScaleOffset] _DetailNormalMap ("Detail Normals", 2D) = "bump" {}
		_DetailBumpScale ("Detail Bump Scale", Float) = 1
	}
	
	CGINCLUDE

	#define BINORMAL_PER_FRAGMENT

	ENDCG
	
	SubShader {
		Pass {
			
			Tags {
				"LightMode" = "ForwardBase"
			}
			
		    CGPROGRAM

		    #pragma target 3.0
		    
		    #pragma multi_compile _ VERTEXLIGHT_ON
		    
		    #pragma vertex vertex_program
			#pragma fragment fragment_program

			#define FORWARD_BASE_PASS
		    
		    #include "Lighting.cginc"
				
			ENDCG
		}
		
		Pass {
			
			Tags {
				"LightMode" = "ForwardAdd"
			}
			
			Blend One One
			ZWrite Off

			CGPROGRAM

			#pragma target 3.0

			#pragma multi_compile_fwdadd

			#pragma vertex vertex_program
			#pragma fragment fragment_program
			
			#include "Lighting.cginc"

			ENDCG
		}
	}
}