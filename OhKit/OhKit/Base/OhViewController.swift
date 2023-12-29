//
//  OhViewController.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit
import Combine

open class OhViewController: NSViewController {

    // MARK: - Properties
    
    public lazy var subscriptions: Set<AnyCancellable> = {
        return Set<AnyCancellable>()
    }()
    
    public lazy var safeArea: NSLayoutGuide = {
        return self.view.safeAreaLayoutGuide
    }()
        
    // MARK: - View Life Cycle

    open override func loadView() {
        self.view = OhVisualEffectView.init()
    }
    
    // MARK: - Object Life Cycle;
    
    deinit {
        subscriptions.forEach({$0.cancel()})
        subscriptions.removeAll()
    }
    
    // MARK: - Operations
    
    public func activeLayoutConstraints(_ constraints: [NSLayoutConstraint]) {
        NSLayoutConstraint.activate(constraints)
    }
}
