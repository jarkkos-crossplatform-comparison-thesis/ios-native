//
//  NoAnimationPopUIViewController.swift
//  Thesis comparison iOS
//
//  Created by Jarkko Saarinen on 14/11/2018.
//  Copyright © 2018 Jarkko Saarinen. All rights reserved.
//

import Foundation
import UIKit

class NoAnimationPopUIViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIButton(type: .system)
        backButton.setTitle("Back", for: .normal)
        backButton.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 30.0)
        backButton.addTarget(self, action: #selector(backTapped), for: .touchDown)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    @objc func backTapped(sender: UIButton) {
        navigationController?.popViewController(animated: false)
    }
}
