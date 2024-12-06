// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Solid" {
    Properties {
        _MainColor ("Color", Color) = (1,1,1,1)
        _LightSource ("LightSource", Vector) = (2,2,2,1)
    }
    SubShader {
        Tags { "LightMode" = "ForwardBase" }
        Pass {
            CGPROGRAM
            #include "UnityCG.cginc"

            struct gl_VertOutput
            {
                float4 gl_Position: SV_POSITION;
                float gl_X : FLOAT;
            };

            struct gl_FragOutput
            {
                fixed4 gl_Color: SV_Target;
            };

            #pragma vertex vert
            #pragma fragment frag


            fixed4 _MainColor;
            float4 _LightSource;

            gl_VertOutput vert(float4 v:POSITION)  {
                float3 l = float3(0,0,0);
                gl_VertOutput OUT;
                float4 a = UnityObjectToClipPos(v);
                float3 b = UnityObjectToViewPos(v);
                OUT.gl_Position = a;
                OUT.gl_X = 1./(0.1+b.z*b.z);//1./sqrt(0.2+(v.x-l.x)*(v.x-l.x)+(v.y-l.y)*(v.y-l.y)+(v.z-l.z)*(v.z-l.z));
                return OUT;// float4(a.x,a.y,a.z,a.a);
            }

            gl_FragOutput frag(gl_VertOutput IN) {
                gl_FragOutput OUT;
                OUT.gl_Color = _MainColor * IN.gl_X;
                return OUT;
            }

            ENDCG
        }
    }
}