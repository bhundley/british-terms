//
//  CityEventDetailsViewController.swift
//  uk-intersting-info
//
//  Created by Tommy Sean Hundley-Grazioli on 7/5/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import UIKit
import MapKit

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
    
    @IBAction func addressButtonPressed(_ sender: UIButton) {
        guard let address = cityEvent?.address else { return }
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) {placemarks,_ in
            if let placemarks = placemarks, let coords = placemarks.first?.location?.coordinate {
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coords, addressDictionary: nil))
                mapItem.name = self.cityEvent?.name
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
            }
        }
    }
}
