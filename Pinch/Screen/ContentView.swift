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
    @State var isDrawyerOpen:Bool = false
    
    let pages:[Page] = pagesData
    @State var pageIndex:Int = 1
  
    //MARK: - Function
    
    func currentPage() -> String{
        return pages[pageIndex - 1].imageName
    }
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
                Image(currentPage())
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
                //MARK: - Magnification
                    .gesture(
                        MagnificationGesture()
                            .onChanged({ value in
                                withAnimation(.linear(duration: 1)){
                                    if (imageScale >= 1 && imageScale <= 5){
                                        imageScale = value
                                    }else if (imageScale > 5){
                                        imageScale = 5
                                    }
                                }
                            })
                            .onEnded({ _ in
                                if imageScale > 5 {
                                    imageScale = 5
                                }else if imageScale <= 1{
                                    resetImage()
                                }
                            })
                    )
                
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
            .overlay(alignment: .bottom){
                //MARK: - Controls
                Group{
                    HStack{
                        //Scale Down
                        Button {
                            withAnimation(.spring()){
                                if imageScale > 1{
                                    imageScale -= 1
                                }else{
                                    resetImage()
                                }
                            }
                            
                        } label: {
                            ControlView(icon: "minus.magnifyingglass")
                        }
                        //Scale Fit
                        Button {
                            resetImage()
                        } label: {
                            ControlView(icon: "arrow.up.left.and.down.right.magnifyingglass")
                        }
                        //Scale Up
                        Button {
                            withAnimation(.spring()){
                                if imageScale < 5{
                                    imageScale += 1
                                }else{
                                    imageScale = 5
                                }
                            }
                        } label: {
                            ControlView(icon: "plus.magnifyingglass")
                        }

                    }
                    .padding(EdgeInsets(top: 12, leading: 20, bottom: 12, trailing: 20))
                    .background(.ultraThinMaterial)
                    .cornerRadius(12)
                    .opacity(isAnimating ? 1: 0)
                }//:Controls
                .padding(.bottom, 30)
            }
            //MARK: - Drawyer
            .overlay(alignment: .topTrailing, content: {
                HStack{
                    //Drawyer handle
                    Image(systemName:isDrawyerOpen ? "chevron.compact.right":"chevron.compact.left")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.secondary)
                        .frame(height: 40)
                        .padding(8)
                        .onTapGesture {
                            withAnimation(.easeOut){
                                isDrawyerOpen.toggle()
                                }
                        }
                    //Thumbnail
                    ForEach(pages) { page in
                        Image(page.thumbnail)
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                            .frame(width: 80)
                            .shadow(radius: 4)
                            .opacity(isDrawyerOpen ? 1:0)
                            .animation(.easeOut(duration: 0.5), value: isDrawyerOpen)
                            .onTapGesture {
//                                isAnimating = true
                                pageIndex = page.id
                            }
                    }
                    Spacer()
                }//:Drawyer
                .padding(EdgeInsets(top: 16, leading: 8, bottom: 16, trailing: 8))
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .opacity(isAnimating ? 1:0)
                .frame(width: 260)
                .offset(x:isDrawyerOpen ? 20 : 215)
                .padding(.top, UIScreen.main.bounds.height/12)
                })
            
        }//:Navigation View
        .navigationViewStyle(.stack)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
