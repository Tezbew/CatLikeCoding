using System.Collections.Generic;
using UnityEngine;

namespace BuildingGraph
{
    public abstract class Graph : MonoBehaviour
    {
        [SerializeField] private Transform _prefab;
        [SerializeField] private float _start = -10;
        [SerializeField] private float _end = 10;
        [SerializeField] private float _step = 0.25f;
        [SerializeField] private float _speed = 20;
        private float _intervalLength;
        private float _offset;
        private List<Transform> _points;
        private float _timeSinceUpdate;

        private void Start()
        {
            _points = new List<Transform>();
            _intervalLength = _end - _start;
            for (var x = _start; x <= _end; x += _step)
            {
                var point = CreatePoint(x);
                _points.Add(point);
            }
        }

        private void Update()
        {
            var updateInterval = 1 / _speed;
            _timeSinceUpdate += Time.deltaTime;

            if (_timeSinceUpdate < updateInterval) return;

            _timeSinceUpdate = 0;

            foreach (var specificPoint in _points)
            {
                var x = specificPoint.position.x;
                specificPoint.position = CalculateShiftedPosition(x, _end, _offset, _intervalLength);
            }

            var maxOffset = _end - _start;
            _offset = _offset <= maxOffset
                ? _offset + _step
                : 0;
        }

        private Transform CreatePoint(float x)
        {
            var y = CalculateY(x);
            var position = new Vector3(x, y, 0);
            var point = Instantiate(_prefab, position, Quaternion.identity, transform);

            return point;
        }

        private static float ShiftX(float x, float end, float offset, float intervalLength)
        {
            var shiftedX = x + offset;
            if (shiftedX > end) shiftedX -= intervalLength;

            return shiftedX;
        }

        private Vector3 CalculateShiftedPosition(float x, float end, float offset, float intervalLength)
        {
            var shiftedX = ShiftX(x, end, offset, intervalLength);
            var shiftedY = CalculateY(shiftedX);
            var shiftedPosition = new Vector2(x, shiftedY);

            return shiftedPosition;
        }

        protected abstract float CalculateY(float x);
    }
}