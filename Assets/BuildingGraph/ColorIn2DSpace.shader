Shader "Graph/ColorIn2DSpace" {
	
	SubShader 
	{
		CGPROGRAM

		#pragma surface ConfigureSurface Standard fullforwardshadows
		#pragma target 3.0

		struct Input {
			float3 worldPos;
		};

		void ConfigureSurface (Input input, inout SurfaceOutputStandard surface)
		{
			half r = 1;
			half g = input.worldPos.y * 0.5 / 1.5 + 0.5;
			half b = 0.5;
			
			surface.Albedo = half3(r, g, b);
			surface.Smoothness = 0.5;
		}
		
		ENDCG
	}
	
	FallBack "Diffuse"
}