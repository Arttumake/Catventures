using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class EndGame : MonoBehaviour
{
    // create child object for player and attach this script to it, drag player rigidbody to rb variable.
    // endGameHeight and endGameZaxis need adjusting depending on map

    public Rigidbody rb;
    
    public float endGameHeight = - 30f;
    public float endGameYaxis = - 5f;

 

    void FixedUpdate()
    {
        if (rb.position.y < endGameHeight || rb.position.y < endGameYaxis)
        {
            
            FindObjectOfType<GameManager>().EndGame();
            Debug.Log("Se o loppu ny");
        }

    }
}
