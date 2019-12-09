using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class YourTime : MonoBehaviour
{
    public Text yourTime;
    public Text currentTime;
    public Text bestTime;
    // Start is called before the first frame update

    private void Start()
    {
        bestTime = GameObject.Find("BestTime").GetComponent<Text>();
        bestTime.text = PlayerPrefs.GetString("BestTime", null);
    }

    public void ShowTime()
    {
        yourTime = GetComponent<Text>();
        currentTime = GameObject.Find("CurrentTime").GetComponent<Text>();
        yourTime.text = currentTime.text;
    }

    public void SetBestTime()
    {       
        bestTime.text = "Previous Time " + yourTime.text;
        PlayerPrefs.SetString("BestTime", bestTime.text);
                /*int minutes;
        float seconds, total;
        int.TryParse(FindObjectOfType<Times>().minutes, out minutes);
        int minutesToSec = minutes * 60;
        float.TryParse(FindObjectOfType<Times>().seconds, out seconds);
        total = minutesToSec + seconds;*/

    }

}
