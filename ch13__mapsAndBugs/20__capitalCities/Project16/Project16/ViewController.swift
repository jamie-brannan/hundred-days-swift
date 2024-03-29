//
//  ViewController.swift
//  Project16
//
//  Created by Jamie Brannan on 24/05/2021.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {
  
  @IBOutlet var mapView: MKMapView!
  private let types: [String:MKMapType] = [
    "Hybrid" : MKMapType.hybrid,
    "Satellite" : MKMapType.satellite,
    "Muted Standard" : MKMapType.mutedStandard
  ]

  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Map type", style: .plain, target: self, action: #selector(askForMapType))
    let mapPoints = setupAnnotations()
    mapView.addAnnotations(mapPoints)
  }

  // MARK: - Setup

  @objc func askForMapType() {
    let ac = UIAlertController(title: "Welcome!", message: "What style of map would you like?", preferredStyle: .alert)
    for (typeName, rawMapType) in types {
      ac.addAction(UIAlertAction(title: typeName, style: .default) { _ in
        self.mapView.mapType = rawMapType
      })
    }
    ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    present(ac, animated: true)
  }

  private func setupAnnotations() -> [Capital] {
    let london = Capital(title: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275), info: "Home to the 2012 Summer Olympics.")
    let oslo = Capital(title: "Oslo", coordinate: CLLocationCoordinate2D(latitude: 59.95, longitude: 10.75), info: "Founded over a thousand years ago.")
    let paris = Capital(title: "Paris", coordinate: CLLocationCoordinate2D(latitude: 48.8567, longitude: 2.3508), info: "Often called the City of Light.")
    let rome = Capital(title: "Rome", coordinate: CLLocationCoordinate2D(latitude: 41.9, longitude: 12.5), info: "Has a whole country inside it.")
    let washington = Capital(title: "Washington DC", coordinate: CLLocationCoordinate2D(latitude: 38.895111, longitude: -77.036667), info: "Named after George himself.")
    let points = [london, oslo, paris, rome, washington]
    return points
  }

  // MARK: - Map view delegates
  func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
    guard annotation is Capital else { return nil }
    let identifier = "Capital"
    var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
    if annotationView == nil {
      annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotationView?.canShowCallout = true
      let btn = UIButton(type: .detailDisclosure)
      annotationView?.rightCalloutAccessoryView = btn
    } else {
      annotationView?.annotation = annotation
    }
    if let annotationPinView = annotationView as? MKPinAnnotationView {
      annotationPinView.pinTintColor = .blue
      return annotationPinView
    }
    return annotationView
  }
  
  func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
    guard let capital = view.annotation as? Capital else { return }
    let vc = CityWikiDetailViewController()
    vc.capital = capital
    navigationController?.pushViewController(vc, animated: true)
  }
}

