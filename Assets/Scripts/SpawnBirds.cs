using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SpawnBirds : MonoBehaviour
{
    public GameObject bird;
    public GameObject player;
    public Vector3 playerLoc;
    private Vector3 offset;
    public float interval = 3;

    private void Start()
    {
        offset = new Vector3(25, 6, 0);
        player = GameObject.FindGameObjectWithTag("Player");
        StartCoroutine(SpawnBird(interval));
    }

    IEnumerator SpawnBird(float interval)
    {
        while (true) { 
        yield return new WaitForSeconds(interval);
        playerLoc = player.transform.position;
        Instantiate(bird, playerLoc + offset, transform.rotation);
        }

    }
}
