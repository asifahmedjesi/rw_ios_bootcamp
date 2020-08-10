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
        self.showSuccessAlert()
    }
    
    @IBAction func buttonRightPressed(_ sender: Any) {
        
        animator.addAnimations {[unowned self] in
            let y = self.redBox.center.y
            let x = self.redBox.center.x + (self.view.frame.size.width - (self.redBox.frame.size.width + 32))
            self.redBox.center = CGPoint(x: x, y: y)
        }
        self.showSuccessAlert()
    }
    
    @IBAction func buttonTopPressed(_ sender: Any) {
        
        animator.addAnimations {[unowned self] in
            self.redBox.transform = self.rotationApplied ? .identity : CGAffineTransform(rotationAngle: CGFloat.pi)
            self.rotationApplied = !self.rotationApplied
        }
        self.showSuccessAlert()
    }
}

extension ViewController {
    
    func showSuccessAlert() {
        
        let alertView = UIView()
        alertView.translatesAutoresizingMaskIntoConstraints = false
        alertView.layer.cornerRadius = 5
        alertView.backgroundColor = .black
        alertView.alpha = 0.8
        view.addSubview(alertView)
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "tick")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(imageView)
        
        let labelView = UILabel()
        labelView.numberOfLines = 0
        labelView.textColor = .white
        labelView.text = "Animation Added Successfully"
        labelView.translatesAutoresizingMaskIntoConstraints = false
        alertView.addSubview(labelView)
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: alertView.leadingAnchor, constant: 8),
            imageView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 35),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
            labelView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8),
            labelView.trailingAnchor.constraint(equalTo: alertView.trailingAnchor, constant: -8),
            labelView.centerYAnchor.constraint(equalTo: alertView.centerYAnchor)
        ])
        
        
        let containerView = UIView(frame: alertView.frame)
        view.addSubview(containerView)
        containerView.addSubview(alertView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        let topConstraint = containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: alertView.frame.height * -1)
        let widthConstraint = containerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8, constant: 0)
        
        NSLayoutConstraint.activate([
            topConstraint,
            widthConstraint,
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            alertView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            alertView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            alertView.widthAnchor.constraint(equalTo: containerView.widthAnchor),
            alertView.heightAnchor.constraint(equalTo: containerView.heightAnchor)
        ])
        
        view.layoutIfNeeded()

        UIView.animate(
            withDuration: 0.8, delay: 0,
            usingSpringWithDamping: 0.6, initialSpringVelocity: 10,
            animations: {
                topConstraint.constant = alertView.frame.height
                self.view.layoutIfNeeded()
            }
        )
        
        delay(seconds: 2) {
            UIView.transition(
                with: containerView,
                duration: 0.8,
                options: .transitionCrossDissolve,
                animations: alertView.removeFromSuperview,
                completion: { _ in containerView.removeFromSuperview() }
            )
        }
        
    }
}

private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
}

