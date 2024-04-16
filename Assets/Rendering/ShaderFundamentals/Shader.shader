Shader "CatLikeCoding/Shader"
{
	SubShader {
		Pass {
		    CGPROGRAM

		    #pragma vertex vertex_program
			#pragma fragment fragment_program

		    #include "UnityCG.cginc"

		    float4 vertex_program () : SV_POSITION {
		    	return 0;
			}

			float4  fragment_program (float4 position : SV_POSITION) : SV_TARGET {
		    	return 0;
			}
				
			ENDCG
		}
	}
}