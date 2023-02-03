//
//  RideType.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/2/2.
//

import Foundation

enum RideType : Int, CaseIterable, Identifiable {
    case uberX
    case black
    case uberXL
    
    var id: Int{ return rawValue}
    
    var description: String{
        switch self{
        case .uberX: return "uber - x"
        case .black: return "uber - black"
        case .uberXL: return "uber - x"
        }
    }
    
    var imageName:String {
        switch self {
        case .uberX: return "uber - x"
        case .black: return "uber - black"
        case .uberXL: return "uber - x"
        }
    }
}
