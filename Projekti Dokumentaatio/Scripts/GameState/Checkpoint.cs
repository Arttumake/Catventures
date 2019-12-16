using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Checkpoint : MonoBehaviour
{
    private CPManager cp;

    private void Start()
    {
        cp = GameObject.FindGameObjectWithTag("CPM").GetComponent<CPManager>();
    }


    private void OnTriggerEnter(Collider other)
    {
        if (other.CompareTag("Player"))
        {
            cp.lastCheckPointPos = transform.position;
            //FindObjectOfType<GameManager>().CheckPointReached();
            PlayerPrefs.SetFloat("PlayerX", cp.lastCheckPointPos.x);
            PlayerPrefs.SetFloat("PlayerY", cp.lastCheckPointPos.y);
            PlayerPrefs.SetFloat("PlayerZ", cp.lastCheckPointPos.z);
        }
    }
}
