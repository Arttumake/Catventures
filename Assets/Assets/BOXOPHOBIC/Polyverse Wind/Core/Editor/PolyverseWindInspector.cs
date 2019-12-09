//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic;

[CustomEditor(typeof(PolyverseWind))]
public class PolyverseWindInspector : Editor
{
	private static readonly string excludeScript = "m_Script";

    private Color bannerColor;
    private string bannerText;
    private string helpURL;

	void OnEnable()
    {
        bannerColor = bannerColor = new Color(0.435f, 0.764f, 0.478f);
        bannerText = "Polyverse Wind";
        helpURL = "https://docs.google.com/document/d/1PPkiR2PO4P2MoGjkNLL28WOOfrsN-8pEJiCglwXKdkI/edit#heading=h.kfvqsi6kusw4";
    }

	public override void OnInspectorGUI()
    {
        BEditorGUI.DrawBanner(bannerColor, bannerText, helpURL);
        DrawInspector();
		BEditorGUI.DrawLogo();
	}

	void DrawInspector()
    {
		serializedObject.Update ();

		DrawPropertiesExcluding (serializedObject, excludeScript);

		serializedObject.ApplyModifiedProperties ();

		GUILayout.Space (20);
	} 
}

