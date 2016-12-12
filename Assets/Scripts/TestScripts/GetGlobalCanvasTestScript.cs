using UnityEngine;
using System.Collections;

public class GetGlobalCanvasTestScript : MonoBehaviour {

    public GameObject Obj1Canvas;
    public Vector3 Obj1Coord;
    
    public GameObject Obj2Canvas;
    public Vector3 Obj2Coord;
    
    public GameObject Obj1Table;
    public GameObject Obj2Table;

    public float TableDist;
    public float CanvasDist;
    public float FracDist;
    public Vector3 LerpFuncMax;

    public Vector3 WorldSpaceCoord;
    
	// Use this for initialization
	void Start () {
	}
	
	// Update is called once per frame
	void Update () {

	    Obj1Coord = Obj1Canvas.transform.position;
	    Obj2Coord = Obj2Canvas.transform.position;
	    
	    CanvasDist = Vector3.Distance(Obj1Canvas.transform.position, Obj2Canvas.transform.position);
	    TableDist = Vector3.Distance(Obj1Table.transform.position, Obj2Table.transform.position);
	    FracDist = TableDist / CanvasDist;

	    LerpFuncMax = Vector3.Lerp(Obj2Canvas.transform.position, Obj2Table.transform.position, FracDist);
	    
	
	}
}
