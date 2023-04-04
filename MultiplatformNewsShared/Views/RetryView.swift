//
//  RetryView.swift
//  MultiplatformNewsApp
//
//  Created by Andrei Panasenko on 29.03.2023.
//

import SwiftUI

struct RetryView: View {
    let text: String
    let retryAction: () -> ()
    var body: some View {
        VStack(spacing: 8) {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button {
                retryAction()
            } label: {
                Text("Try again") // todo localize
            }

        }
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(text: "An error") {
            
        }
    }
}
