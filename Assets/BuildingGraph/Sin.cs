using UnityEngine;

namespace BuildingGraph
{
    public class Sin: Graph
    {
        protected override float CalculateY(float x) => Mathf.Sin(Mathf.PI * x);
    }
}