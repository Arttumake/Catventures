using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class OnHit : MonoBehaviour
{
    
    
    private void Start()
    {
        
        if (gameObject.activeSelf == true)
        {
            Invoke("DeleteObject", 4f);
        }
    }
    private void OnTriggerEnter(Collider col)
    {
        if (col.gameObject.tag == ("Player"))
        {
            FindObjectOfType<PlayerPosition>().health--;
            FindObjectOfType<PlayerPosition>().UpdateHealth();
            Destroy(gameObject);
        }
    }

    public void DeleteObject()
    {
        Destroy(gameObject);
    }
}
