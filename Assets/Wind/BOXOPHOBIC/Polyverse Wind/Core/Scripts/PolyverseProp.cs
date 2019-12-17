//Cristian Pop - https://boxophobic.com/

using System.Collections.Generic;
using UnityEngine;
using Boxophobic;

[HelpURL("https://docs.google.com/document/d/1PPkiR2PO4P2MoGjkNLL28WOOfrsN-8pEJiCglwXKdkI/edit#heading=h.hd5jt8lucuqq")]
[DisallowMultipleComponent]
[ExecuteInEditMode]
public class PolyverseProp : MonoBehaviour
{
    [BMessage("The gameobject should have valid MeshFilter component with a Mesh attached!", "Warning", 10, 10)]
    public bool warningMissingMesh = false;

    public enum GradientMaskEnum
    {
        VertexPosX,
        VertexPosY,
        VertexPosZ,
    }
    public GradientMaskEnum gradientMask = GradientMaskEnum.VertexPosY;
    [HideInInspector]
    public GradientMaskEnum gradientMaskOld = GradientMaskEnum.VertexPosY;

    public enum MotionMaskEnum
    {
        VertexPosX,
        VertexPosY,
        VertexPosZ,
        VertexRed,
        VertexGreen,
        VertexBlue,
        VertexAlpha,
    }
    public MotionMaskEnum motionMask = MotionMaskEnum.VertexPosY;
    [HideInInspector]
    public MotionMaskEnum motionMaskOld = MotionMaskEnum.VertexPosY;

    public MotionMaskEnum detailMask = MotionMaskEnum.VertexPosY;
    [HideInInspector]
    public MotionMaskEnum detailMaskOld = MotionMaskEnum.VertexPosY;

    [HideInInspector]
    public Mesh sharedMesh;
    //private Material sharedMaterial;

    void Awake()
    {
        warningMissingMesh = false;

        if (gameObject.GetComponent<MeshFilter>() == null || gameObject.GetComponent<MeshFilter>().sharedMesh == null)
        {
            warningMissingMesh = true;
            return;
        }

        sharedMesh = gameObject.GetComponent<MeshFilter>().sharedMesh;

        sharedMesh.name = sharedMesh.name.Replace(" (PDP QuickMask)", "");

        if (sharedMesh.name.Contains("PolyverseProp"))
        {
            return;
        }
        else
        {
            MaskDataToTexCoord(sharedMesh, true);
        }
    }

#if UNITY_EDITOR

    void Update()
    {
        if (gradientMaskOld != gradientMask || motionMaskOld != motionMask || detailMaskOld != detailMask)
        {
            MaskDataToTexCoord(sharedMesh, false);
            UpdatePropsWithSharedMesh();
        }
    }

#endif

    void OnDestroy()
    {
        if (sharedMesh != null)
        {
            sharedMesh.name = sharedMesh.name.Replace(" (PolyverseProp)", "");
        }
        
    }

    void MaskDataToTexCoord(Mesh inputMesh, bool changeName)
    {
        var uv0 = new List<Vector4>();
        var uv3 = new List<Vector4>();

        var uv = inputMesh.uv;
        var pos = inputMesh.vertices;
        var colors = inputMesh.colors;

        int vertexCount = inputMesh.vertices.Length;

        var gradient = new float[vertexCount];

        if (gradientMask == GradientMaskEnum.VertexPosY)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                gradient[i] = pos[i].y;
            }
        }
        else if (gradientMask == GradientMaskEnum.VertexPosX)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                gradient[i] = pos[i].x;
            }
        }
        else if (gradientMask == GradientMaskEnum.VertexPosZ)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                gradient[i] = pos[i].z;
            }
        }

        var motion = new float[vertexCount];

        if (motionMask == MotionMaskEnum.VertexPosY)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                motion[i] = pos[i].y;
            }
        }
        else if (motionMask == MotionMaskEnum.VertexPosX)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                motion[i] = pos[i].x;
            }
        }
        else if (motionMask == MotionMaskEnum.VertexPosZ)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                motion[i] = pos[i].z;
            }
        }
        else if (motionMask == MotionMaskEnum.VertexRed)
        {
            if (colors.Length > 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion[i] = colors[i].r;
                }
            }
            else
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion[i] = 1;
                }
            }
        }
        else if (motionMask == MotionMaskEnum.VertexGreen)
        {
            if (colors.Length > 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion[i] = colors[i].g;
                }
            }
            else
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion[i] = 1;
                }
            }
        }
        else if (motionMask == MotionMaskEnum.VertexBlue)
        {
            if (colors.Length > 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion[i] = colors[i].b;
                }
            }
            else
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion[i] = 1;
                }
            }
        }
        else if (motionMask == MotionMaskEnum.VertexAlpha)
        {
            if (colors.Length > 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion[i] = colors[i].a;
                }
            }
            else
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    motion[i] = 1;
                }
            }
        }

        var detail = new float[vertexCount];

        if (detailMask == MotionMaskEnum.VertexPosY)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                detail[i] = pos[i].y;
            }
        }
        else if (detailMask == MotionMaskEnum.VertexPosX)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                detail[i] = pos[i].x;
            }
        }
        else if (detailMask == MotionMaskEnum.VertexPosZ)
        {
            for (int i = 0; i < vertexCount; i++)
            {
                detail[i] = pos[i].z;
            }
        }
        else if (detailMask == MotionMaskEnum.VertexRed)
        {
            if (colors.Length > 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    detail[i] = colors[i].r;
                }
            }
            else
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    detail[i] = 1;
                }
            }
        }
        else if (detailMask == MotionMaskEnum.VertexGreen)
        {
            if (colors.Length > 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    detail[i] = colors[i].g;
                }
            }
            else
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    detail[i] = 1;
                }
            }
        }
        else if (detailMask == MotionMaskEnum.VertexBlue)
        {
            if (colors.Length > 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    detail[i] = colors[i].b;
                }
            }
            else
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    detail[i] = 1;
                }
            }
        }
        else if (detailMask == MotionMaskEnum.VertexAlpha)
        {
            if (colors.Length > 0)
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    detail[i] = colors[i].a;
                }
            }
            else
            {
                for (int i = 0; i < vertexCount; i++)
                {
                    detail[i] = 1;
                }
            }
        }

        for (int i = 0; i < vertexCount; i++)
        {
            uv0.Add(new Vector4(uv[i].x, uv[i].y, motion[i], detail[i]));
            uv3.Add(new Vector4(pos[i].x, pos[i].y, pos[i].z, gradient[i]));
        }

        inputMesh.SetUVs(0, uv0);
        inputMesh.SetUVs(3, uv3);

        if (changeName == true)
        {
            inputMesh.name = sharedMesh.name + " (PolyverseProp)";
        }

        uv0.Clear();
        uv3.Clear();

        gradientMaskOld = gradientMask;
        motionMaskOld = motionMask;
        detailMaskOld = detailMask;
    }

    void UpdatePropsWithSharedMesh()
    {
        var allPolyverseProps = Resources.FindObjectsOfTypeAll<PolyverseProp>();

        foreach (var prop in allPolyverseProps)
        {
            if (prop.sharedMesh == sharedMesh)
            {
                //Debug.Log("[Polyverse Wind] " + prop.gameObject.name + " Updated");

                prop.gradientMask = gradientMask;
                prop.gradientMaskOld = gradientMaskOld;
                prop.motionMask = motionMask;
                prop.motionMaskOld = motionMaskOld;
                prop.detailMask = detailMask;
                prop.detailMaskOld = detailMaskOld;
            }
        }
    }
}
