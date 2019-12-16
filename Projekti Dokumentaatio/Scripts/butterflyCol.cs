using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class butterflyCol : MonoBehaviour
{
    public Text butterflies;

 

    private void OnTriggerEnter(Collider col)
    {
        if (col.gameObject.tag == ("Player"))
        {

            if (FindObjectOfType<PlayerPosition>().health < 3) { 
            FindObjectOfType<PlayerPosition>().health++;
            }
            FindObjectOfType<PlayerPosition>().UpdateHealth();
            Destroy(gameObject);


        }
    }
}
