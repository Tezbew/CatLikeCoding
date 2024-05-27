Shader "CatLikeCoding/Tessellation"
{
    Properties
    {
        _TessellationUniform ("Tessellation Uniform", Range(1, 64)) = 1
        _TessellationEdgeLength ("Tessellation Edge Length", Range(5, 100)) = 50
    }
    
    Subshader
    {
        Pass
        {
            CGPROGRAM

            #pragma target 4.6
            #pragma vertex vert
            #pragma fragment frag
            #pragma hull MyHullProgram
            #pragma domain MyDomainProgram
            #pragma shader_feature _TESSELLATION_EDGE = true

            #define _TESSELLATION_EDGE
            
            #include "MyTessellation.cginc"

            float4 vert(VertexData data) : SV_POSITION
            {
                return UnityObjectToClipPos(data.vertex);
            }
            
            float4 frag() : SV_Target
            {
                return 1;
            }
            
            ENDCG
        }
    }
}