//
//  ButtonLatencyViewController.swift
//  Thesis comparison iOS
//
//  Created by Jarkko Saarinen on 12/11/2018.
//  Copyright © 2018 Jarkko Saarinen. All rights reserved.
//

import Foundation
import UIKit

class ButtonLatencyViewController: UIViewController {
    var counter = 0
    var counterLabel: UILabel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel = view.viewWithTag(2) as? UILabel
        updateLabel()
        
        let incrementBtn = view.viewWithTag(1) as? UIButton
        incrementBtn?.addTarget(self, action: #selector(incrementCounter), for: .touchDown)
        
        let goBackBtn = view.viewWithTag(3) as? UIButton
        goBackBtn?.addTarget(self, action: #selector(navigateBack), for: .touchDown)
    }
    
    @objc func incrementCounter(sender: UIButton) {
        counter += 1
        updateLabel()
    }
    
    func updateLabel() {
        self.counterLabel?.text = String(counter)
    }
    
    @objc func navigateBack(sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
}
