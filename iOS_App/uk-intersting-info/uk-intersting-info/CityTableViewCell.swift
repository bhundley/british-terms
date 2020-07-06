//
//  CityTableViewCell.swift
//  uk-intersting-info
//
//  Created by Tommy Sean Hundley-Grazioli on 7/5/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import UIKit

class CityTableViewCell: UITableViewCell {
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var roundedView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedView.backgroundColor = UIColor.systemBackground
        roundedView.layer.cornerRadius = 8
        cityImage.layer.cornerRadius = 8
    }

    override func prepareForReuse() {
        cityImage.image = nil
        cityLabel.text = ""
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
