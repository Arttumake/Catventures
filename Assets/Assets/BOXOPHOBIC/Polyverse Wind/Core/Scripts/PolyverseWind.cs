//Cristian Pop - https://boxophobic.com/

using UnityEngine;
using Boxophobic;

[HelpURL("https://docs.google.com/document/d/1PPkiR2PO4P2MoGjkNLL28WOOfrsN-8pEJiCglwXKdkI/edit#heading=h.kfvqsi6kusw4")]
[DisallowMultipleComponent]
[ExecuteInEditMode]
[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
public class PolyverseWind : MonoBehaviour 
{

    [BCategory("Wind")]
    public bool Wind_Category;

	public float windAmplitude = 1f;
	public float windSpeed = 1f;

    [BCategory("Turbulence")]
    public bool Turbulence_Category;

    public float turbulenceSpeed = 1f;

#if UNITY_EDITOR
    [HideInInspector]
    public Mesh arrowMesh;
    [HideInInspector]
    public Material arrowMaterial;

    //private Shader debugShader;
#endif

    void Start()
    {

#if UNITY_EDITOR
        gameObject.GetComponent<MeshFilter>().mesh = arrowMesh;
        gameObject.GetComponent<MeshRenderer>().sharedMaterial = arrowMaterial;
#endif

        gameObject.name = "Polyverse Wind";

        // Disable Arrow in play mode
        if (Application.isPlaying == true)
        {
            gameObject.GetComponent<MeshRenderer>().enabled = false;
        }
        else
        {
            gameObject.GetComponent<MeshRenderer>().enabled = true;
        }

        // Send global information to shaders
        SetGlobalShaderProperties();
    }

#if UNITY_EDITOR
    void Update()
    {
        SetGlobalShaderProperties();
    }
#endif

    void SetGlobalShaderProperties()
    {
        // Send wind information to shaders
        Shader.SetGlobalVector("PWD_GlobalDirection", gameObject.transform.forward);
        Shader.SetGlobalFloat("PWD_GlobalSpeed", windSpeed);
        Shader.SetGlobalFloat("PWD_GlobalAmplitude", windAmplitude * 0.1f);

        Shader.SetGlobalFloat("PWD_GlobalTurbulenceSpeed", turbulenceSpeed);
    }
}
