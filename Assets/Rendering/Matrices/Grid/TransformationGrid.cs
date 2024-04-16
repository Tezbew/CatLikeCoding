using System.Collections.Generic;
using UnityEngine;

namespace Rendering.Matrices
{
    public class TransformationGrid : MonoBehaviour
    {
        public Transform _prefab;

        public int _gridResolution = 10;

        private Transform[] _grid;

        private List<Transformation> _transformations;

        private void Awake ()
        {
            _grid = new Transform[_gridResolution * _gridResolution * _gridResolution];
            for (int i = 0, z = 0; z < _gridResolution; z++)
            for (var y = 0; y < _gridResolution; y++)
            for (var x = 0; x < _gridResolution; x++, i++)
                _grid[i] = CreateGridPoint(x, y, z);

            _transformations = new List<Transformation>();
        }

        private void Update ()
        {
            GetComponents(_transformations);
            for (int i = 0, z = 0; z < _gridResolution; z++)
            for (var y = 0; y < _gridResolution; y++)
            for (var x = 0; x < _gridResolution; x++, i++)
                _grid[i].localPosition = TransformPoint(x, y, z);
        }

        private Vector3 TransformPoint (int x, int y, int z)
        {
            var coordinates = GetCoordinates(x, y, z);
            foreach (var t in _transformations)
                coordinates = t.Apply(coordinates);

            return coordinates;
        }

        private Transform CreateGridPoint (int x, int y, int z)
        {
            var point = Instantiate(_prefab);
            point.localPosition = GetCoordinates(x, y, z);
            point.GetComponent<MeshRenderer>().material.color = new Color(
                (float)x / _gridResolution,
                (float)y / _gridResolution,
                (float)z / _gridResolution
            );
            return point;
        }

        private Vector3 GetCoordinates (int x, int y, int z)
        {
            return new Vector3(
                x - (_gridResolution - 1) * 0.5f,
                y - (_gridResolution - 1) * 0.5f,
                z - (_gridResolution - 1) * 0.5f
            );
        }
    }
}