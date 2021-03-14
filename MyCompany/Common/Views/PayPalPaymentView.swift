//
//  PayPalPaymentView.swift
//  MyCompany
//
//  Created by Hoang Anh Tuan on 11/22/20.
//

import SwiftUI

struct PayPalPaymentView: UIViewControllerRepresentable {
    var payment: PayPalPayment
    var configuration: PayPalConfiguration
    var onFinish: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, PayPalPaymentDelegate {
        var parent: PayPalPaymentView
        
        init(_ parent: PayPalPaymentView) {
            self.parent = parent
        }
        
        func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
            debugPrint("payment info: \(completedPayment.confirmation)")
            debugPrint("payment info: \(completedPayment.amount)")
            debugPrint("payment info: \(completedPayment.localizedAmountForDisplay)")
            parent.presentationMode.wrappedValue.dismiss()
            parent.onFinish()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PayPalPaymentView>) -> PayPalPaymentViewController {
        let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: configuration, delegate: context.coordinator)
        return paymentViewController!
    }
    
    func updateUIViewController(_ uiViewController: PayPalPaymentViewController,
                                context: UIViewControllerRepresentableContext<PayPalPaymentView>) {
        
    }
}
