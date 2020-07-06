//
//  CityEventDetailsViewController.swift
//  uk-intersting-info
//
//  Created by Tommy Sean Hundley-Grazioli on 7/5/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import UIKit

class CityEventDetailsViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var priceRangeLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    
    var cityEvent: CityEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.text = cityEvent?.name
        descLabel.text = cityEvent?.description
        priceRangeLabel.text = cityEvent?.price
        websiteButton.setTitle(cityEvent?.website, for: .normal)
        addressButton.setTitle(cityEvent?.address, for: .normal)
        
        if let image = cityEvent?.image, let url = URL(string: image) {
            detailsImage.isHidden = false
            detailsImage.load(url: url)
        }
    }
    
    @IBAction func websiteButtonPressed(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text, let url = URL(string: title) else { return }
        UIApplication.shared.open(url)
    }
    
    @IBAction func addressButtonPressed(_ sender: Any) {
//        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
//        mapItem.name = "Target location"
//        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
}
