Shader "CatLikeCoding/Shader"
{
	Properties {
			_Tint ("Tint", Color) = (1, 1, 1, 1)
	}
	
	SubShader {
		Pass {
		    CGPROGRAM

		    #pragma vertex vertex_program
			#pragma fragment fragment_program

		    #include "UnityCG.cginc"

		    float4 _Tint;

		    float4 vertex_program (float4 position : POSITION) : SV_POSITION {
		    	return UnityObjectToClipPos(position);
			}

			float4  fragment_program (float4 position : SV_POSITION) : SV_TARGET {
		    	return _Tint;
			}
				
			ENDCG
		}
	}
}