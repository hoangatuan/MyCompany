//
//  CustomRightActionNavBar.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/16/20.
//

import SwiftUI

struct CustomRightActionNavBar: View {
    var navBarTitle: String
    var isShowBackButton: Bool
    var rightButtonTitle: String
    var actionRightButton: (() -> Void)
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack {
            ZStack {
                Text(navBarTitle)
                    .font(.system(size: 20))
                    .bold()
                
                HStack {
                    if isShowBackButton {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }, label: {
                            Image(systemName: "chevron.backward")
                                .resizable()
                                .frame(width: 16, height: 20)
                        }).frame(width: 32, height: 32)
                        .foregroundColor(.black)
                    }
                    
                    Spacer()
                    Button(action: {
                        actionRightButton()
                    }, label: {
                        Text(rightButtonTitle)
                            .font(.system(size: 16))
                    }).padding()
                }
            }
            
            Divider()
                .background(Color.white.shadow(color: Color.gray, radius: 2, x: 0, y: 1))
            // Way to set shadow not impact child view
        }
    }
}

struct CustomRightActionNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomRightActionNavBar(navBarTitle: "Meeting Room", isShowBackButton: true, rightButtonTitle: "History", actionRightButton: {})
//            .previewLayout(.sizeThatFits)
    }
}
