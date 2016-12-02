using UnityEngine;
using System.Collections;
using UnityEngine.EventSystems;
using UnityEngine.UI;

		    public class ButtonInput : MonoBehaviour, IDragHandler, IEndDragHandler
		    {

		      
		      public GameObject Button1;
		      public GameObject Button2;
		      public GameObject Button3;
		      public GameObject Button4;
		      public GameObject Button5;
		      public GameObject Button6;

		      public GameObject Spheres;

		      public float Dist1;
		      public float Dist2;
		      public float Dist3;
		      public float Dist4;
		      public float Dist5;
		      public float Dist6;

		      public void OnDrag(PointerEventData data){
  			transform.position = data.position;
		      }

		      public void OnEndDrag(PointerEventData eventData){
			Dist1 = DistanceCalc(gameObject.transform.position.x, gameObject.transform.position.y,
					     Button1.transform.position.x, Button1.transform.position.y);
			Dist2 = DistanceCalc(gameObject.transform.position.x, gameObject.transform.position.y,
					     Button2.transform.position.x, Button2.transform.position.y);
			Dist3 = DistanceCalc(gameObject.transform.position.x, gameObject.transform.position.y,
					     Button3.transform.position.x, Button3.transform.position.y);
			Dist4 = DistanceCalc(gameObject.transform.position.x, gameObject.transform.position.y,
					     Button4.transform.position.x, Button4.transform.position.y);
			Dist5 = DistanceCalc(gameObject.transform.position.x, gameObject.transform.position.y,
					     Button5.transform.position.x, Button5.transform.position.y);
			Dist6 = DistanceCalc(gameObject.transform.position.x, gameObject.transform.position.y,
					     Button6.transform.position.x, Button6.transform.position.y);

			if(Dist1 <= 30){
			  Spheres.GetComponent<PanoramaHandler>().onClick(1);
			}
			if(Dist2 <= 30){
			  Spheres.GetComponent<PanoramaHandler>().onClick(2);
			}
			if(Dist3 <= 30){
			  Spheres.GetComponent<PanoramaHandler>().onClick(3);
			}
			if(Dist4 <= 30){
			  Spheres.GetComponent<PanoramaHandler>().onClick(4);
			}
			if(Dist5 <= 30){
			  Spheres.GetComponent<PanoramaHandler>().onClick(5);
			}
			if(Dist6 <= 30){
			  Spheres.GetComponent<PanoramaHandler>().onClick(6);
			}
			  }

		      public float DistanceCalc(float x1, float y1, float x2, float y2){
			
			float dist;

			dist = Mathf.Sqrt((Mathf.Pow(x2 - x1, 2))+(Mathf.Pow(y2 - y1, 2)));

			return dist;
		      }
		    }
