// Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;
using Boxophobic;
using System.IO;

public class PolyverseWindHub : EditorWindow
{
    readonly string[] RenderPipeline =
    {
        "Standard",
        "Universal",
        //"High Definition",
    };

    readonly string[] RenderPipelinePaths =
    {
        "/Polyverse Wind/Core/Packages/Standard.unitypackage",
        "/Polyverse Wind/Core/Packages/Universal XXXX.Y.unitypackage",
        //"/Skybox Cubemap Extended/Core/Packages/High Definition XXXX.Y.unitypackage",
    };

    readonly string[] RenderPipelineDownload =
    {
        "http://u3d.as/18Q1",
        "http://u3d.as/18Q1",
        //"",
    };

    const string AssetName = "Polyverse Wind";
    string boxophobicFolder;
    string unityMajorVersion;
    string unityMinorVersion;

    int pipelineIndex;
    string pipelinePath;

    GUIStyle stylePopup;

    Color bannerColor;
    string bannerText;
    string helpURL;

    static PolyverseWindHub Window;

    [MenuItem("Window/BOXOPHOBIC/" + AssetName + "/Hub")]
    public static void ShowWindow()
    {
        Window = GetWindow<PolyverseWindHub>(false, AssetName, true);
        Window.minSize = new Vector2(480, 200);
    }
    void OnEnable()
    {
        bannerColor = new Color(0.435f, 0.764f, 0.478f);
        bannerText = AssetName;
        helpURL = "https://docs.google.com/document/d/1PPkiR2PO4P2MoGjkNLL28WOOfrsN-8pEJiCglwXKdkI/edit#heading=h.hbq3w8ae720x";

        boxophobicFolder = BEditorUtils.GetBoxophobicFolder();

        unityMajorVersion = Application.unityVersion.Substring(0, 4);
        unityMinorVersion = Application.unityVersion.Substring(5, 1);

        // LTS unity version use XXXX.3 package version
        if (int.Parse(unityMinorVersion) == 4)
        {
            unityMinorVersion = "3";
        }
    }

    void OnGUI()
    {
        SetGUIStyles();

        BEditorGUI.DrawWindowBanner(bannerColor, bannerText, helpURL);

        GUILayout.BeginHorizontal();
        GUILayout.Space(20);

        GUILayout.BeginVertical();

#if UNITY_2019_3_OR_NEWER
        DrawRenderPipelineSelection();
        GetRenderPipelinePackagePath();
        DrawRenderPipelineButton();
#else
        EditorGUILayout.HelpBox("The Render Pipeline can be selected only in Unity 2019.3 or newer!", MessageType.Info);
#endif

        GUILayout.EndVertical();

        GUILayout.Space(13);
        GUILayout.EndHorizontal();

        GUILayout.BeginVertical();
        GUILayout.FlexibleSpace();

        BEditorGUI.DrawLogo();

        GUILayout.FlexibleSpace();
        GUILayout.Space(20);
        GUILayout.EndVertical();
    }

    void SetGUIStyles()
    {
        stylePopup = new GUIStyle(EditorStyles.popup)
        {
            alignment = TextAnchor.MiddleCenter
        };
    }

    void DrawRenderPipelineSelection()
    {
        GUILayout.BeginHorizontal();
        EditorGUILayout.LabelField(new GUIContent("Render Pipeline", ""));
        pipelineIndex = EditorGUILayout.Popup(pipelineIndex, RenderPipeline, stylePopup, GUILayout.Width(160));
        GUILayout.EndHorizontal();
    }

    void DrawRenderPipelineButton()
    {
        GUILayout.BeginHorizontal();
        GUILayout.Label("");

        if (File.Exists(boxophobicFolder + pipelinePath))
        {
            if (GUILayout.Button("Setup", GUILayout.Width(160)))
            {
                SetRenderPipeline();
                ImportASETemplates();
            }
        }
        else
        {
            if (GUILayout.Button("Download", GUILayout.Width(160)))
            {
                OpenRenderPipelineLink();
            }
        }

        GUILayout.EndHorizontal();
    }

    void GetRenderPipelinePackagePath()
    {
        pipelinePath = RenderPipelinePaths[pipelineIndex].Replace("XXXX", unityMajorVersion);
        pipelinePath = pipelinePath.Replace("Y", unityMinorVersion);
    }

    void SetRenderPipeline()
    {
        AssetDatabase.ImportPackage(boxophobicFolder + pipelinePath, false);
        Debug.Log("[" + AssetName + "] " + RenderPipeline[pipelineIndex] + " package imported!");
    }

    void ImportASETemplates()
    {
        if (pipelineIndex == 1)
        {
            AssetDatabase.ImportPackage(boxophobicFolder + "/Utils/ASE Templates/Universal " + unityMajorVersion + "." + unityMinorVersion + " Simple Lit.unitypackage", false);
            Debug.Log("[BOXOPHOBIC] Universal Simple Lit ASE Template imported!");
        }
    }

    void OpenRenderPipelineLink()
    {
        Application.OpenURL(RenderPipelineDownload[pipelineIndex]);
    }

    // UNUSED

    //void GetSettings()
    //{
    //    string settingsAssetPath = boxophobicFolder + "/Atmospheric Height Fog/Core/Editor/HeightFogSettings.asset";

    //    if (AssetDatabase.LoadAssetAtPath<HeightFogSettings>(settingsAssetPath) == null)
    //    {
    //        var instanceAsset = CreateInstance(typeof(HeightFogSettings));
    //        AssetDatabase.CreateAsset(instanceAsset, settingsAssetPath);
    //        AssetDatabase.SaveAssets();
    //    }

    //    heightFogSettings = AssetDatabase.LoadAssetAtPath<HeightFogSettings>(settingsAssetPath);
    //   // renderPipeline = heightFogSettings.renderPipeine;
    //}

    //void SetSettings()
    //{
    //    EditorUtility.SetDirty(heightFogSettings);
    //    AssetDatabase.SaveAssets();
    //}

    //void CleanupIncompatibleAssets()
    //{
    //    AssetDatabase.Refresh();
    //}
}
