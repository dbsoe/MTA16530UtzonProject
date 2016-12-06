using UnityEngine;



public class DisplayWebCam : MonoBehaviour
{
    
    void Start ()
    {
       WebCamDevice[] devices = WebCamTexture.devices;


	Renderer rend = GetComponent<Renderer>();
	rend.material.shader = Shader.Find("Projector/Light");
//	Debug.Log(rend.material.GetFloat("_DeltaX"));


        // assuming the first available WebCam is desired
        WebCamTexture tex = new WebCamTexture(devices[0].name);
//	rend.material.mainTexture = tex;
	rend.material.SetTexture("_ShadowTex", tex);
        tex.Play();
    }
}
