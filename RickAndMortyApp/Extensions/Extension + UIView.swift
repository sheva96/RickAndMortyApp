//
//  Extension + UIView.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 18.03.2021.
//

import UIKit

extension UIView {
    
    func showAnimation() {
        
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }) {  _ in
            UIView.animate(withDuration: 0.25,
                           delay: 0,
                           options: .curveLinear,
                           animations: {
                            self.transform = CGAffineTransform(scaleX: 1, y: 1)
                           },
                           completion: nil)
        }
    }
}


