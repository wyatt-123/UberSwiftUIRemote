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
    override init() {
        super.init()
        searchCompleater.delegate = self
        searchCompleater.queryFragment = queryFrament
    }
    
    func selectLocation(_ localsearch:MKLocalSearchCompletion){
        locationSearch(forLocalSearchCompletion: localsearch){
            respondse, error in
            
            if let error = error {
                print("DEBUG :Location search failied with error \(error.localizedDescription)")
                return
            }
            
            
            guard let item = respondse?.mapItems.first else { return }
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
    
    
    
}

//

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
