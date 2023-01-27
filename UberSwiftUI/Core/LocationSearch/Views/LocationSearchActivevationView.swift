//
//  LcoationSearchActivevationView.swift
//  UberSwiftUI
//
//  Created by 林家麒 on 2023/1/27.
//

import SwiftUI

struct LocationSearchActivevationView: View {
    var body: some View {
        HStack{
            Rectangle()
                .fill(Color.black)
                .frame(width: 8,height: 8)
                .padding(.horizontal)
            Text("where to go")
                .foregroundColor(Color(.darkGray))
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 64,height: 50)
        .background(
            Rectangle()
                .fill(Color.white)
                .shadow(color:.black, radius: 6)
        )
    }
}

struct LocationSearchActivevationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationSearchActivevationView()
    }
}
