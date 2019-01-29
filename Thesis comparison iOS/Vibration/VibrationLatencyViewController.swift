//
//  VibrationLatencyViewController.swift
//  Thesis comparison iOS
//
//  Created by Jarkko Saarinen on 12/11/2018.
//  Copyright © 2018 Jarkko Saarinen. All rights reserved.
//

import Foundation
import UIKit
import AudioToolbox

class VibrationLatencyViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vibrateBtn = view.viewWithTag(1) as? UIButton
        vibrateBtn?.addTarget(self, action: #selector(vibrateDevice), for: .touchDown)
    }
    
    @objc func vibrateDevice(sender: UIButton) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}
