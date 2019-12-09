using System.Collections;
using System.Collections.Generic;
using System.IO;
using UnityEngine;
using UnityEngine.SceneManagement;

public class SceneChanger : MonoBehaviour
{
    private void Start()
    {
        string path = Application.persistentDataPath + "/player.cat";
        if (File.Exists(path))
        {
            LoadNextLvl();
        }
        else
        {
            Debug.LogError("Save file not found in " + path);
        }
    }

    public void LoadNextLvl()
    {
        
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex + 1);
    }


}
