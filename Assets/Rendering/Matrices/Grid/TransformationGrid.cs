using System.Collections.Generic;
using UnityEngine;

namespace Rendering.Matrices
{
    public class TransformationGrid : MonoBehaviour
    {
        public Transform _prefab;

        public int _gridResolution = 10;

        private Transform[] _grid;

        private Matrix4x4 _transformation;
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
            UpdateTransformation();
            for (int i = 0, z = 0; z < _gridResolution; z++)
            for (var y = 0; y < _gridResolution; y++)
            for (var x = 0; x < _gridResolution; x++, i++)
                _grid[i].localPosition = TransformPoint(x, y, z);
        }

        private void UpdateTransformation ()
        {
            GetComponents(_transformations);
            if (_transformations.Count <= 0) return;
            _transformation = _transformations[0].Matrix;
            for (var i = 1; i < _transformations.Count; i++)
                _transformation = _transformations[i].Matrix * _transformation;
        }

        private Vector3 TransformPoint (int x, int y, int z)
        {
            var coordinates = GetCoordinates(x, y, z);
            return _transformation.MultiplyPoint(coordinates);
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