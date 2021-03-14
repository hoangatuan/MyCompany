//
//  LeadingText.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/4/20.
//

import SwiftUI

struct LeadingText: View {
    var text: String
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(.black)
            Spacer()
        }
    }
}

struct LeadingText_Previews: PreviewProvider {
    static var previews: some View {
        LeadingText(text: "Hello").previewLayout(.sizeThatFits)
    }
}
