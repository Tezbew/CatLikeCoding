using UnityEditor;

namespace Rendering.Matrices
{
    public static class ToolbarButton
    {
        [MenuItem("Tools/Grid")]
        private static void OpenWindow()
        {
            var window = EditorWindow.GetWindow<GridWindow>();
            window.Show();
        }
    }
}