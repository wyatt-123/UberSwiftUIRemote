//
//  HomeView.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UBerMapViewRepresentable().ignoresSafeArea()
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
