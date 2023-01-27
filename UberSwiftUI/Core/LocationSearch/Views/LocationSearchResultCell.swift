//
//  LocationSearchResultCell.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/27.
//

import SwiftUI

struct LocationSearchResultCell: View {
    var body: some View {
        HStack{
            Image(systemName:"mappin.circle.fill")
                .resizable()
                .foregroundColor(.blue)
                .accentColor(.white)
                .frame(width: 40,height: 40)
            
            VStack{
                Text("Starbucks coffee")
                    .font(.body)
                Text("新北市土城區")
                    .font(.system(size: 15))
                    .foregroundColor(.gray)
                
            }
        }
    }
}

struct LocationSearchResultCell_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchResultCell()
    }
}
