//
//  RequestManager.swift
//  uk-intersting-info
//
//  Created by Tommy Hundley on 5/25/20.
//  Copyright © 2020 Tommy. All rights reserved.
//

import Foundation
import UIKit

class DataRequestManager {
    fileprivate let factsUrl = "https://bhundley.github.io/british-terms/data.json"
    
    static let shared = DataRequestManager()
    
    func getData(completion: ((FactsData) -> Void)?) {
        guard let url = URL(string: factsUrl) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "unknown error")")
                return
            }
            
            if let handler = completion, let testData = try? JSONDecoder().decode(FactsData.self, from: data) {
                handler(testData)
            }
        }.resume()
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
