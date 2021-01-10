//
//  CopyAlertView.swift
//  Jot
//
//  Created by Josh Nelson on 1/9/21.
//

import SwiftUI

struct CopyAlertView: View {
    var body: some View {
        VStack {
            HStack {
                Text("Note copied to clipboard.")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .medium))
                Spacer()
                Image(systemName: "checkmark.circle.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .medium))
            }
            .padding(20)
            .background(Color.brand)
            .cornerRadius(8)
            
            Spacer()
        }
        .padding(16)

    }
}

struct CopyAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CopyAlertView()
    }
}
