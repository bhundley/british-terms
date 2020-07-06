//
//  CityDetailsViewController.swift
//  uk-intersting-info
//
//  Created by Tommy Sean Hundley-Grazioli on 7/5/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import UIKit

enum CityEventType: String {
    case food = "Food"
    case lodging = "Lodging"
    case activity = "Activity"
    case attraction = "Attraction"
    
    var icon: UIImage? {
        switch self {
        case .food:
            return UIImage(named: "food")
        case .lodging:
            return UIImage(named: "food")
        case .activity:
            return UIImage(named: "food")
        case .attraction:
            return UIImage(named: "food")
        }
    }
    
    var color: UIColor? {
        switch self {
        case .food:
            return #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        case .lodging:
            return #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        case .activity:
            return #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case .attraction:
            return #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        }
    }
}

class CityDetailsViewController: UIViewController {
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var city: City?
    var cityEvents: [CityEventType]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addEvents()
        cityName.text = city?.name ?? ""
        
        if let imageUrl = city?.image, let url = URL(string: imageUrl) {
            cityImage.load(url: url)
        }
    }
    
    func addEvents() {
        cityEvents = []
        if city?.food != nil {
            cityEvents?.append(.food)
        }
        if city?.lodging != nil {
            cityEvents?.append(.lodging)
        }
        if city?.activities != nil {
            cityEvents?.append(.activity)
        }
        if city?.attractions != nil {
            cityEvents?.append(.attraction)
        }
    }
}


extension CityDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cityEvents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CityDetailsCollectionViewCell
        
        if let type = cityEvents?[indexPath.row] {
            cell.iconText.text = type.rawValue
            cell.icon.image = type.icon
            cell.contentView.backgroundColor = type.color
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let type = cityEvents?[indexPath.row] {
            var events: [CityEvent]? = nil
            
            switch type {
            case .food:
                events = city?.food
            case .lodging:
                events = city?.lodging
            case .activity:
                events = city?.activities
            case .attraction:
                events = city?.attractions
            }
            
            let vc = storyboard?.instantiateViewController(withIdentifier: "CityEventsViewController") as! CityEventsViewController
            vc.events = events
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension CityDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        
        let width = (self.view.frame.size.width - 40) / 2 //some width
        let height = width // * 1.5 //ratio
        
       return CGSize(width: width, height: height)
    }
}

class CityDetailsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var iconText: UILabel!
    @IBOutlet weak var icon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = UIColor.systemBackground
        contentView.layer.cornerRadius = 8
    }
}
