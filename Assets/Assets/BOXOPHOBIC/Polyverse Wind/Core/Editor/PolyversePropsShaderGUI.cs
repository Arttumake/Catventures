//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using UnityEditor;

public class PolyversePropsShaderGUI : ShaderGUI
{
    Material material;
    int surface;
    int blend;
    int clip;
    int queueOffset;
    int queueOffsetRange;

    public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
    {
        base.OnGUI(materialEditor, props);

        material = materialEditor.target as Material;

        Initialize();

        surface = material.GetInt("__surface");
        blend = material.GetInt("__blend");
        clip = material.GetInt("__clip");
        queueOffset = material.GetInt("_QueueOffset") * -1;

        SetQueueOffsetRange();
        SetSurfaceOptions();
        SetAlphaClipping();
        SetColorModeOptions();

        materialEditor.LightmapEmissionProperty(0);
        foreach (Material target in materialEditor.targets)
            target.globalIlluminationFlags &= ~MaterialGlobalIlluminationFlags.EmissiveIsBlack;
    }

    void Initialize()
    {
        if (material.GetInt("_IsInitialized") == 1)
        {
            return;
        }

        // Set previous material render mode
        int mode = -1;

        if (material.GetInt("_Mode") != -1)
        {
            mode = material.GetInt("_Mode");
        } 
        else if (material.GetInt("__mode") != -1)
        {
            mode = material.GetInt("__mode");
        }

        if (mode == 0)
        {
            material.SetInt("__surface", 0);
        }

        if (mode == 1)
        {
            material.SetInt("__surface", 0);
            material.SetInt("__clip", 1);
        }

        if (mode == 2)
        {
            material.SetInt("__surface", 1);
        }

        if (mode == 3)
        {
            material.SetInt("__surface", 1);
            material.SetInt("__blend", 1);
        }

        // Set previous material _Color, _MainTex and _MainTex_ST
        if (material.HasProperty("_IsStandardPipeline"))
        {
            if (material.HasProperty("_Color"))
            {
                material.SetColor("_BaseColor", material.GetColor("_Color"));
            }

            if (material.HasProperty("_MainTex"))
            {
                material.SetTexture("_BaseMap", material.GetTexture("_MainTex"));

                Vector4 uvs = new Vector4(material.GetTextureScale("_MainTex").x, material.GetTextureScale("_MainTex").y, material.GetTextureOffset("_MainTex").x, material.GetTextureOffset("_MainTex").y);

                material.SetVector("_BaseMapUVs", uvs);
            }
        }

        // Set previous material _BaseTex_ST
        if (material.HasProperty("_IsUniversalPipeline"))
        {
            if (material.HasProperty("_BaseMap"))
            {
                Vector4 uvs = new Vector4(material.GetTextureScale("_BaseMap").x, material.GetTextureScale("_BaseMap").y, material.GetTextureOffset("_BaseMap").x, material.GetTextureOffset("_BaseMap").y);

                material.SetVector("_BaseMapUVs", uvs);
            }
        }

        material.SetInt("_IsInitialized", 1);
    }

    void SetQueueOffsetRange()
    {
        if (material.HasProperty("_IsStandardPipeline"))
        {
            queueOffsetRange = 0;
        }
        else
        {
            queueOffsetRange = 50;
        }
    }

    void SetSurfaceOptions()
    {
        if (surface == 0)
        {
            material.SetInt("__src", (int)UnityEngine.Rendering.BlendMode.One);
            material.SetInt("__dst", (int)UnityEngine.Rendering.BlendMode.Zero);
            material.SetInt("__zw", 1);
            material.DisableKeyword("_ALPHAPREMULTIPLY_ON");

            if (clip == 0)
            {
                material.SetOverrideTag("RenderType", "");
                material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Geometry;
            }
            else
            {
                material.SetOverrideTag("RenderType", "TransparentCutout");
                material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.AlphaTest;
            }
        }
        else
        {
            material.SetOverrideTag("RenderType", "Transparent");
            material.SetInt("__zw", 0);
            material.renderQueue = (int)UnityEngine.Rendering.RenderQueue.Transparent;

            if (blend == 0)
            {
                material.SetInt("__src", (int)UnityEngine.Rendering.BlendMode.SrcAlpha);
                material.SetInt("__dst", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
            }
            else if (blend == 1)
            {
                material.SetInt("__src", (int)UnityEngine.Rendering.BlendMode.One);
                material.SetInt("__dst", (int)UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                material.EnableKeyword("_ALPHAPREMULTIPLY_ON");
            }
            else if (blend == 2)
            {
                material.SetInt("__src", (int)UnityEngine.Rendering.BlendMode.One);
                material.SetInt("__dst", (int)UnityEngine.Rendering.BlendMode.One);
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
            }
            else if (blend == 3)
            {
                material.SetInt("__src", (int)UnityEngine.Rendering.BlendMode.DstColor);
                material.SetInt("__dst", (int)UnityEngine.Rendering.BlendMode.Zero);
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");
            }
        }

        material.renderQueue = material.renderQueue + queueOffsetRange + queueOffset;
    }

    void SetAlphaClipping()
    {
        if (material.GetInt("__clip") == 0)
        {
            material.DisableKeyword("_ALPHATEST_ON");
        }
        else
        {
            material.EnableKeyword("_ALPHATEST_ON");
        }
    }

    void SetColorModeOptions()
    {
        if (material.GetInt("_ColorMode") == 0)
        {
            material.SetVector("_ColorModeOptions", new Vector4(1, 0, 0, 0));
        }
        else if (material.GetInt("_ColorMode") == 1)
        {
            material.SetVector("_ColorModeOptions", new Vector4(0, 1, 0, 0));
        }
        else if (material.GetInt("_ColorMode") == 2)
        {
            material.SetVector("_ColorModeOptions", new Vector4(0, 0, 1, 0));
        }
    }
}
