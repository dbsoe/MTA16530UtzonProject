using UnityEngine;

public class WebCamFeedScript : MonoBehaviour
{

    public Material material;
    
    void Start ()
    {
       WebCamDevice[] devices = WebCamTexture.devices;

       Renderer rend = this.GetComponentInChildren<Renderer>();

       // assuming the first available WebCam is desired
       WebCamTexture tex = new WebCamTexture(devices[0].name);
       rend.material.mainTexture = tex;

       material.mainTexture = tex;
       
       tex.Play();
    }

}
