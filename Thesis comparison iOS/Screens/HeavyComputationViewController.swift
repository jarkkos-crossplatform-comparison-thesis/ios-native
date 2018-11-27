//
//  HeavyComputationViewController.swift
//  Thesis comparison iOS
//
//  Created by Jarkko Saarinen on 27/11/2018.
//  Copyright © 2018 Jarkko Saarinen. All rights reserved.
//

import Foundation
import UIKit

class HeavyComputationViewController: NoAnimationPopUIViewController {
    var state: ComputationState = .idle
    var curJob: ComputationJob? = nil

    var counterLabel: UILabel? = nil
    var activityIndicator: UIActivityIndicatorView? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        counterLabel = view.viewWithTag(2) as? UILabel
        activityIndicator = view.viewWithTag(3) as? UIActivityIndicatorView
        activityIndicator?.hidesWhenStopped = true
        updateView()
        
        let startComputationBtn = view.viewWithTag(1) as? UIButton
        startComputationBtn?.addTarget(self, action: #selector(startComputation), for: .touchDown)
    }
    
    @objc func startComputation(sender: UIButton) {
        state = .computing
        
        curJob?.cancelled = true
        let newJob = ComputationJob()
        
        DispatchQueue.global().async {
            let primes = findPrimesBelow(3_000_000)
            DispatchQueue.main.async { [weak self] in
                if (!newJob.cancelled) {
                    self?.onJobFinished(primes)
                }
            }
        }
        
        curJob = newJob
        updateView()
    }
    
    func onJobFinished(_ primes: [Int]) {
        state = .done
        updateView()
    }
    
    func updateView() {
        var labelText: String
        var showActivityIndicator = false
        switch self.state {
        case .idle:
            labelText = "Click to start computation"
        case .computing:
            labelText = "Computing..."
            showActivityIndicator = true
        case .done:
            labelText = "Done"
        }
        
        self.counterLabel?.text = labelText
        
        if (showActivityIndicator) {
            self.activityIndicator?.startAnimating()
        }
        else {
            self.activityIndicator?.stopAnimating()
        }
    }
}

enum ComputationState{
    case idle
    case computing
    case done
}

class ComputationJob {
    var cancelled: Bool = false
}

func findPrimesBelow(_ number: Int) -> [Int] {
    var primes: [Int] = []
    
    for i in 1...number {
        if (isPrimeNumber(i)) {
            primes.append(i)
        }
    }
    
    return primes
}

func isPrimeNumber(_ number: Int) -> Bool {
    if (number == 1) {
        return false
    }
    if (number <= 3) {
        return true
    }
    
    let numberSqrtDbl = sqrt(Double(number))
    let numberSqrtInt = Int(numberSqrtDbl)
    for i in 2...numberSqrtInt {
        if (number % i == 0) {
            return false
        }
    }
    
    return true
}
