//
//  ViewController.swift
//  Week11Assignment
//
//  Created by Asif Ahmed Jesi on 10/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonLeft: UIButton!
    @IBOutlet weak var buttonRight: UIButton!
    @IBOutlet weak var buttonTop: UIButton!
    
    @IBOutlet weak var constraintButtonTopBottomSpace: NSLayoutConstraint!
    @IBOutlet weak var constraintButtonLeftTrailingSpace: NSLayoutConstraint!
    @IBOutlet weak var constraintButtonRightLeadingSpace: NSLayoutConstraint!
    
    let redBox = UIView(frame: CGRect(x: 16, y: 100, width: 100, height: 100))
    
    private lazy var animator: UIViewPropertyAnimator = {
        return UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut)
    }()
    
    var menuCollapsed: Bool = true
    var startAnimation: Bool = false
    var isReload: Bool = false
    var rotationApplied: Bool = false
    var successMessage: String = "Animation Added Successfully"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redBox.translatesAutoresizingMaskIntoConstraints = false
        redBox.backgroundColor = .red
        view.addSubview(redBox)
        
        collapseMenu()
        
        animator.addCompletion { position in
            
            switch position {
            case .end:
                print("Animation Added")
            default:
                break
            }
        }
        
    }
    
    func resetRedBox() {
        let x = 16 + self.redBox.frame.size.width/2
        let y = 100 + self.redBox.frame.size.width/2
        self.redBox.center = CGPoint(x: x, y: y)
        self.redBox.backgroundColor = .red
    }
    func collapseMenu() {
        self.constraintButtonTopBottomSpace?.constant = -60
        self.constraintButtonLeftTrailingSpace?.constant = -60
        self.constraintButtonRightLeadingSpace?.constant = -60
        self.menuCollapsed = true
    }
    func expandMenu() {
        self.constraintButtonTopBottomSpace?.constant = 30
        self.constraintButtonLeftTrailingSpace?.constant = 30
        self.constraintButtonRightLeadingSpace?.constant = 30
        self.menuCollapsed = false
    }
    
    @IBAction func buttonPlayPressed(_ sender: UIButton) {
        
        if self.menuCollapsed {
            expandMenu()
            if isReload { resetRedBox() }
            else { isReload = true }
        }
        else {
            collapseMenu()
            self.startAnimation = true
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }) { (result) in
            if self.startAnimation {
                self.startAnimation = false
                self.animator.startAnimation()
            }
        }
    }
    
    @IBAction func buttonLeftPressed(_ sender: UIButton) {
        
        animator.addAnimations {
            self.redBox.backgroundColor = .orange
        }
        self.showSuccessAlert(msg: self.successMessage)
    }
    
    @IBAction func buttonRightPressed(_ sender: Any) {
        
        animator.addAnimations {[unowned self] in
            let y = self.redBox.center.y
            let x = self.redBox.center.x + (self.view.frame.size.width - (self.redBox.frame.size.width + 32))
            self.redBox.center = CGPoint(x: x, y: y)
        }
        self.showSuccessAlert(msg: self.successMessage)
    }
    
    @IBAction func buttonTopPressed(_ sender: Any) {
        
        animator.addAnimations {[unowned self] in
            self.redBox.transform = self.rotationApplied ? .identity : CGAffineTransform(rotationAngle: CGFloat.pi)
            self.rotationApplied = !self.rotationApplied
        }
        self.showSuccessAlert(msg: self.successMessage)
    }
}

