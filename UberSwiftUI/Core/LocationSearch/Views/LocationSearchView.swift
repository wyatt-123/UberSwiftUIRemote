//
//  LocationSearchView.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/27.
//

import SwiftUI

struct LocationSearchView: View {
    @State private var statLocationText = ""
    @State private var destinationLocationText = ""
    @StateObject private var viewModel = LocationSearchViewModel()
    var body: some View {
        VStack{
            // headview
            HStack{
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 6, height: 6)
                }
                
                VStack{
                    TextField("Current location",text: $statLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    TextField("Where to go",text: $viewModel.queryFrament)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                    
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            
            // listview
            
            ScrollView{
                VStack(alignment: .leading){
                    ForEach(viewModel.results, id: \.self){ result in
                        LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        
                    }
                }
            }
        }.background(Color.white)
    }
}

struct LocationSearchView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchView()
    }
}
