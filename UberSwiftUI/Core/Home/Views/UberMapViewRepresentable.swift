//
//  UberMapViewRepresentable.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/26.
//

import SwiftUI
import MapKit

struct UBerMapViewRepresentable: UIViewRepresentable{
    
    let mapView = MKMapView()
    let locationManager = LocationManager()
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator.self
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
    func makeCoordinator() -> Mapcoordinator{
        return Mapcoordinator(parent: self)
        
    }
    
}

extension UBerMapViewRepresentable{
    
    class Mapcoordinator: NSObject,MKMapViewDelegate{
    
        let parent:UBerMapViewRepresentable
        
        init(parent: UBerMapViewRepresentable) {
            self.parent = parent
            super.init()
            
        }
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            print("hellow")
            parent.mapView.setRegion(region, animated: true)
        }
    }
}
