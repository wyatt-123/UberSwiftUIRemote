//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/26.
//

import SwiftUI

struct HomeView: View {
    @State private var showLocationSearchView = false
    var body: some View {
        ZStack (alignment: .top){
            UBerMapViewRepresentable()
                .ignoresSafeArea()
            if showLocationSearchView {
                LocationSearchView()
            } else {
                LocationSearchActivevationView().padding(.top, 72)
                    .onTapGesture {
                        withAnimation(.spring()){
                            showLocationSearchView.toggle()
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showLocationSearchView)
                .padding(.leading)
                .padding(.top, 4)
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
