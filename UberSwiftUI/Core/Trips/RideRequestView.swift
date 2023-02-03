//
//  RideRequestView.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/2/1.
//

import SwiftUI

struct RideRequestView: View {
    @State private var selectedRideType: RideType = .uberX
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    var body: some View {
        VStack{
            Capsule()
                .foregroundColor(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
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
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.gray)
                        Spacer()
                        Text("1:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                    }.padding(.bottom, 10)
                    
                    HStack{
                        Text("StarBucks Coffee")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        Text("2:30 PM")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.gray)
                        
                    }
                }.padding(.leading, 8)
            }.padding()
            
            Divider()
            
            
            // ride type selection view
            Text("推薦的旅程")
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding()
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            ScrollView(.horizontal){
                HStack(spacing: 12) {
                    ForEach(RideType.allCases){ type in
                        VStack(alignment: .leading){
                            Image(type.imageName)
                                .resizable()
                                .scaledToFit()
                            VStack(alignment:.leading,spacing:4){
                                Text(type.description)
                                    .font(.system(size: 14, weight: .semibold))
                                Text("$\(locationViewModel.computeRidePrice(forType: type))") .font(.system(size: 14, weight: .semibold))
                            }.padding()
                            
                        }
                        
                        .frame(width: 112, height: 140)
                        .foregroundColor( type == selectedRideType ? .white : .black)
                        .background(Color( type == selectedRideType ? .systemBlue : .systemGroupedBackground))
                        .scaleEffect(type == selectedRideType ? 1.15 : 1.0 )
                        
                        .cornerRadius(10)
                        .onTapGesture {
                            withAnimation(.spring()){
                                selectedRideType = type
                            }
                        }
                        
                        
                    }
                }
            }.padding(.horizontal)
            
            Divider().padding(.vertical, 8)
            
            // payment option view
            
            HStack(spacing: 12){
                
                Text("Visa")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .padding(6)
                    .background(Color(.systemBlue))
                    .fontWeight(.semibold)
                    .cornerRadius(4)
                    .foregroundColor(.white)
                    .padding(.leading)
                
                Text("****1234")
                    .fontWeight(.bold)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .imageScale(.medium)
                    .padding()
            }
            .frame(height: 50)
            .background(Color(.systemGroupedBackground))
            .cornerRadius(10)
            .padding(.horizontal)
            
            // request ride button
            
            Button{
                
            } label: {
                Text("確認旅程")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding(.bottom, 24)
        .background(.white)
        .cornerRadius(12)
    }
}

struct RideRequestView_Previews: PreviewProvider {
    static var previews: some View {
        RideRequestView()
    }
}
