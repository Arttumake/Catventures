using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.UI;

public class PlayerPosition : MonoBehaviour
{
    // replace hardcoded floats with the x,y,z position of your player's starting position


    public Text healthTxt;
    public GameObject gameSavedTxt;
    public GameObject gameLoadedTxt;  
    public int health = 3;


    void Start()
    {

        string path = Application.persistentDataPath + "/player.cat";
        if (File.Exists(path))
        {
            LoadPlayer();
        }

        UpdateHealth();
    }

    public void SavePlayer()
    {
        SaveSystem.SavePlayer(this);
        gameSavedTxt.SetActive(true);
    }

    public void LoadPlayer()
    {

        string path = Application.persistentDataPath + "/player.cat";
        if (File.Exists(path))
        {
            gameLoadedTxt.SetActive(true);
            PlayerData data = SaveSystem.LoadPlayer();

            health = data.health;

            Vector3 position;
            position.x = data.position[0];
            position.y = data.position[1];
            position.z = data.position[2];
            transform.position = position;
        }
        else
        {
            Debug.LogError("Save file not found in " + path);
        }
    }

    public void UpdateHealth()
    {
        if (health >= 0)
        {
            healthTxt.text = "Health: " + health;
        }
    }


    void Update()
    {
        if (Input.GetKeyDown("s"))
        {
            SavePlayer();
        }
        if (Input.GetKeyDown("l"))
        {
            LoadPlayer();
        }
        if (Input.GetKeyDown("c"))
        {
            string path = Application.persistentDataPath + "/player.cat";
            SaveSystem.DeleteSave();

        }
        if (health < 1)
        {
            FindObjectOfType<GameManager>().EndGame();
        }
    }


}
