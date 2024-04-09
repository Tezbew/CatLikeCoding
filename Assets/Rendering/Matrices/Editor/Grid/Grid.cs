using UnityEngine;

namespace Rendering.Matrices
{
    public class Grid
    {
        private readonly Transform[,,] _grid;

        public Grid(Transform[,,] grid)
        {
            _grid = grid;
        }
    }
}