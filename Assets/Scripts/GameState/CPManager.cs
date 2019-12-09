using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CPManager : MonoBehaviour
{
    // set player's starting x,y,z positions as parameters for lastCheckPointPos
    // Tag CPManager object as "CPM"
    private static CPManager instance;
    public Vector3 lastCheckPointPos;

    void Awake()
    {
        if(instance == null)
        {
            instance = this;
            DontDestroyOnLoad(instance);
        }
        else
        {
            Destroy(gameObject);
        }
    }


}
