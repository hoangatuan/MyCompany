//
//  NewLoadMoreView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/24/20.
//

import SwiftUI

struct NewLoadMoreView: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            Text("View more")
                .padding()
        })
    }
}

struct NewLoadMoreView_Previews: PreviewProvider {
    static var previews: some View {
        NewLoadMoreView(action: {})
    }
}
