//
//  OrderVoucherViewModel.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import Foundation
import Braintree

class OrderVoucherViewModel: NSObject, ObservableObject {
    enum State: String {
        case inputEmpty = "Vui lòng nhập đầy đủ các trường còn trống trước khi đặt hàng"
        case invalidPayment = "Đặt hàng không hợp lệ. Vui lòng thử lại sau"
        case paySuccess = "Đặt hàng thành công!"
        case payFailed = "Đặt hàng thất bại. Vui lòng thử lại sau"
    }
    
    @Published var onShowAlert: Bool = false
    var payState: State = .inputEmpty
    var braintreeClient: BTAPIClient?
    
    override init() {
        super.init()
        startCheckout()
    }
    
    func startCheckout() {
        braintreeClient = BTAPIClient(authorization: "sandbox_kt3zf2fp_46fxsmjprxjn2yfs")!
    }
    
    func pay(email: String, phoneNumber: String, address: String, note: String, voucherCost: Int, voucherTitle: String, voucher: Voucher) {
        if isInputEmpty(email: email, phoneNumber: phoneNumber, address: address) {
            payState = .inputEmpty
            onShowAlert = true
            return
        }
        
        let priceUSD = round(Double(voucherCost) * Constants.exchangeRateToUSD * 100) / 100
        let payPalDriver = BTPayPalDriver(apiClient: braintreeClient!)
        
        let request = BTPayPalRequest(amount: "\(priceUSD)")
        request.currencyCode = "USD"
        
        payPalDriver.requestOneTimePayment(request) { (tokenizedPayPalAccount, error) in
            if let _ = tokenizedPayPalAccount {
                self.pushToServer(email: email, phoneNumber: phoneNumber, address: address, note: note,
                             voucherID: voucher.voucherID, voucherCost: voucherCost, voucherTitle: voucherTitle, imageURL: voucher.imageURL)
            } else if let error = error {
                print("Error paypal: \(error)")
                self.payState = .invalidPayment
                self.onShowAlert = true
            } else {
                print("Cancel payment")
            }
        }
    }
    
    func pushToServer(email: String, phoneNumber: String, address: String, note: String, voucherID: String , voucherCost: Int, voucherTitle: String, imageURL: String) {
        let buyDate = Date().convertToFormat(format: .iso)
        VoucherService.shared.buyVoucher(email: email, phone: phoneNumber, address: address, note: note, cost: voucherCost, voucherTitle: voucherTitle, voucherID: voucherID,
                                         buyDate: buyDate, imageURL: imageURL, completion: { [weak self] in
                                            self?.payState = .paySuccess
                                            self?.onShowAlert = true
                                          })
    }
    
    private func isInputEmpty(email: String, phoneNumber: String, address: String) -> Bool {
        return email.trimmingCharacters(in: .whitespaces) == ""
            || phoneNumber.trimmingCharacters(in: .whitespaces) == ""
            || address.trimmingCharacters(in: .whitespaces) == ""
    }
}
