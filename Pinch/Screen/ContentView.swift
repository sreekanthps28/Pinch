//
//  ContentView.swift
//  Pinch
//
//  Created by SREEKANTH PS on 08/03/2023.
//

import SwiftUI

struct ContentView: View {
    
    //MARK: - Property
    @State var isAnimating:Bool = false
    @State var imageScale:CGFloat = 1.0
    //MARK: - Function
    
    
    //MARK: - Content
    
    
    var body: some View {
        NavigationView{
            ZStack{
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .opacity(isAnimating ? 1:0)
                    .scaleEffect(imageScale)
                    .onTapGesture(count: 2) {
                        withAnimation(.spring()){
                            imageScale = (imageScale == 1) ? 5 : 1
                        }
                    }
                
            }//: ZStack
            .navigationBarTitle("Pinch & Zoom", displayMode: .inline)
            .onAppear{
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            }
        }//:Navigation View
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
