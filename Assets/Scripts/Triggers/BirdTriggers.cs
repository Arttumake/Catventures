using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BirdTriggers : MonoBehaviour
{
    public GameObject bird;
    public GameObject poop;
    public Vector3 spawnpoint;
    

    // Start is called before the first frame update
    void Start()
    {
        bird = gameObject.transform.parent.gameObject;
        
    }

    private void OnTriggerEnter(Collider col)
    {
        if (col.gameObject.tag == ("Player"))
        {
            spawnpoint = bird.transform.position;
            Instantiate(poop, spawnpoint, transform.rotation);
            
            
        }
    }


}
