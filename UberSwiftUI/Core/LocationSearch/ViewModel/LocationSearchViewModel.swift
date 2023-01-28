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
}

//

extension LocationSearchViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
