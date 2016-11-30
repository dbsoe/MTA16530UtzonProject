using UnityEngine;
using System.Collections;
using UnityEngine.EventSystems;
using UnityEngine.UI;

		    public class PanoramaHandler : MonoBehaviour{

		      public int panoramaShown = 1;

		      public GameObject Pan1;
		      public GameObject Pan2;
		      public GameObject Pan3;
		      public GameObject Pan4;
		      public GameObject Pan5;
		      public GameObject Pan6;

		      public void Start(){
			updatePanorama();
		      }

		      public void updatePanorama(){
			for(int i = 0; i < this.transform.childCount; i++){
			  GameObject child = this.transform.GetChild(i).gameObject;
			  if(i+1 != panoramaShown){
			    child.SetActive(false);
			  } else {
			    child.SetActive(true);
			  }
			}
		      }

		      public void onClick(int userInput){
			panoramaShown = userInput;
			updatePanorama();
		      }
		      
		    }
