using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AirLiftTrigger : MonoBehaviour
{
    // requires a gameobject with a trigger collider attached to it (where you want the upwards wind to affect player)

    public Rigidbody rb;
    public float liftMulti = 1.0f;

 

    void OnTriggerEnter(Collider col)
    {
        
        if (col.gameObject.tag == ("Player"))
        {
            FindObjectOfType<PlayerMovement>().isFallMultiActive = false;
            rb.AddForce(Vector3.up, ForceMode.VelocityChange);

        }
    }

    void OnTriggerStay(Collider col)
    {
        if (col.gameObject.tag == ("Player"))
        {
            rb.AddForce(Vector3.up * liftMulti, ForceMode.Force);


        }
    }

    void OnTriggerExit(Collider col)
    {
        if (col.gameObject.tag == ("Player"))
        {
            FindObjectOfType<PlayerMovement>().isFallMultiActive = true;
            

        }

    }
}
