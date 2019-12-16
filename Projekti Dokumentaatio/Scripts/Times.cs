using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Times : MonoBehaviour
{
    public Text currentTime;
    public string seconds, minutes;
    private float startTime;
    private bool finished = false;

    private void Start()
    {
        currentTime = GetComponent<Text>();
        startTime = Time.time;
        
    }

    public void Update()
    {
        if (finished)
            return;
        float t = Time.time - startTime;
        minutes = ((int)t / 60).ToString("00");
        seconds = (t % 60).ToString("f2");
        currentTime.text = minutes+ ":" + seconds;
        
        
    }

    public void HideTimer()
    {
        currentTime.enabled = false;
    }

    public void FinishTimer()
    {
        finished = true;
    }
}
