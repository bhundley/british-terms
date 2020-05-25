//
//  ViewController.swift
//  uk-intersting-info
//
//  Created by Byron Hundley on 5/25/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import UIKit

enum Section {
    case slang, artist, food
}

class TableViewController: UITableViewController {
    var factData: FactsData?
    
    var sections: [Section] = [.slang, .artist, .food]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Grab the data for the facts
        DataRequestManager.shared.getData {[weak self] data in
            self?.factData = data
            
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    ///MARK:  Tableview Delegate Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let factData = factData else { return 0 }
        let section = sections[section]
        
        switch section {
        case .slang:
            return factData.slang?.count ?? 0
        case .artist:
            return factData.topArtists?.count ?? 0
        case .food:
            return factData.food?.count ?? 0
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard factData != nil else { return nil }
        let section = sections[section]
        
        switch section {
        case .slang:
            return "Slang UK Words"
        case .artist:
            return "Top UK Artist"
        case .food:
            return "Typical UK Food"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        guard let factData = factData else { return cell }
        let section = sections[indexPath.section]
        
        switch section {
        case .slang:
            cell.textLabel?.text = factData.slang?[indexPath.row].us
        case .artist:
            cell.textLabel?.text = factData.topArtists?[indexPath.row].artist
        case .food:
            cell.textLabel?.text = factData.food?[indexPath.row].name
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let factData = factData else { return }
        let section = sections[indexPath.section]
        
//        let vc = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        switch section {
        case .slang:
            if let usVersion = factData.slang?[indexPath.row].us, let ukVersion = factData.slang?[indexPath.row].uk {
                self.navigationController?.pushViewController(vc, animated: true)
                vc.text1 = "US Word/Term: \(usVersion)"
                vc.text2 = "UK Word/Term: \(ukVersion)"
            }
        case .artist:
            if let artist = factData.topArtists?[indexPath.row].artist, let genre = factData.topArtists?[indexPath.row].genre {
                vc.text1 = artist
                vc.text2 = genre
                
                if let imageUrl = factData.topArtists?[indexPath.row].image {
                    vc.imageUrl = imageUrl
                }
                self.navigationController?.pushViewController(vc, animated: true)
            }
        case .food:
            if let foodName = factData.food?[indexPath.row].name, let desc = factData.food?[indexPath.row].desc {
                vc.text1 = foodName
                vc.text2 = desc
                
                if let imageUrl = factData.food?[indexPath.row].image {
                    vc.imageUrl = imageUrl
                }
                
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
}

