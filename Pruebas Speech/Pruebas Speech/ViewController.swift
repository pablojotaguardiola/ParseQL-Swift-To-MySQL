//
//  ViewController.swift
//  Pruebas Speech
//
//  Created by Pablo Guardiola on 01/08/16.
//  Copyright © 2016 Pablo Guardiola. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController {
    
    var speechRecognizer: SFSpeechRecognizer? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            if authStatus == SFSpeechRecognizerAuthorizationStatus.authorized {
                
            }
        }
        
        if (speechRecognizer?.isAvailable == false) {
            print("Speech recognizer is not available!")
            return
        }
        
        speechRecognizer = SFSpeechRecognizer(locale: Locale(localeIdentifier: "en_US"))
        
        let request = SFSpeechRecognitionRequest()
        
        speechRecognizer?.recognitionTask(with: request, resultHandler: { (result, error) in
            print(result)
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

