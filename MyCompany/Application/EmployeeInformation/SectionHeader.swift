//
//  SectionHeader.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/12/20.
//

import SwiftUI

struct SectionHeader: View {
    var sectionTitle: String = ""
    @State private var isShow: Bool = true
    @Binding var dataDisplay: [EmployeePresentData]
    
    var body: some View {
        VStack {
            HStack {
                Text(sectionTitle)
                    .padding()
                Spacer()
                Button(action: {
                    withAnimation(.easeIn(duration: 0.3)) {
                        isShow.toggle()
                    }
                }, label: {
                    Image("icon_arrow_expand")
                        .resizable()
                        .frame(width: 28, height: 28, alignment: .center)
                        .padding()
                }).rotationEffect(.degrees(isShow ? 0 : 180))
            }.background(Color(UIColor.ColorE9E9E9))
            
            if isShow {
                ForEach(dataDisplay) { data in
                    InfoRow(data: data)
                }
            }
        }
    }
}

struct SectionHeader_Previews: PreviewProvider {
    @State static var mockData: [EmployeePresentData] = [
        EmployeePresentData(title: "Full name", content: "Hoang Anh Tuan"),
        EmployeePresentData(title: "Date of birth", content: "27 Dec  1998")
    ]
    
    static var previews: some View {
        SectionHeader(dataDisplay: $mockData)
    }
}
