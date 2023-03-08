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
    @State var imageOffset:CGSize = .zero
    //MARK: - Function
    func resetImage(){
        return withAnimation(.spring()) {
            imageScale = 1
            imageOffset = .zero
        }
    }
    
    //MARK: - Content
    
    
    var body: some View {
        NavigationView{
            
            ZStack{
                Color.clear
                Image("magazine-front-cover")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                    .shadow(color: .black.opacity(0.2), radius: 12, x: 2, y: 2)
                    .offset(imageOffset)
                    .opacity(isAnimating ? 1:0)
                    .scaleEffect(imageScale)
                //MARK: - TapGesture
                    .onTapGesture(count: 2) {
                        withAnimation(.spring()){
                            if imageScale == 1{
                                imageScale = 5
                            }else{
                                resetImage()
                            }
                        }
                    }//:TapGesture
                //MARK: - DragGesture
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1.0)){
                                    imageOffset = value.translation
                                }
                            })
                            .onEnded({ _ in
                                if imageScale <= 1{
                                    resetImage()
                                }
                            })
                    
                    )//:DragGesture
                
            }//: ZStack
            .navigationBarTitle("Pinch & Zoom", displayMode: .inline)
            .onAppear{
                withAnimation(.linear(duration: 1)){
                    isAnimating = true
                }
            }
            
            .overlay(alignment: .topLeading) {
                InfoPanelView(offSet: imageOffset, scale: imageScale)
                    .padding(.horizontal)
                    .padding(.top, 30)
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
