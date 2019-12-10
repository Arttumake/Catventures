using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SidewaysWind : MonoBehaviour
{
    public Rigidbody rb;
    public BoxCollider windTrigger;
    public float windMulti = 8.0f;
    public GameObject sidewaysWind;
    public GameObject windBlower;
    public bool onOff = true;
    public float windCooldown = 1.0f;


    private void Start()
    {
        windBlower = transform.parent.gameObject;
        StartCoroutine(WindOnOff()); // keeps the wind turning on/off
        
    }

    void OnTriggerStay(Collider col)
    {
        if (col.gameObject.tag == ("Player"))
        {
            rb.AddForce(Vector3.back * windMulti, ForceMode.Force);


        }
    }

    IEnumerator WindOnOff()
    {
        while (true)
        {
            
            if (onOff == true)
            {
                onOff = false;
                windTrigger.enabled = true;               
                windBlower.GetComponent<Renderer>().material.color = Color.red; // comment this line if no material used for windblower
                yield return new WaitForSeconds(windCooldown);

            }
            else
            {
                onOff = true;

                windTrigger.enabled = false;
                windBlower.GetComponent<Renderer>().material.color = Color.green; // comment this line if no material used for windblower
                yield return new WaitForSeconds(windCooldown);
            }
        }
    }

}

