//
//  StartViewController.swift
//  RickAndMortyApp
//
//  Created by Yevhen Shevchenko on 17.03.2021.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        imageView.addGestureRecognizer(tap)
        imageView.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.showAnimation()
    }
    
    @objc func tapAction() {
        imageView.showAnimation()
        performSegue(withIdentifier: "showCharacters", sender: nil)
    }
}
