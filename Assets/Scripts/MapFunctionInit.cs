using UnityEngine;
using System.Collections;

public class MapFunctionInit : MonoBehaviour {

    public GameObject CanvasMin;
    public GameObject CanvasMax;
    public GameObject TableMin;
    public GameObject TableMax;
    public GameObject RemapObject;
    public GameObject ObjectToBeRemapped;

    public Vector3 MappedFromP1;
    public Vector3 MappedFromP2;
    public Vector3 MappedToP1;
    public Vector3 MappedToP2;
    public Vector3 CurrentPos;

    public Vector3 MappedToVal;
        
	// Use this for initialization
	void Start () {


	    MappedToP1 = TableMin.transform.localPosition;
	    MappedToP2 = TableMax.transform.localPosition;
	    
	    
	}
	
	// Update is called once per frame
	void Update () {

	    MappedFromP1 = CanvasMin.transform.position;
	    MappedFromP2 = CanvasMax.transform.position;

	    CurrentPos = RemapObject.transform.position;
	    
	    MappedToVal.x = map(CurrentPos.x, MappedFromP1.x, MappedFromP2.x, MappedToP1.x, MappedToP2.x);
	    MappedToVal.y = map(CurrentPos.y, MappedFromP1.y, MappedFromP2.y, MappedToP1.z, MappedToP2.z);

	    ObjectToBeRemapped.transform.localPosition = new Vector3(MappedToVal.y/2,0.05f,MappedToVal.x*2);

	    
	}

    float map(float pos, float oldMin, float oldMax, float newMin, float newMax){
	return Mathf.Lerp(newMin, newMax, Mathf.InverseLerp(oldMin, oldMax, pos));
    }
}
