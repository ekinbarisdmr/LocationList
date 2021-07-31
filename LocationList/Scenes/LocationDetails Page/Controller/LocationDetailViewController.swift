//
//  LocationDetailViewController.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 25.06.2021.
//

import UIKit

class LocationDetailViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var location = Location()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.navigationController?.navigationBar.isHidden = true
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func setupTableView() {
        tableView.register(LocationDetailTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 500
        tableView.rowHeight = UITableView.automaticDimension
    }
    
}

extension LocationDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(LocationDetailTableViewCell.self)!
                
        if let description = location.definition {
            cell.locationDescription.text = description
            print(description)
        }
        
        if let address = location.locationAdress {
            print(address)
            cell.locationDetail.text = address
        }
        
        if let locationImage = location.type {
            cell.locationImage.image = UIImage(named: "\(locationImage)")
        }
        
        cell.back = {
            self.navigationController?.popViewController(animated: true)
        }
        
        cell.route = {
            let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            if let vc = mainStoryboard.instantiateViewController(withIdentifier: "RouteViewController") as? RouteViewController {
                vc.location = self.location
               
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        return cell
    }
    
}


