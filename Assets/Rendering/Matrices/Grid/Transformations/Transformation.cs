using UnityEngine;

namespace Rendering.Matrices
{
    public abstract class Transformation : MonoBehaviour
    {
        public abstract Matrix4x4 Matrix { get; }

        public Vector3 Apply (Vector3 point) => Matrix.MultiplyPoint(point);
    }
}