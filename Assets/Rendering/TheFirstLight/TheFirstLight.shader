// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

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
		    
		    #pragma vertex vertex_program
			#pragma fragment fragment_program
		    
		    #include "UnityPBSLighting.cginc"

		    float4 _Tint;
		    sampler2D _MainTex;
		    float4 _MainTex_ST;
		    float _Metallic;
		    float _Smoothness;

			struct VertexData {
				float4 position : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};
		    
		    struct Interpolators {
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
		    	float3 normal : TEXCOORD1;
		    	float3 worldPos : TEXCOORD2;
			};

		    Interpolators vertex_program (VertexData v)
			{
				Interpolators i;
				i.position = UnityObjectToClipPos(v.position);
				i.worldPos = mul(unity_ObjectToWorld, v.position);
				i.normal = UnityObjectToWorldNormal(v.normal);
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);
		    	
		    	return i;
			}

			float4 fragment_program (Interpolators i) : SV_TARGET {
				i.normal = normalize(i.normal);
				float3 lightDir = _WorldSpaceLightPos0.xyz;
				float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

				float3 albedo = tex2D(_MainTex, i.uv).rgb * _Tint.rgb;
				float3 specularTint;
				float oneMinusReflectivity;
				albedo = DiffuseAndSpecularFromMetallic(albedo, _Metallic, specularTint, oneMinusReflectivity);

				UnityLight light;
				light.color = _LightColor0.rgb;
				light.dir = lightDir;
				light.ndotl = DotClamped(i.normal, lightDir);
				UnityIndirect indirectLight;
				indirectLight.diffuse = 0;
				indirectLight.specular = 0;
				
		    	return BRDF3_Unity_PBS(
		    		albedo, specularTint,
					oneMinusReflectivity, _Smoothness,
					i.normal, viewDir,
					light, indirectLight);
			}
				
			ENDCG
		}
	}
}