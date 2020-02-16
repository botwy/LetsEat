//
//  MapViewController.swift
//  LetsEat
//
//  Created by Гончаров Денис Васильевич on 22.12.2019.
//  Copyright © 2019 Гончаров Денис Васильевич. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    var manager: MapDataManager?
    
    var selectedRestaurant:RestaurantItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initialize()
    }
    
    func initialize() {
        mapView.delegate = self
        manager?.fetch { (annotations) in
            self.addMap(annotations)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      switch segue.identifier! {
          case Segue.showDetail.rawValue:
                   showRestaurantDetail(segue: segue)
              default:
                   print("Segue not added")
       }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let annotation = mapView.selectedAnnotations.first else { return }
        selectedRestaurant = annotation as? RestaurantItem
        performSegue(withIdentifier: Segue.showDetail.rawValue, sender: self)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "custompin"
        
        guard !annotation.isKind(of: MKUserLocation.self) else {
            return nil
        }
        
        var annotationView: MKAnnotationView?
        if let customAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = customAnnotationView
            annotationView?.annotation = annotation
        } else {
            let av = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            av.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            annotationView = av
        }
        
        if let annotationView = annotationView {
            annotationView.canShowCallout = true
            annotationView.image = UIImage(named: "custom-annotation")
        }
        
        return annotationView
    }
    
    func addMap(_ annotations:[RestaurantItem]) {
        guard let manager = manager else { return }
        mapView.setRegion(manager.currentRegion(latDelta: 0.5, longDelta: 0.5), animated: true)
        mapView.addAnnotations(manager.annotations)
    }
    
    func showRestaurantDetail(segue:UIStoryboardSegue) {
       if let viewController = segue.destination as? RestaurantDetailViewController, let restaurant = selectedRestaurant  {
              viewController.selectedRestaurant = restaurant
       }
    }
}
