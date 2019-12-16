using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;


public class GameManager : MonoBehaviour
{
    // Script for managing game completion and "game over" and restarting game from checkpoint or start if level complete

    bool gameHasEnded = false;
    
    
    public GameObject levelCompletedUI; // drag LevelComplete Panel on this
    public GameObject gameOverUI; // drag Gameover Panel on this
    public GameObject image;
    GameObject player;
    
    public float animationDelay = 3f;
    public float restartDelay = 5f;

    private void Start()
    {
        player = GameObject.FindGameObjectWithTag("Player");
        image.SetActive(true);
    }

    public void LevelComplete()
    {       
        levelCompletedUI.SetActive(true);
        Invoke("RestartGame", restartDelay);
    }

    public void EndGame()
    {
        if (gameHasEnded == false)
        {
            gameHasEnded = true;
            gameOverUI.SetActive(true);
            Invoke("RestartGame", restartDelay);
        }
    }



    void RestartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().buildIndex);
        SaveSystem.LoadPlayer();
    }
}
