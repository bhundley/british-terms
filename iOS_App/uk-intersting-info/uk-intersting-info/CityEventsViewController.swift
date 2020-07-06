//
//  CityEventsViewController.swift
//  uk-intersting-info
//
//  Created by Tommy Sean Hundley-Grazioli on 7/5/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import UIKit

class CityEventsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var events: [CityEvent]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension CityEventsViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK:  Tableview Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        guard events != nil else { return 0 }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let events = events else { return 0 }

        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityEventsTableViewCell
        
        guard let events = events else { return cell }
        let event = events[indexPath.row]
        
        cell.eventNameLabel.text = event.name
        cell.descLabel.text = event.description
        
        if let imageUrl = event.image, let url = URL(string: imageUrl) {
            cell.eventImage.load(url: url)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 255
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let events = events else { return }
        
        let event = events[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "CityEventDetailsViewController") as! CityEventDetailsViewController
        vc.cityEvent = event
        navigationController?.pushViewController(vc, animated: true)
    }
}

class CityEventsTableViewCell: UITableViewCell {
    @IBOutlet weak var roundedView: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundedView.backgroundColor = UIColor.systemBackground
        roundedView.layer.cornerRadius = 8
        eventImage.layer.cornerRadius = 8
    }
}
