//
//  CitiesViewController.swift
//  uk-intersting-info
//
//  Created by Tommy Sean Hundley-Grazioli on 7/5/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import UIKit

class CitiesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var cities: [City]?
    //var sections: [Section] = [.slang, .artist, .food]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Grab the data for the facts
        DataRequestManager.shared.getCityData {[weak self] data in
            self?.cities = data.cities
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}
    
extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {
    //MARK:  Tableview Delegate Methods
    func numberOfSections(in tableView: UITableView) -> Int {
        guard cities != nil else { return 0 }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let cities = cities else { return 0 }

        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CityTableViewCell
        
        guard let cities = cities else { return cell }
        let city = cities[indexPath.row]
        
        cell.cityLabel.text = city.name
        
        if let imageUrl = city.image, let url = URL(string: imageUrl) {
            cell.cityImage.load(url: url)
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 215
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cities = cities else { return }
        
        let city = cities[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "CityDetailsViewController") as! CityDetailsViewController
        
        vc.city = city
        
        navigationController?.pushViewController(vc, animated: true)
//        present(vc, animated: true, completion: nil)
    }
}

