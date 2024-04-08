using UnityEngine;

namespace BuildingGraph
{
    public class CubicPolynomial: Graph
    {
        protected override float CalculateY(float x) => Mathf.Pow(x, 3);
    }
}