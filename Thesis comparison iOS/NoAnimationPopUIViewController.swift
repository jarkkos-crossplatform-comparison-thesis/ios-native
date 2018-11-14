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
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(backTapped))
    }
    
    @objc func backTapped(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: false)
    }
}
