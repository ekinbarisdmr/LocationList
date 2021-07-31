//
//  LocationListViewController.swift
//  LocationList
//
//  Created by Ekin Barış Demir on 25.06.2021.
//

import UIKit

class LocationListViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var locationList = [Location]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.viewBackgroundColor()
        self.navigationController?.navigationBar.isHidden = true
        locationList = StoreManager.shared.getLocation()
        setups()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setups()
        self.tabBarController?.tabBar.isHidden = false
        locationList = StoreManager.shared.getLocation()
        collectionView.reloadData()

    }
    
    func setups() {
        setupCollectionView()
        setupNavigatonController()
    }
    
    func setupNavigatonController() {
        self.navigationItem.title = "My Locations"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.textColor()]
        self.navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.textColor()]
        self.navigationController?.navigationBar.tintColor = UIColor.textColor()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.backgroundColor = .clear
        self.navigationController?.navigationBar.layoutIfNeeded()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .always
        definesPresentationContext = false
        self.navigationController?.setStatusBar(backgroundColor: UIColor.viewBackgroundColor())
        self.navigationController?.navigationBar.isHidden = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
    }
    
    func setupCollectionView() {
        collectionView.register(LocationListCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = true
        collectionView.setCollectionViewLayout(layout, animated: true)
        layout.scrollDirection = .vertical
        collectionView.backgroundColor = UIColor.viewBackgroundColor()
    }
    
    @objc func addLocation() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "SaveLocationViewController") as? SaveLocationViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension LocationListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.collectionView.frame.size.width - 20) / 2.2, height: (self.collectionView.frame.size.width - 20) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}


extension LocationListViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(LocationListCollectionViewCell.self, indexPath)!
        cell.backgroundColor = UIColor.cellBackgroundColor()
        cell.layer.cornerRadius = 20
        
        if let locationImage = locationList[indexPath.row].type {
            cell.locationImage.image = UIImage(named: "\(locationImage)")
        }
        
        if let locationName = locationList[indexPath.row].definition {
            cell.locationName.text = locationName
        }
        return cell
    }
    
    
}
extension LocationListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showLocationDetails(indexPath: indexPath)
    }
    
    func showLocationDetails(indexPath: IndexPath) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let vc = mainStoryboard.instantiateViewController(withIdentifier: "LocationDetailViewController") as? LocationDetailViewController {
            vc.location = locationList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}


