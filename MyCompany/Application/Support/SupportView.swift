//
//  SupportView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 12/5/20.
//

import SwiftUI
import MessageUI

struct SupportView: View {
    @State private var isShowingMailView: Bool = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        VStack {
            CustomNavigationBar(isShowBackButton: true, backButtonTitle: "Support",
                                isShowSearchButton: false, stateShowView: .constant(RightActionStateModel()))
            
            Text("Need some help?")
                .font(Font.system(size: 30))
                .padding()
            
            Button(action: {
                CoreService.callNumber(phoneNumber: Constants.hotlineNumber)
            }, label: {
                Text("Hotline: \(Constants.hotlineNumber)")
                    .font(Font.system(size: 18))
                    .frame(width: UIScreen.main.bounds.width - 100, height: 40, alignment: .center)
            })
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color(UIColor.ColorFF88A7), lineWidth: 2))
            .padding(.vertical)
            
            let isSupportSendEmail = MFMailComposeViewController.canSendMail()
            Button(action: {
                isShowingMailView = true
            }, label: {
                Text("Email: supporter@company.com.vn")
                    .font(Font.system(size: 18))
                    .frame(width: UIScreen.main.bounds.width - 100, height: 40, alignment: .center)
            })
            .disabled(!isSupportSendEmail)
            .overlay(RoundedRectangle(cornerRadius: 20).stroke(isSupportSendEmail ? Color(UIColor.ColorFF88A7) : Color.gray,
                                                               lineWidth: 2))
            
            Spacer()
            
            Image("icon_support").resizable().aspectRatio(contentMode: .fill)
                
        }
        .sheet(isPresented: $isShowingMailView, content: {
            MailView(result: $result)
        })
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}
