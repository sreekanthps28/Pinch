//
//  ControlView.swift
//  Pinch
//
//  Created by SREEKANTH PS on 08/03/2023.
//

import SwiftUI

struct ControlView: View {
    var icon:String
    var body: some View {
        Image(systemName: icon)
            .font(.system(size: 36))
    }
}

struct ControlView_Previews: PreviewProvider {
    static var previews: some View {
        ControlView(icon: "minus.magnifyingglass")
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
