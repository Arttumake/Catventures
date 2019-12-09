using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FeetCollision : MonoBehaviour
{ 

    // 1. Make empty child object for player, then attach this script to the child object
    // 2. Create a box collider for the object this is attached to
    // 3. Set "is trigger" and set them to resemble feet for the player
    // 4. Make sure objects player lands on are tagged "Ground"

    public GameObject player;

    
    void Start()
    {
        player = gameObject.transform.parent.gameObject;
        
    }

    void OnTriggerEnter(Collider col)
    {
        if (col.gameObject.tag == ("Ground"))
        {
            player.GetComponent<PlayerMovement>().isJumping = false;
            player.GetComponent<PlayerMovement>().isGrounded = true;
            player.GetComponent<PlayerMovement>().jumpNumber = 0;
            player.GetComponent<PlayerMovement>().dashNumber = 0;
            //player.GetComponent<Rigidbody>().velocity = Vector3.zero;
        }
    }

    void OnTriggerExit(Collider col)
    {
        if (col.gameObject.tag == ("Ground"))
        {

            player.GetComponent<PlayerMovement>().isGrounded = false;
            
        }
    }


}
