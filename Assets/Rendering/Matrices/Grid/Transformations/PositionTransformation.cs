using UnityEngine;

namespace Rendering.Matrices
{
    public class PositionTransformation : Transformation {

        public Vector3 Position;

        public override Vector3 Apply (Vector3 point) => point + Position;
    }
}