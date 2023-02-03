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
    @Published var selectedLocationCoordinate: CLLocationCoordinate2D?
    
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
            self.selectedLocationCoordinate = coordinate
            
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
        guard let destCoordinate = selectedLocationCoordinate else { return 0.0}
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude)
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }
    
    
    
}

//

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
