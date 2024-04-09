using UnityEditor;
using UnityEditor.UIElements;
using UnityEngine;
using UnityEngine.UIElements;

namespace Rendering.Matrices
{
    public class GridWindow: EditorWindow
    {
        private ObjectField _prefabField;
        private IntegerField _sizeField;
        private Button _generateButton;
        private Grid _grid;
        
        private void CreateGUI()
        {
            _prefabField = new ObjectField
            {
                label = "Prefab",
                objectType = typeof(Transform),
            };

            _sizeField = new IntegerField
            {
                label = "Size",
            };

            _generateButton = new Button(CreateButtonClickedEventHandler)
            {
                text = "Generate",
            };

            AddElement(_prefabField);
            AddElement(_sizeField);
            AddElement(_generateButton);
        }

        private void CreateButtonClickedEventHandler()
        {
            var gridCreator = new GridCreator();
            var prefab = (Transform)_prefabField.value;
            var size = _sizeField.value;
            _grid = gridCreator.Create(prefab, size);
        }

        private void AddElement(VisualElement child) => rootVisualElement.Add(child);
    }
}