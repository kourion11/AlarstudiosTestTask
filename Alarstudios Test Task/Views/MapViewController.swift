//
//  MapViewController.swift
//  Alarstudios Test Task
//
//  Created by Сергей Юдин on 25.07.2022.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        return mapView
    }()
    
    var lon: Double = 0.0
    var lat: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMap()
        setupConstraints()
    }
    
    func setupMap() {
        view.addSubview(mapView)
        
        let initialLocation = CLLocation(latitude: lat, longitude: lon)
        mapView.centerLocation(initialLocation)
        
        let place = MKPointAnnotation()
        place.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        mapView.addAnnotation(place)
    }
    
    func setupConstraints() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
    }
}

extension MKMapView {
    func centerLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
