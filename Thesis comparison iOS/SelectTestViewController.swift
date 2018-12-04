//
//  ViewController.swift
//  Thesis comparison iOS
//
//  Created by Jarkko Saarinen on 18/08/2018.
//  Copyright © 2018 Jarkko Saarinen. All rights reserved.
//

import UIKit

class SelectTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let btnLatency = view.viewWithTag(1) as? UIButton
        btnLatency?.addTarget(self, action: #selector(openButtonLatencyTest), for: .touchDown)
        
        let btnLocalListView = view.viewWithTag(2) as? UIButton
        btnLocalListView?.addTarget(self, action: #selector(openNotImplementedScreen), for: .touchDown)
        
        let btnNetworkListView = view.viewWithTag(3) as? UIButton
        btnNetworkListView?.addTarget(self, action: #selector(openNotImplementedScreen), for: .touchDown)
        
        let btnHeavyComputation = view.viewWithTag(4) as? UIButton
        btnHeavyComputation?.addTarget(self, action: #selector(openHeavyComputationTest), for: .touchDown)
        
        let btnVibrationLatency = view.viewWithTag(5) as? UIButton
        btnVibrationLatency?.addTarget(self, action: #selector(openVibrationLatencyTest), for: .touchDown)
        
        let btnThirdPartyNotices = view.viewWithTag(6) as? UIButton
        btnThirdPartyNotices?.addTarget(self, action: #selector(openNotImplementedScreen), for: .touchDown)
    }
    
    @objc func openButtonLatencyTest() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let buttonLatencyVC = storyBoard.instantiateViewController(withIdentifier: "ButtonLatency")
        self.navigationController!.pushViewController(buttonLatencyVC, animated: false)
    }
    
    @objc func openHeavyComputationTest() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let buttonLatencyVC = storyBoard.instantiateViewController(withIdentifier: "HeavyComputation")
        self.navigationController!.pushViewController(buttonLatencyVC, animated: false)
    }
    
    @objc func openVibrationLatencyTest() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let vibrationLatencyVC = storyBoard.instantiateViewController(withIdentifier: "VibrationLatency")
        self.navigationController!.pushViewController(vibrationLatencyVC, animated: false)
    }
    
    @objc func openNotImplementedScreen() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let notImplementedVC = storyBoard.instantiateViewController(withIdentifier: "NotImplemented")
        self.navigationController!.pushViewController(notImplementedVC, animated: false)
    }
}

