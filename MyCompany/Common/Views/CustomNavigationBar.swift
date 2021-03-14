//
//  CustomNavigationBar.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 10/26/20.
//

import SwiftUI

struct RightActionStateModel {
    var onShowSearchView: Bool = false
    var onShowNotificationView: Bool = false
}

struct CustomNavigationBar: View {
    var isShowBackButton: Bool
    var backButtonTitle: String
    var isShowSearchButton: Bool
    
    @Binding var stateShowView: RightActionStateModel
    @State private var avatarImage: UIImage = UIImage(named: "no_img")!
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
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
                    
                    Text(backButtonTitle)
                } else {
                    Image(uiImage: avatarImage)
                        .resizable()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                    
                    let welcomeText = Date().getCurrentHour() < 12 ? "Good morning" : "Good evening"
                    if UserDataDefaults.shared.isAdministrator {
                        Text("\(welcomeText)")
                            .font(Font.custom("OpticSans-201Book", size: 16))
                    } else {
                        Text("\(welcomeText), \(UserDataDefaults.shared.employeeAccount)")
                            .font(Font.custom("OpticSans-201Book", size: 16))
                    }
                }
                
                Spacer()
                
                if isShowSearchButton {
                    Button(action: {
                        stateShowView.onShowNotificationView = true
                    }, label: {
                        Image("icon_employee_notification")
                            .resizable()
                            .frame(width: 28, height: 28)
                    }).frame(width: 32, height: 32)
                    .background(Color.yellow)
                    .cornerRadius(16)
                    
                    Button(action: {
                        stateShowView.onShowSearchView = true
                    }, label: {
                        Image("icon_new_search")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }).frame(width: 32, height: 32)
                    .background(Color.yellow)
                    .cornerRadius(16)
                }
            }.padding(EdgeInsets(top: 4.0, leading: 8.0, bottom: 4.0, trailing: 8.0))
            
            Divider().frame(width: UIScreen.main.bounds.width, height: 1, alignment: .center)
                .background(Color.gray.shadow(color: .gray, radius: 1, x: 0.0, y: 1))
        }.onAppear(perform: {
            requestGetAvatarImage(urlString: UserDataDefaults.shared.employeeAvatarImageUrl)
        })
    }
    
    private func requestGetAvatarImage(urlString: String) {
        ImageDownloader.startDownloadImage(urlString: urlString,
                                           identifier: UserDataDefaults.shared.employeeID,
                                           type: .avatarImage, onSuccess: { [self] in
                                                let photoCachePath = LocalFileManager.shared.getPhotoCachePath(identifier: UserDataDefaults.shared.employeeID, type: .avatarImage)
                                                if let image = UIImage(contentsOfFile: photoCachePath) {
                                                    self.avatarImage = image
                                                }
                                           })
    }
}

struct CustomNavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavigationBar(isShowBackButton: false, backButtonTitle: "Back", isShowSearchButton: true, stateShowView: .constant(RightActionStateModel()))
//            .previewLayout(.sizeThatFits)
    }
}
