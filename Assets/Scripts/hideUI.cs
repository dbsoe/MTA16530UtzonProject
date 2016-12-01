using UnityEngine;
using System.Collections;

public class hideUI : MonoBehaviour
{
	SteamVR_TrackedObject trackedObj;
	public GameObject Canvas;
	public bool active = true;

	void Awake ()
	{
		trackedObj = GetComponent<SteamVR_TrackedObject> ();
	
	}
	
	// Update is called once per frame
	void Update ()
	{
		var device = SteamVR_Controller.Input ((int)trackedObj.index);
		if (device.GetTouchDown (SteamVR_Controller.ButtonMask.ApplicationMenu)) {
			Debug.Log ("Touchdown");
			Canvas.SetActive (!active);
			active = !active;
		} 
	}
}