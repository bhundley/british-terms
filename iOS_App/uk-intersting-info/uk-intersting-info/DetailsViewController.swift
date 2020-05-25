//
//  DetailsViewController.swift
//  uk-intersting-info
//
//  Created by Byron Hundley on 5/25/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    var text1 = ""
    var text2 = ""
    var imageUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = text1
        descLabel.text = text2
        
        if let url = URL(string: imageUrl) {
            detailsImage.isHidden = false
            detailsImage.load(url: url)
        }
    }
}
