#if !defined(TESSELLATION_INCLUDED)
#define TESSELLATION_INCLUDED

float _TessellationUniform;
float _TessellationEdgeLength;

struct VertexData {
    float4 vertex : POSITION;
};

[UNITY_domain("tri")]
[UNITY_outputcontrolpoints(3)]
[UNITY_outputtopology("triangle_cw")]
[UNITY_partitioning("fractional_odd")]
[UNITY_patchconstantfunc("MyPatchConstantFunction")]
VertexData MyHullProgram (
    InputPatch<VertexData, 3> patch,
    uint id : SV_OutputControlPointID)
{
    return patch[id];
}

struct TessellationFactors {
    float edge[3] : SV_TessFactor;
    float inside : SV_InsideTessFactor;
};

float TessellationEdgeFactor (float3  cp0, float3  cp1)
{
    #if defined(_TESSELLATION_EDGE)
    float3 p0 = mul(unity_ObjectToWorld, float4(cp0.xyz, 1)).xyz;
    float3 p1 = mul(unity_ObjectToWorld, float4(cp1.xyz, 1)).xyz;
    float edgeLength = distance(p0, p1);

    float3 edgeCenter = (p0 + p1) * 0.5;
    float viewDistance = distance(edgeCenter, _WorldSpaceCameraPos);

    return edgeLength * _ScreenParams.y / (_TessellationEdgeLength * viewDistance);
    #else
    return _TessellationUniform;
    #endif
}

TessellationFactors MyPatchConstantFunction (InputPatch<VertexData, 3> patch) {
    
    float3 p0 = mul(unity_ObjectToWorld, patch[0].vertex).xyz;
    float3 p1 = mul(unity_ObjectToWorld, patch[1].vertex).xyz;
    float3 p2 = mul(unity_ObjectToWorld, patch[2].vertex).xyz;
    
    TessellationFactors f;
    f.edge[0] = TessellationEdgeFactor(p1, p2);
    f.edge[1] = TessellationEdgeFactor(p2, p0);
    f.edge[2] = TessellationEdgeFactor(p0, p1);
    f.inside =
        (TessellationEdgeFactor(p1, p2) +
        TessellationEdgeFactor(p2, p0) +
        TessellationEdgeFactor(p0, p1)) * (1 / 3.0);
    return f;
}

[UNITY_domain("tri")]
VertexData MyDomainProgram (
    TessellationFactors factors,
    OutputPatch<VertexData, 3> patch,
    float3 barycentricCoordinates : SV_DomainLocation
)
{
    #define MY_DOMAIN_PROGRAM_INTERPOLATE(fieldName) data.fieldName = \
        patch[0].fieldName * barycentricCoordinates.x + \
        patch[1].fieldName * barycentricCoordinates.y + \
        patch[2].fieldName * barycentricCoordinates.z;
    
    VertexData data;
    
    MY_DOMAIN_PROGRAM_INTERPOLATE(vertex)

    return data;
}

#endif