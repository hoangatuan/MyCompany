//
//  OrderVoucherView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import SwiftUI

struct OrderVoucherView: View {
    var cost: Int
    var voucher: Voucher
    
    @State private var email: String = UserDataDefaults.shared.employeeEmail
    @State private var phoneNumber: String = ""
    @State private var address: String = ""
    @State private var note: String = ""
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject private var viewModel = OrderVoucherViewModel()
    
    var body: some View {
        VStack(spacing: 12.0) {
            CustomRightActionNavBar(navBarTitle: "Order", isShowBackButton: true, rightButtonTitle: "", actionRightButton: {
                
            })
            
            VStack(spacing: 12.0) {
                InputInformationCell(inputText: .constant(UserDataDefaults.shared.employeeName),
                                     title: "Fullname", placeholder: "", imageName: "", isDisableEditing: true)
                InputInformationCell(inputText: .constant(UserDataDefaults.shared.employeeAccount),
                                     title: "Account *", placeholder: "", imageName: "", isDisableEditing: true)
                InputInformationCell(inputText: $email,
                                     title: "Email *", placeholder: "", imageName: "icon_voucher_email", isDisableEditing: false)
                InputInformationCell(inputText: $phoneNumber,
                                     title: "Phone number *", placeholder: "", imageName: "icon_voucher_phone", isDisableEditing: false, isNumberInput: true)
                InputInformationCell(inputText: $address,
                                     title: "Delivery address *", placeholder: "", imageName: "icon_voucher_address", isDisableEditing: false)
                InputInformationCell(inputText: $note,
                                     title: "Note", placeholder: "Your message...", imageName: "icon_voucher_note", isDisableEditing: false)
                Spacer()
                
                Button(action: {
                    viewModel.pay(email: email, phoneNumber: phoneNumber, address: address, note: note, voucherCost: cost, voucherTitle: voucher.title, voucher: voucher)
                }, label: {
                    Text("SEND")
                        .foregroundColor(.white)
                }).padding()
                .frame(width: UIScreen.main.bounds.width - 32, alignment: .center)
                .background(Color(UIColor.ColorFF88A7))
                .cornerRadius(10.0)
                
                Spacer()
            }.padding()
        }
        .alert(isPresented: $viewModel.onShowAlert, content: {
            switch viewModel.payState {
                case .inputEmpty:
                    return Alert(title: Text(viewModel.payState.rawValue), message: nil,
                                 dismissButton: .default(Text("OK")))
                default:
                    return Alert(title: Text(viewModel.payState.rawValue), message: nil,
                                 dismissButton: Alert.Button.default(Text("OK"), action: {
                        presentationMode.wrappedValue.dismiss()
                    }))
            }
        })
        .navigationBarTitle("", displayMode: .inline)
        .navigationBarHidden(true)
    }
}

struct OrderVoucherView_Previews: PreviewProvider {
    static var previews: some View {
        OrderVoucherView(cost: 100, voucher: Voucher(title: "", imageURL: "", discountDescription: "", beforeCost: 100, afterCost: 200))
    }
}
