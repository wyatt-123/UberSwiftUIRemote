//
//  LocationSearchViewModel.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/28.
//

import Foundation
import MapKit

class LocationSearchViewModel: NSObject, ObservableObject{
    // Mark: - Properties
    
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime: String?
    @Published var dropOffTime:String?
    
    private let searchCompleater  = MKLocalSearchCompleter()
    var queryFrament: String = "" {
        didSet{
            searchCompleater.queryFragment = queryFrament
        }
    }
    var userLocation: CLLocationCoordinate2D?
    
    // MARK: Lifecycle
    override init() {
        super.init()
        searchCompleater.delegate = self
        searchCompleater.queryFragment = queryFrament
    }
    
    func selectLocation(_ localSearch:MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localSearch){
            response, error in
            
            if let error = error {
                print("DEBUG :Location search failied with error \(error.localizedDescription)")
                return
            }
            
            
            guard let item = response?.mapItems.first else { return }
            let coordinate = item.placemark.coordinate
            self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: coordinate)
            
            print("DEBUG: Location coordinates \(coordinate)")
            
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion,
                        completion: @escaping MKLocalSearch.CompletionHandler){
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        
        search.start(completionHandler: completion)
    }
    
    func computeRidePrice(forType type: RideType) -> Double{
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0.0}
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
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
            self.configurePickupAndDropoffTimes(with: route.expectedTravelTime)
            completion(route)
            
            
        }
    }
    func configurePickupAndDropoffTimes(with expectedTravelTime: Double){
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        pickupTime = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date()+expectedTravelTime)
        
    }
}

// Mark: - MKLcoationPickupAndDropoffTimes()

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
