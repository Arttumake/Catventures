//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic;

[CanEditMultipleObjects]
[CustomEditor(typeof(PolyverseProp))]
public class PolyversePropInspector : Editor 
{
    private static readonly string excludeProps = "m_Script";

    //private PolyverseProp targetScript;   

    private Color bannerColor;
    private string bannerText;
    private string helpURL;

	void OnEnable()
    {		
		//targetScript = (PolyverseProp)target;

        bannerColor = bannerColor = new Color(0.435f, 0.764f, 0.478f);
        bannerText = "Polyverse Prop";
        helpURL = "https://docs.google.com/document/d/1PPkiR2PO4P2MoGjkNLL28WOOfrsN-8pEJiCglwXKdkI/edit#heading=h.hd5jt8lucuqq";
    }

    public override void OnInspectorGUI()
    {
        BEditorGUI.DrawBanner(bannerColor, bannerText, helpURL);
        DrawInspector();
        //BEditorGUI.DrawLogo();
    }

    void DrawInspector()
    {
        serializedObject.Update();

        DrawPropertiesExcluding(serializedObject, excludeProps);

        serializedObject.ApplyModifiedProperties();

        GUILayout.Space(10);
    }
}
