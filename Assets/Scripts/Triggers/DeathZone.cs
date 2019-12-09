using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class DeathZone : MonoBehaviour
{
    GameObject player;

    

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
       
    }

    private void OnTriggerEnter(Collider col)
    {
        if (col.CompareTag("Player"))
        {
                FindObjectOfType<GameManager>().EndGame();
  
        }

    }
}
