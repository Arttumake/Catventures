using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FinishLineTrig : MonoBehaviour
{
    public GameObject player;



    // Edit startingPos depending on starting position of player object in map
    // You need a object with a trigger collider + this script attached to it


    private void OnTriggerEnter(Collider other)
    {
        if (other.gameObject == player)
        {

            FindObjectOfType<GameManager>().LevelComplete();
            SaveSystem.DeleteSave();

        }
    }

}
