Shader "CatLikeCoding/The First Light"
{
	Properties {
		_Tint ("Tint", Color) = (1, 1, 1, 1)
		_MainTex ("Albedo", 2D) = "white" {}
		[Gamma] _Metallic ("Metallic", Range(0, 1)) = 0
		_Smoothness ("Smoothness", Range(0, 1)) = 0.5
	}
	
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