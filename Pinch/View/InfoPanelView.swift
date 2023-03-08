//
//  InfoPanelView.swift
//  Pinch
//
//  Created by SREEKANTH PS on 08/03/2023.
//

import SwiftUI

struct InfoPanelView: View {
    var offSet:CGSize
    var scale:CGFloat
    
    @State var isInfoPanelVisible:Bool = false
    
    var body: some View {
        HStack{
            //MARK: - HotSpot
            Image(systemName: "circle.circle")
                .symbolRenderingMode(.hierarchical)
                .resizable()
                .frame(width: 30, height: 30)
                .onLongPressGesture(minimumDuration: 1.0){
                    isInfoPanelVisible.toggle()
                }
            
            Spacer()
            
            //MARK: - InfoPanel
            HStack(spacing: 2) {
                Image(systemName: "arrow.up.left.and.arrow.down.right")
                Text("\(scale)")
                Spacer()
                
                Image(systemName: "arrow.left.and.right")
                Text("\(offSet.width)")
                Spacer()
                
                Image(systemName: "arrow.up.and.down")
                Text("\(offSet.height)")
                Spacer()
            }//:InfoPanel
            .font(.footnote)
            .padding(8)
            .background(.ultraThinMaterial)
            .cornerRadius(8)
            .frame(maxWidth: 420)
            .opacity(isInfoPanelVisible ? 1.0 : 0)
            Spacer()
        }
    }
}

struct InfoPanelView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPanelView(offSet: .zero, scale: 1)
            .preferredColorScheme(.dark)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
