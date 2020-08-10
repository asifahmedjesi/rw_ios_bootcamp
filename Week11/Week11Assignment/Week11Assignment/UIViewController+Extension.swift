//
//  UIViewController+Extension.swift
//  Week11Assignment
//
//  Created by Asif Ahmed Jesi on 11/8/20.
//  Copyright © 2020 Asif Ahmed Jesi. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showSuccessAlert(msg: String) {
        
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
        labelView.text = msg
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
    
    private func delay(seconds: TimeInterval, execute: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: execute)
    }
}
