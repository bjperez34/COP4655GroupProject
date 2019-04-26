//
//  MeditationViewController.swift
//  COP4655GroupProject
//
//  Created by Nathaniel Pulido on 4/24/19.
//  Copyright © 2019 kpuli007. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class MeditationViewController: UIViewController {
    
    var audioPlayer = AVAudioPlayer()
    var lengthOfSound = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Initialize the audio player (with our hardcoded sound) on view load
        initAudioPlayer()
    }
    
    func initAudioPlayer() {
        //Replace "laser.wav" with the meditation sound filename
        let path = Bundle.main.path(forResource: "laser.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        //Obtain the length of the sound as a Double, thanks stackexchange
        let asset = AVURLAsset.init(url: url)
        let audioDuration = asset.duration
        lengthOfSound = CMTimeGetSeconds(audioDuration)
        
        try! self.audioPlayer = AVAudioPlayer.init(contentsOf: url)
        try! AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        try! AVAudioSession.sharedInstance().setActive(true)
        
        self.audioPlayer.currentTime = 0
        self.audioPlayer.numberOfLoops = 1
        self.audioPlayer.volume = 1.0
        self.audioPlayer.prepareToPlay()
    }
    
    
    @IBOutlet var durationField: UITextField!
    
    @IBAction func playSoundForDuration(_ sender: Any) {
    
        let secondsText = durationField?.text
        let seconds = Double(secondsText!)
        
        if(seconds == nil) {
            //Display an alert and stop if the text field is empty
            //Also triggers if it contains non-numeric characters due to the casting failing just the same
            let ac = UIAlertController(title: "Error", message: "Please enter a valid number!", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            ac.addAction(okAction)
            
            present(ac, animated: true, completion: nil)
        }
        else {
            /*
                The strategy here is to first get the number of times we need to play the whole sound by divinding the input seconds by the length of the sound and casting to Int.
 
                Then, we start the sound in the middle using the cutoff to deal with the remainder (particularly noticeable for long input sounds like 1 minute ambient loops you might think about while meditating).
 
                For instance, if we need to play the sound 5.4 times to play it for one minute, then we start it at 0.6 to play the last 0.4, and then play the entire sound 5 times after that.
            */
            let numReps = Int(seconds! / lengthOfSound)
            
            //Truncating remainder = modulo (%). In this version of Swift modulo is only defined for Ints
            let cutoff = (lengthOfSound) - (seconds!.truncatingRemainder(dividingBy: lengthOfSound))
            
            //Set up the audio player and play the sound
            self.audioPlayer.currentTime = cutoff
            self.audioPlayer.numberOfLoops = numReps
            self.audioPlayer.volume = 1.0
            self.audioPlayer.prepareToPlay()
            self.audioPlayer.play()
            
        }
        
        
        
        
    }
    
    
}
