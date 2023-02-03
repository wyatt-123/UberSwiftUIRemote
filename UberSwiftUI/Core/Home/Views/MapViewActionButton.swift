//
//  MapViewActionButton.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/27.
//

import SwiftUI

struct MapViewActionButton: View {
    //@Binding var showLocationSearchView: Bool
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: LocationSearchViewModel
    var body: some View {
        Button{
            withAnimation(.spring()){
                actionForState(mapState)
            }
        } label: {
            
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundColor(Color.black)
                .padding()
                .background(.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }.frame(minWidth: 4,maxWidth: .infinity,minHeight: 40,alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState){
        switch state {
        case .noInput:
            print("DEBUG: No input")
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected,.polylineAdded:
            mapState = .noInput
            viewModel.selectedUberLocation = nil
        }
    }
        
    func imageNameForState(_ state: MapViewState) -> String{
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation, .locationSelected, .polylineAdded:
            return "arrow.left"
        default:
            return "line.3.horizontal"
        }
        
        
        
    }
}

struct MapViewActionButton_Previews: PreviewProvider {
    static var previews: some View {
        MapViewActionButton(mapState: .constant(.noInput))
    }
}
