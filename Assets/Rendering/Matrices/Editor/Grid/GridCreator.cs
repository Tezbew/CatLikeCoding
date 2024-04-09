using UnityEngine;

namespace Rendering.Matrices
{
    public class GridCreator
    {
        public Grid Create(Transform prefab, int size)
        {
            var gridArray = new Transform[size, size, size];
            var parent = new GameObject("Grid").GetComponent<Transform>();
            
            for (var x = 0; x < size; x++)
            {
                for (var y = 0; y < size; y++)
                {
                    for (var z = 0; z < size; z++)
                    {
                        gridArray[x,y,z] = Create(prefab, parent, x, y, z, size);
                    }
                }
            }

            var grid = new Grid(gridArray);

            return grid;
        }

        private static Transform Create(Transform prefab, Transform parent, int xIndex, int yIndex, int zIndex, int size)
        {
            var instance = Object.Instantiate(prefab, parent);
            instance.localPosition = CalculatePosition(xIndex, yIndex, zIndex, size);
            
            var mesh = instance.GetComponent<MeshRenderer>();
            mesh.material.color = CalculateColor(xIndex, yIndex, zIndex, size);

            return instance;
        }

        private static Vector3 CalculatePosition(int xIndex, int yIndex, int zIndex, int size)
        {
            var x = CalculatePosition(xIndex, size);
            var y =  CalculatePosition(yIndex, size);
            var z =  CalculatePosition(zIndex, size);
            var position = new Vector3(x, y, z);
            
            return position;
        }

        private static float CalculatePosition(int index, int size) => index - (size - 1) * 0.5f;

        private static Color CalculateColor(int xIndex, int yIndex, int zIndex, int size)
        {
            var r = CalculateColor(xIndex, size);
            var g = CalculateColor(yIndex, size);
            var b = CalculateColor(zIndex, size);
            var color = new Color(r, g, b);

            return color;
        }
        
        private static float CalculateColor(int index, int size) => (float)index / size;
    }
}