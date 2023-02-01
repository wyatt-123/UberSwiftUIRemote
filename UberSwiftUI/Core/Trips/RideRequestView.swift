//
//  RideRequestView.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/2/1.
//

import SwiftUI

struct RideRequestView: View {
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
            // trip info view
            HStack {
                VStack{
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 8, height: 8)
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 32)
                    Rectangle()
                        .fill(.black)
                        .frame(width: 8, height: 8)
                }
                VStack(alignment: .leading, spacing: 24){
                    HStack{
                    Text("目前位置")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("1:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                    }.padding(.bottom, 10)
                    
                    HStack{
                    Text("StarBucks Coffee")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("2:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                    }
                    
                    
                }
            }
            // ride type selection view
            
            // payment option view
            
            // request ride button
        }
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
