using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{

    // Player movement script, attach this to the player object and tag the player as "Player"

    public Rigidbody rb;
    public float movementSpeed = 8f;
    public float airmovementSpeed = 6f;
    public bool isGrounded;

    public float jumpForce = 7;
    public int jumpLimit = 2;
    public int jumpNumber = 0;
    public float speedLimit = 18f;
    public float playerMoveLimit = 10f;

    public float dashDuration = 0.2f; 
    public float dashForce = 12;
    public int dashLimit = 1;
    public int dashNumber = 0;

    public Animator anim;
    public bool isJumping = false;
    public float fallMultiplier = 2.8f; // increases gravity pull after player starts falling down
    public bool isFallMultiActive = true;
    private float moveHorizontal;

    private void Start()
    {
        rb = GetComponent<Rigidbody>();
        anim = GetComponent<Animator>();
    }

    private void Update()
    {

        anim.SetFloat("xMove", moveHorizontal); 

        if (Input.GetButtonDown("Jump") && isGrounded || Input.GetButtonDown("Jump") && jumpNumber < jumpLimit)
        {
            jumpNumber++;
            rb.velocity = Vector2.up * jumpForce;
            
            anim.SetBool("isJumping", true);
           // rb.velocity = new Vector3(rb.velocity.x, jumpForce, 0);
        }



        if (Input.GetButtonDown("Fire3") && dashNumber < dashLimit && !isGrounded)
        {
            Dash();
        }




    }

    private void FixedUpdate()
    {

        // grounded movement
        if (isGrounded && rb.velocity.magnitude < playerMoveLimit)
        {
            isJumping = false;
            anim.SetBool("isJumping", false);
            moveHorizontal = Input.GetAxis("Horizontal");
            
            rb.velocity = new Vector3(moveHorizontal * movementSpeed, rb.velocity.y);
            
        }

        // airborne movement

        if (!isGrounded && rb.velocity.magnitude < playerMoveLimit && rb.velocity.magnitude > 1)
        {

            moveHorizontal = Input.GetAxis("Horizontal");
            rb.velocity = new Vector3(moveHorizontal * airmovementSpeed, rb.velocity.y);
            anim.SetBool("isJumping", true);

        }

        // speeds up falling so it doesnt feel like youre on the moon

        if (rb.velocity.y <= 0 && rb.velocity.magnitude < speedLimit && isFallMultiActive)
        {
            rb.velocity += Vector3.up * Physics.gravity.y * (fallMultiplier - 1) * Time.deltaTime;

        }


        // turning left/right
        if (moveHorizontal > 0)
        {
            gameObject.transform.rotation = Quaternion.Euler(0, 90, 0);
        }
        if (moveHorizontal < 0)
        {
            gameObject.transform.rotation = Quaternion.Euler(0, -90, 0);
        }


    }

    public void Dash()
    {
       
        float moveHorizontal = Input.GetAxis("Horizontal");
        rb.AddForce(new Vector3(moveHorizontal, 0, 0) * dashForce, ForceMode.VelocityChange);
        StartCoroutine(ExecuteAfterDash(dashDuration));
        

    }

    IEnumerator ExecuteAfterDash(float dashDuration)
    {
        yield return new WaitForSeconds(dashDuration);
        rb.velocity = Vector3.zero;
        dashNumber++;
    }

}
