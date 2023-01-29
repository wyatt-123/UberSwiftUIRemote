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
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator.self
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if let coordinate = locationViewModel.selectedLocationCoordinate{
            
            context.coordinator.addAndSelectedAnnotation(withCoordinate: coordinate)
            context.coordinator.configurePolyline(withDestinationCoodinate: coordinate)
          				
        }
    }
    
    func makeCoordinator() -> Mapcoordinator{
        return Mapcoordinator(parent: self)
        
    }
    
}

extension UBerMapViewRepresentable{
    
    class Mapcoordinator: NSObject,MKMapViewDelegate{
    
        // MARK - Properties
        
        let parent:UBerMapViewRepresentable
        var userLocationCoodinate: CLLocationCoordinate2D?
        
        // MARK - Life cycle
        
        
        init(parent: UBerMapViewRepresentable) {
            self.parent = parent
            super.init()
            
        }
        
        // MARK - MKMapViewDelegate
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoodinate = userLocation.coordinate
            let region = MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude,
                                               longitude: userLocation.coordinate.longitude),
                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        
        // MARK - Helpers
        
        func addAndSelectedAnnotation(withCoordinate coodinate: CLLocationCoordinate2D){
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coodinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
            
            parent.mapView.showAnnotations(parent.mapView.annotations, animated: true)
        }
        
        func configurePolyline(withDestinationCoodinate coodinate: CLLocationCoordinate2D){
            guard let userLocationCoodinate = self.userLocationCoodinate else { return }
            getDestinationRoute(from: userLocationCoodinate, to: coodinate){
                route in
                self.parent.mapView.addOverlay(route.polyline)
                
                
            }
        }
        
        
        func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                                 to destination: CLLocationCoordinate2D, completion: @escaping(MKRoute) -> Void){
            let userPlacemark = MKPlacemark(coordinate: userLocation)
            let destPlaceMark = MKPlacemark(coordinate: destination)
            let request = MKDirections.Request()
            request.source = MKMapItem(placemark: userPlacemark)
            request.destination = MKMapItem(placemark: destPlaceMark)
            let directions = MKDirections(request: request)
            
            directions.calculate{ response, error in
                if let error = error{
                    print("DEBUG: Failed to get direction with error \(error.localizedDescription)")
                    return
                }
                
                guard let route = response?.routes.first else { return }
                completion(route)
                
                
            }
        }
        
        
        
        
        
        
        
    }
}
