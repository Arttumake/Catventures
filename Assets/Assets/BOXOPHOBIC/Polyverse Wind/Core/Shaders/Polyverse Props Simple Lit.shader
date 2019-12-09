// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BOXOPHOBIC/Polyverse Props/Simple Lit"
{
	Properties
	{
		[HideInInspector]_IsPolyversePropsShader("_IsPolyversePropsShader", Float) = 1
		[HideInInspector]_IsStandardPipeline("_IsStandardPipeline", Float) = 1
		[HideInInspector]_IsInitialized("_IsInitialized", Float) = 0
		[BBanner(Polyverse Props, Simple Lit)]_TITLE("< TITLE >", Float) = 1
		[BCategory(Surface Options)]_SurfaceOptionsCat("[ Surface Options Cat ]", Float) = 1
		[Enum(Opaque,0,Transparent,1)]__surface("Render Mode", Float) = 0
		[Enum(Both,0,Back,1,Front,2)]__cull("Render Faces", Float) = 2
		[BInteractive(__surface, 1)]_RenderMode_Transparent("# RenderMode_Transparent", Float) = 0
		[Enum(Alpha,0,Premultiply,1,Additive,2,Multiply,3)][Space(10)]__blend("Blending Mode", Float) = 0
		[BInteractive(ON)]_RenderMode_Reset("# RenderMode_Reset", Float) = 0
		[Toggle][Space(10)]__clip("Alpha Clipping", Float) = 0
		[BInteractive(__clip, 1)]_AlphaClipping_On("# AlphaClipping_On", Float) = 0
		_Cutoff("Alpha Treshold", Range( 0 , 1)) = 0.5
		[BCategory(Surface Color)]_SurfaceColorCat("[ Surface Color Cat ]", Float) = 1
		[Enum(Vertex,0,Color,1,Gradient,2)]_ColorMode("Color Mode", Float) = 1
		[BInteractive(_ColorMode, 1)]_ColorMode_Color("# ColorMode_Color", Float) = 0
		[HDR][Gamma][Space(10)]_BaseColor("Color", Color) = (1,1,1,1)
		[BInteractive(_ColorMode, 2)]_ColorMode_Gradient("# ColorMode_Gradient", Float) = 0
		[HDR][Gamma][Space(10)]_GradientColorMin("Gradient Min", Color) = (0.1193772,0.3307571,0.5073529,1)
		[HDR][Gamma]_GradientColorMax("Gradient Max", Color) = (0.4510705,0.592594,0.7573529,1)
		_GradientPosMin("Position Min", Float) = 0
		_GradientPosMax("Position Max", Float) = 1
		[BCategory(Surface Map)]_SurfaceMapCat("[ Surface Map Cat ]", Float) = 1
		[NoScaleOffset]_BaseMap("Base Map", 2D) = "white" {}
		_BaseMapUVs("Base Map UVs", Vector) = (1,1,0,0)
		[BCategory(Surface Shading)]_SurfaceShadingCat("[ Surface Shading Cat ]", Float) = 1
		_SpecColor("Specular Color",Color)=(1,1,1,1)
		_Smoothness("Smoothness", Range( 0.01 , 1)) = 0.5
		[BCategory(Global Motion)]_MotionGlobalCat("[ Motion Global Cat]", Float) = 1
		[Toggle(_MOTION_ON)] _Motion("Enable Global Motion", Float) = 0
		[BInteractive(_Motion, 1)]_GlobalMotion_On("# GlobalMotion_On", Float) = 0
		[Space(10)]_MotionAmplitude("Global Amplitude", Float) = 0
		_MotionSpeed("Global Speed", Float) = 0
		_MotionScale("Global Scale", Float) = 0
		[Space(10)]_MotionMaskMin("Global Mask Min", Float) = 0
		_MotionMaskMax("Global Mask Max", Float) = 1
		[BCategory(Detail Motion)]_MotionDetailCat("[ Motion Detail Cat]", Float) = 1
		[Toggle(_MOTION3_ON)] _Motion3("Enable Local Motion", Float) = 0
		[BInteractive(_Motion3, 1)]_LocalMotion_On("# LocalMotion_On", Float) = 0
		[Space(10)]_MotionDirection3("Detail Direction", Vector) = (1,1,1,0)
		_MotionAmplitude3("Detail Amplitude", Float) = 0
		_MotionSpeed3("Detail Speed", Float) = 0
		_MotionScale3("Detail Scale", Float) = 0
		[Space(10)]_MotionMaskMin2("Detail Mask Min", Float) = 0
		_MotionMaskMax2("Detail Mask Max", Float) = 1
		[BCategory(Advanced)]_AdvancedCat("[ Advanced Cat]", Float) = 1
		[IntRange]_QueueOffset("Priority", Range( -50 , 50)) = 0
		[HideInInspector]__src("__src", Float) = 1
		[HideInInspector]__dst("__dst", Float) = 10
		[HideInInspector]__zw("__zw", Float) = 0
		[HideInInspector]_Color("_Color", Color) = (0,0,0,0)
		[HideInInspector]_MainTex("_MainTex", 2D) = "white" {}
		[HideInInspector]_Mode("_Mode", Float) = -1
		[HideInInspector]__mode("__mode", Float) = -1
		[HideInInspector]_ColorModeOptions("_ColorModeOptions", Vector) = (0,0,0,0)
		[HideInInspector] _tex4coord4( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		LOD 300
		Cull [__cull]
		ZWrite [__zw]
		Blend [__src] [__dst]
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _ALPHAPREMULTIPLY_ON
		#pragma shader_feature _ALPHATEST_ON
		#pragma shader_feature _MOTION_ON
		#pragma shader_feature _MOTION3_ON
		#pragma surface surf BlinnPhong keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float4 vertexColor : COLOR;
			float4 uv4_tex4coord4;
			float2 uv_texcoord;
		};

		uniform half _Mode;
		uniform half __mode;
		uniform sampler2D _MainTex;
		uniform half _AlphaClipping_On;
		uniform half _ColorMode_Color;
		uniform float _QueueOffset;
		uniform half _Cutoff;
		uniform half _SurfaceMapCat;
		uniform half __src;
		uniform half _IsPolyversePropsShader;
		uniform half _LocalMotion_On;
		uniform half __dst;
		uniform half _SurfaceOptionsCat;
		uniform half _MotionGlobalCat;
		uniform half _RenderMode_Reset;
		uniform half4 _Color;
		uniform half _SurfaceShadingCat;
		uniform half _ColorMode_Gradient;
		uniform half _RenderMode_Transparent;
		uniform half _ColorMode;
		uniform half _GlobalMotion_On;
		uniform half _IsStandardPipeline;
		uniform half _IsInitialized;
		uniform half _AdvancedCat;
		uniform half _MotionDetailCat;
		uniform half __zw;
		uniform half _TITLE;
		uniform half __surface;
		uniform half __clip;
		uniform half __blend;
		uniform half _SurfaceColorCat;
		uniform half __cull;
		uniform half _MotionScale;
		uniform half PWD_GlobalSpeed;
		uniform half _MotionSpeed;
		uniform half PWD_GlobalAmplitude;
		uniform half _MotionAmplitude;
		uniform half3 PWD_GlobalDirection;
		uniform half _MotionMaskMin;
		uniform half _MotionMaskMax;
		uniform half _MotionScale3;
		uniform half _MotionSpeed3;
		uniform half _MotionAmplitude3;
		uniform half _MotionMaskMin2;
		uniform half _MotionMaskMax2;
		uniform float3 _MotionDirection3;
		uniform float PWD_GlobalTurbulenceSpeed;
		uniform half4 _ColorModeOptions;
		uniform half4 _BaseColor;
		uniform float4 _GradientColorMax;
		uniform float4 _GradientColorMin;
		uniform float _GradientPosMax;
		uniform float _GradientPosMin;
		uniform sampler2D _BaseMap;
		uniform float4 _BaseMapUVs;
		uniform half _Smoothness;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_worldPos = mul( unity_ObjectToWorld, v.vertex );
			float2 appendResult375_g116 = (float2(ase_worldPos.x , ase_worldPos.z));
			half MotionScale60_g116 = _MotionScale;
			half MotionSpeed62_g116 = ( PWD_GlobalSpeed * _MotionSpeed );
			float temp_output_7_0_g117 = -1.0;
			float2 temp_cast_0 = (temp_output_7_0_g117).xx;
			half MotionlAmplitude58_g116 = ( PWD_GlobalAmplitude * _MotionAmplitude );
			half3 GlobalDirection349_g116 = PWD_GlobalDirection;
			half3 MotionDirection59_g116 = mul( unity_WorldToObject, float4( GlobalDirection349_g116 , 0.0 ) ).xyz;
			float temp_output_7_0_g107 = _MotionMaskMin;
			half MotionMask137_g116 = ( ( v.texcoord.z - temp_output_7_0_g107 ) / ( _MotionMaskMax - temp_output_7_0_g107 ) );
			float2 break379_g116 = ( ( ( ( ( sin( ( ( appendResult375_g116 * MotionScale60_g116 ) + ( MotionSpeed62_g116 * _Time.y ) ) ) - temp_cast_0 ) / ( 1.0 - temp_output_7_0_g117 ) ) * MotionlAmplitude58_g116 ) * (MotionDirection59_g116).xz ) * MotionMask137_g116 );
			float3 appendResult380_g116 = (float3(break379_g116.x , 0.0 , break379_g116.y));
			half3 Motion_Global1212 = appendResult380_g116;
			#ifdef _MOTION_ON
				float3 staticSwitch979 = Motion_Global1212;
			#else
				float3 staticSwitch979 = float3( 0,0,0 );
			#endif
			half MotionScale60_g119 = _MotionScale3;
			half MotionSpeed62_g119 = ( PWD_GlobalSpeed * _MotionSpeed3 );
			half MotionlAmplitude58_g119 = ( PWD_GlobalAmplitude * _MotionAmplitude3 );
			float temp_output_7_0_g108 = _MotionMaskMin2;
			half MotionMask137_g119 = ( ( v.texcoord.w - temp_output_7_0_g108 ) / ( _MotionMaskMax2 - temp_output_7_0_g108 ) );
			half3 MotionDirection378_g119 = _MotionDirection3;
			half3 Motion_Local1213 = ( ( ( sin( ( ( v.texcoord3.xyz * MotionScale60_g119 ) + ( MotionSpeed62_g119 * _Time.y ) ) ) * MotionlAmplitude58_g119 ) * MotionMask137_g119 ) * MotionDirection378_g119 );
			#ifdef _MOTION3_ON
				float3 staticSwitch980 = Motion_Local1213;
			#else
				float3 staticSwitch980 = float3( 0,0,0 );
			#endif
			half3 Motion1223 = ( ( staticSwitch979 + staticSwitch980 ) * (0.2 + (sin( ( PWD_GlobalTurbulenceSpeed * _Time.y ) ) - -1.0) * (1.0 - 0.2) / (1.0 - -1.0)) );
			v.vertex.xyz += Motion1223;
		}

		void surf( Input i , inout SurfaceOutput o )
		{
			o.Normal = half3(0,0,1);
			half4 ColorModeOptions986 = _ColorModeOptions;
			half4 Color_Vertex1005 = ( (ColorModeOptions986).x * i.vertexColor );
			half4 Color_Simple1006 = ( (ColorModeOptions986).y * _BaseColor );
			float temp_output_7_0_g94 = _GradientPosMax;
			float4 lerpResult1000 = lerp( _GradientColorMax , _GradientColorMin , saturate( ( ( i.uv4_tex4coord4.w - temp_output_7_0_g94 ) / ( _GradientPosMin - temp_output_7_0_g94 ) ) ));
			half4 Color_Gradient1007 = ( (ColorModeOptions986).z * lerpResult1000 );
			float4 Color1018 = ( Color_Vertex1005 + Color_Simple1006 + Color_Gradient1007 );
			float4 tex2DNode950 = tex2D( _BaseMap, ( ( i.uv_texcoord * (_BaseMapUVs).xy ) + (_BaseMapUVs).zw ) );
			half4 BaseMap1030 = tex2DNode950;
			float4 temp_output_1378_0 = ( Color1018 * BaseMap1030 );
			o.Albedo = temp_output_1378_0.rgb;
			half temp_output_958_0 = _Smoothness;
			o.Specular = temp_output_958_0;
			o.Gloss = temp_output_958_0;
			float temp_output_1381_0 = (temp_output_1378_0).a;
			o.Alpha = temp_output_1381_0;
			half Alpha5_g123 = temp_output_1381_0;
			#ifdef _ALPHATEST_ON
				float staticSwitch2_g123 = Alpha5_g123;
			#else
				float staticSwitch2_g123 = 1.0;
			#endif
			clip( staticSwitch2_g123 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Standard"
	CustomEditor "PolyversePropsShaderGUI"
}
/*ASEBEGIN
Version=17101
1927;29;1906;1014;3923.119;6635.339;1;True;False
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1029;-3328,-5120;Inherit;False;3;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector4Node;976;-3328,-5504;Half;False;Property;_ColorModeOptions;_ColorModeOptions;55;1;[HideInInspector];Create;False;0;0;True;0;0,0,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;947;-3328,-4864;Inherit;False;Property;_GradientPosMin;Position Min;20;0;Create;False;0;0;True;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;946;-3328,-4944;Inherit;False;Property;_GradientPosMax;Position Max;21;0;Create;False;0;0;True;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;986;-3072,-5504;Half;False;ColorModeOptions;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;999;-3008,-5120;Inherit;False;Remap To 0-1;-1;;94;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1009;-2688,-5120;Inherit;False;986;ColorModeOptions;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.GetLocalVarNode;989;-1664,-5504;Inherit;False;986;ColorModeOptions;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SaturateNode;1004;-2688,-4992;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;945;-2688,-4864;Inherit;False;Property;_GradientColorMin;Gradient Min;18;2;[HDR];[Gamma];Create;False;0;0;True;1;Space(10);0.1193772,0.3307571,0.5073529,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;944;-2688,-4688;Inherit;False;Property;_GradientColorMax;Gradient Max;19;2;[HDR];[Gamma];Create;False;0;0;True;0;0.4510705,0.592594,0.7573529,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.GetLocalVarNode;987;-2688,-5504;Inherit;False;986;ColorModeOptions;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;1041;-3328,-3008;Half;False;Property;_MotionMaskMin;Global Mask Min;35;0;Create;False;0;0;False;1;Space(10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1431;-1920,-3008;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;1000;-2368,-4992;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.VertexColorNode;985;-2688,-5376;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;1010;-2368,-5120;Inherit;False;FLOAT;2;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1043;-3328,-2928;Half;False;Property;_MotionMaskMax;Global Mask Max;36;0;Create;False;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1211;-1920,-2736;Half;False;Property;_MotionMaskMax2;Detail Mask Max;45;0;Create;False;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;988;-2432,-5504;Inherit;False;FLOAT;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1430;-3328,-3200;Inherit;False;0;4;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1210;-1920,-2816;Half;False;Property;_MotionMaskMin2;Detail Mask Min;44;0;Create;False;0;0;False;1;Space(10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;942;-1664,-5376;Half;False;Property;_BaseColor;Color;16;2;[HDR];[Gamma];Create;False;0;0;True;1;Space(10);1,1,1,1;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SwizzleNode;990;-1408,-5504;Inherit;False;FLOAT;1;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.Vector4Node;1302;-3328,-3968;Inherit;False;Property;_BaseMapUVs;Base Map UVs;24;0;Create;True;0;0;True;0;1,1,0,0;0,0,0,0;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;991;-1216,-5504;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1209;-1920,-3104;Half;False;Property;_MotionScale3;Detail Scale;43;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1208;-1920,-3184;Half;False;Property;_MotionSpeed3;Detail Speed;42;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1037;-3072,-3200;Inherit;False;Remap To 0-1;-1;;107;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;FLOAT;0;False;7;FLOAT;-0.5;False;8;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1204;-1664,-3008;Inherit;False;Remap To 0-1;-1;;108;5eda8a2bb94ebef4ab0e43d19291cd8b;0;3;6;FLOAT;0;False;7;FLOAT;-0.5;False;8;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;984;-2240,-5504;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;1039;-3328,-3376;Half;False;Property;_MotionSpeed;Global Speed;33;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;1406;-1920,-3456;Inherit;False;Property;_MotionDirection3;Detail Direction;40;0;Create;False;0;0;False;1;Space(10);1,1,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SwizzleNode;1304;-3120,-3968;Inherit;False;FLOAT2;0;1;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;1207;-1920,-3264;Half;False;Property;_MotionAmplitude3;Detail Amplitude;41;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1038;-3328,-3456;Half;False;Property;_MotionAmplitude;Global Amplitude;32;0;Create;False;0;0;False;1;Space(10);0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1011;-2176,-5120;Inherit;False;2;2;0;FLOAT;0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TexCoordVertexDataNode;1308;-3328,-4096;Inherit;False;0;2;0;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;1040;-3328,-3296;Half;False;Property;_MotionScale;Global Scale;34;0;Create;False;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SwizzleNode;1305;-3120,-3888;Inherit;False;FLOAT2;2;3;2;3;1;0;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.FunctionNode;1441;-2816,-3456;Inherit;False;Motion Global;-1;;116;aa2bbd9ab2501e541b3ea36a3d58db55;0;4;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1442;-1408,-3456;Inherit;False;Motion Detail;-1;;119;3e4fddca44b7c8f4b95935de41d7cc37;0;5;377;FLOAT3;1,1,1;False;220;FLOAT;0;False;221;FLOAT;0;False;222;FLOAT;0;False;136;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1005;-2048,-5504;Half;False;Color_Vertex;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1307;-2944,-4096;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1007;-2048,-5120;Half;False;Color_Gradient;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1006;-1024,-5504;Half;False;Color_Simple;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1306;-2800,-4096;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1212;-2560,-3456;Half;False;Motion_Global;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1213;-1152,-3456;Half;False;Motion_Local;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;1016;-1664,-5040;Inherit;False;1006;Color_Simple;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1017;-1664,-4960;Inherit;False;1007;Color_Gradient;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1015;-1664,-5120;Inherit;False;1005;Color_Vertex;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1217;-3328,-2432;Inherit;False;1213;Motion_Local;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;950;-2560,-4096;Inherit;True;Property;_BaseMap;Base Map;23;1;[NoScaleOffset];Create;True;0;0;True;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;1014;-1344,-5120;Inherit;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1216;-3328,-2560;Inherit;False;1212;Motion_Global;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1018;-1152,-5120;Float;False;Color;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1030;-2240,-4096;Half;False;BaseMap;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;980;-3072,-2432;Inherit;False;Property;_Motion3;Enable Local Motion;38;0;Create;False;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StaticSwitch;979;-3072,-2560;Inherit;False;Property;_Motion;Enable Global Motion;30;0;Create;False;0;0;True;0;0;0;0;True;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT3;0,0,0;False;0;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT3;0,0,0;False;5;FLOAT3;0,0,0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.FunctionNode;1443;-3072,-2304;Inherit;False;Motion Turbulence;-1;;121;2f6547f00407fe64b91ecaadbda1f644;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1379;-1536,-7808;Inherit;False;1030;BaseMap;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;1023;-1536,-7936;Inherit;False;1018;Color;1;0;OBJECT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;1218;-2768,-2560;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1378;-1280,-7936;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;1427;-2624,-2560;Inherit;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1223;-2432,-2560;Half;False;Motion;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SwizzleNode;1381;-1088,-7808;Inherit;False;FLOAT;3;1;2;3;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1402;-2672,-7168;Half;False;Property;_Mode;_Mode;53;1;[HideInInspector];Create;False;0;0;True;0;-1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1400;-2816,-7168;Half;False;Property;__mode;__mode;54;1;[HideInInspector];Create;False;0;0;True;0;-1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;1316;-3328,-7168;Inherit;True;Property;_MainTex;_MainTex;52;1;[HideInInspector];Create;False;0;0;True;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;971;-3328,-6304;Half;False;Property;_AlphaClipping_On;# AlphaClipping_On;11;0;Create;True;0;0;True;1;BInteractive(__clip, 1);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;960;-3328,-6208;Half;False;Property;_ColorMode_Color;# ColorMode_Color;15;0;Create;True;0;0;True;1;BInteractive(_ColorMode, 1);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1438;-2848,-7840;Float;False;Property;_QueueOffset;Priority;47;1;[IntRange];Create;False;0;0;True;0;0;0;-50;50;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;938;-3328,-7744;Half;False;Property;_Cutoff;Alpha Treshold;12;0;Create;False;4;Alpha;0;Premultiply;1;Additive;2;Multiply;3;0;True;0;0.5;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;943;-2656,-6784;Half;False;Property;_SurfaceMapCat;[ Surface Map Cat ];22;0;Create;True;0;0;True;1;BCategory(Surface Map);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;964;-3328,-7840;Half;False;Property;__src;__src;48;1;[HideInInspector];Create;False;0;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;890;-3328,-7424;Half;False;Property;_IsPolyversePropsShader;_IsPolyversePropsShader;0;1;[HideInInspector];Create;False;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;899;-3152,-6784;Half;False;Property;_SurfaceOptionsCat;[ Surface Options Cat ];4;0;Create;True;0;0;True;1;BCategory(Surface Options);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;965;-3168,-7840;Half;False;Property;__dst;__dst;49;1;[HideInInspector];Create;False;2;Opaque;0;Transparent;1;0;True;0;10;10;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;963;-3024,-6400;Half;False;Property;_RenderMode_Reset;# RenderMode_Reset;9;0;Create;True;0;0;True;1;BInteractive(ON);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1433;-3088,-6128;Half;False;Property;_LocalMotion_On;# LocalMotion_On;39;0;Create;True;0;0;True;1;BInteractive(_Motion3, 1);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1032;-3072,-6688;Half;False;Property;_MotionGlobalCat;[ Motion Global Cat];29;0;Create;True;0;0;True;1;BCategory(Global Motion);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1369;-3024,-7168;Half;False;Property;_Color;_Color;51;1;[HideInInspector];Create;False;0;0;True;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;952;-3328,-6688;Half;False;Property;_SurfaceShadingCat;[ Surface Shading Cat ];25;0;Create;True;0;0;True;1;BCategory(Surface Shading);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;961;-3088,-6208;Half;False;Property;_ColorMode_Gradient;# ColorMode_Gradient;17;0;Create;True;0;0;True;1;BInteractive(_ColorMode, 2);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;962;-3328,-6400;Half;False;Property;_RenderMode_Transparent;# RenderMode_Transparent;7;0;Create;True;0;0;True;1;BInteractive(__surface, 1);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;941;-3323.243,-5319.478;Half;False;Property;_ColorMode;Color Mode;14;1;[Enum];Create;True;3;Vertex;0;Color;1;Gradient;2;0;True;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;933;-3056,-7424;Half;False;Property;_IsStandardPipeline;_IsStandardPipeline;1;1;[HideInInspector];Create;False;0;0;True;0;1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;1440;-896,-7680;Inherit;False;Handle Alpha Clipping;-1;;123;7a90709e4edf45d4c95e6c32508f386d;0;2;3;FLOAT;0;False;4;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1399;-2816,-7424;Half;False;Property;_IsInitialized;_IsInitialized;2;1;[HideInInspector];Create;False;0;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1020;-2560,-7936;Inherit;False;Property;_ALPHAPREMULTIPLY;_ALPHAPREMULTIPLY;42;0;Create;True;0;0;True;0;0;0;0;False;;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1034;-2608,-6688;Half;False;Property;_AdvancedCat;[ Advanced Cat];46;0;Create;True;0;0;True;1;BCategory(Advanced);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1388;-2228.203,-3995.539;Half;False;myVarName;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;1033;-2832,-6688;Half;False;Property;_MotionDetailCat;[ Motion Detail Cat];37;0;Create;True;0;0;True;1;BCategory(Detail Motion);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;966;-3008,-7840;Half;False;Property;__zw;__zw;50;1;[HideInInspector];Create;False;2;Opaque;0;Transparent;1;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;923;-3328,-6784;Half;False;Property;_TITLE;< TITLE >;3;0;Create;True;0;0;True;1;BBanner(Polyverse Props, Simple Lit);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;1437;-3040,-7744;Half;False;AlphaTreshold;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;934;-3328,-7936;Half;False;Property;__surface;Render Mode;5;1;[Enum];Create;False;2;Opaque;0;Transparent;1;0;True;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;1019;-2560,-7840;Inherit;False;Property;_ALPHATEST;_ALPHATEST;35;0;Create;True;0;0;True;0;0;0;0;False;_ALPHATEST_ON;Toggle;2;Key0;Key1;Create;False;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;937;-2752,-7936;Half;False;Property;__clip;Alpha Clipping;10;1;[Toggle];Create;False;4;Alpha;0;Premultiply;1;Additive;2;Multiply;3;0;True;1;Space(10);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;936;-2944,-7936;Half;False;Property;__blend;Blending Mode;8;1;[Enum];Create;False;4;Alpha;0;Premultiply;1;Additive;2;Multiply;3;0;True;1;Space(10);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;939;-2896,-6784;Half;False;Property;_SurfaceColorCat;[ Surface Color Cat ];13;0;Create;True;0;0;True;1;BCategory(Surface Color);1;1;1;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.Vector3Node;1403;-512,-7872;Half;False;Constant;_Vector0;Vector 0;53;0;Create;True;0;0;False;0;0,0,1;0,0,0;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;1031;-896,-7552;Half;False;Property;_Metallic;Metallic;27;0;Create;True;0;0;False;0;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;1164;-464,-7296;Inherit;False;1223;Motion;1;0;OBJECT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.RangedFloatNode;935;-3136,-7936;Half;False;Property;__cull;Render Faces;6;1;[Enum];Create;False;3;Both;0;Back;1;Front;2;0;True;0;2;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;958;-896,-7456;Half;False;Property;_Smoothness;Smoothness;28;0;Create;True;0;0;True;0;0.5;0;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;972;-3328,-6128;Half;False;Property;_GlobalMotion_On;# GlobalMotion_On;31;0;Create;True;0;0;True;1;BInteractive(_Motion, 1);0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;949;-256,-7936;Float;False;True;2;PolyversePropsShaderGUI;300;0;BlinnPhong;BOXOPHOBIC/Polyverse Props/Simple Lit;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;Back;0;True;966;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0;True;True;0;True;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;1;1;True;964;10;True;965;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;300;Standard;-1;-1;-1;-1;0;False;0;0;True;935;26;0;True;938;0;0;0;False;0.1;False;-1;0;False;-1;15;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.CommentaryNode;968;-3328,-7552;Inherit;False;1025.136;100;Internal;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1401;-3328,-7296;Inherit;False;1025.136;100;Unity Props;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1398;-1536,-8064;Inherit;False;1535.341;100;Final;0;;0.737931,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1310;-3328,-3584;Inherit;False;2565.344;100;Motion;0;;0,1,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;969;-3328,-8064;Inherit;False;1027.226;100;Surface Options;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;612;-3328,-5632;Inherit;False;2560.739;100;Color;0;;0,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;967;-3328,-6912;Inherit;False;1025.473;100;Drawers;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;970;-3328,-6528;Inherit;False;1022.473;100;Interactive;0;;1,0.252,0,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;1028;-3328,-4224;Inherit;False;1282.554;100;Texture;0;;1,0.6827586,0,1;0;0
WireConnection;986;0;976;0
WireConnection;999;6;1029;4
WireConnection;999;7;946;0
WireConnection;999;8;947;0
WireConnection;1004;0;999;0
WireConnection;1000;0;944;0
WireConnection;1000;1;945;0
WireConnection;1000;2;1004;0
WireConnection;1010;0;1009;0
WireConnection;988;0;987;0
WireConnection;990;0;989;0
WireConnection;991;0;990;0
WireConnection;991;1;942;0
WireConnection;1037;6;1430;3
WireConnection;1037;7;1041;0
WireConnection;1037;8;1043;0
WireConnection;1204;6;1431;4
WireConnection;1204;7;1210;0
WireConnection;1204;8;1211;0
WireConnection;984;0;988;0
WireConnection;984;1;985;0
WireConnection;1304;0;1302;0
WireConnection;1011;0;1010;0
WireConnection;1011;1;1000;0
WireConnection;1305;0;1302;0
WireConnection;1441;220;1038;0
WireConnection;1441;221;1039;0
WireConnection;1441;222;1040;0
WireConnection;1441;136;1037;0
WireConnection;1442;377;1406;0
WireConnection;1442;220;1207;0
WireConnection;1442;221;1208;0
WireConnection;1442;222;1209;0
WireConnection;1442;136;1204;0
WireConnection;1005;0;984;0
WireConnection;1307;0;1308;0
WireConnection;1307;1;1304;0
WireConnection;1007;0;1011;0
WireConnection;1006;0;991;0
WireConnection;1306;0;1307;0
WireConnection;1306;1;1305;0
WireConnection;1212;0;1441;0
WireConnection;1213;0;1442;0
WireConnection;950;1;1306;0
WireConnection;1014;0;1015;0
WireConnection;1014;1;1016;0
WireConnection;1014;2;1017;0
WireConnection;1018;0;1014;0
WireConnection;1030;0;950;0
WireConnection;980;0;1217;0
WireConnection;979;0;1216;0
WireConnection;1218;0;979;0
WireConnection;1218;1;980;0
WireConnection;1378;0;1023;0
WireConnection;1378;1;1379;0
WireConnection;1427;0;1218;0
WireConnection;1427;1;1443;0
WireConnection;1223;0;1427;0
WireConnection;1381;0;1378;0
WireConnection;1440;3;1381;0
WireConnection;1388;0;950;4
WireConnection;1437;0;938;0
WireConnection;949;0;1378;0
WireConnection;949;1;1403;0
WireConnection;949;3;958;0
WireConnection;949;4;958;0
WireConnection;949;9;1381;0
WireConnection;949;10;1440;0
WireConnection;949;11;1164;0
ASEEND*/
//CHKSM=6C374481B393C30B7D5398FEA1C8A666D50FD78A