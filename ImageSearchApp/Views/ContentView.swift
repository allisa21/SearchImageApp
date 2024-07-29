//
//  ContentView.swift
//  ImageSearchApp
//
//  Created by Алла alla2104 on 25.07.24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ImageSearchViewModel()
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            HStack {
                
                if !viewModel.expand {
                    
                    Text("Search Image App")
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(.bold)
                }
                
                Spacer(minLength: 0)
                
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                    .onTapGesture {
                        
                        withAnimation {
                            viewModel.expand = true
                        }
                    }
                
                if viewModel.expand {
                    
                    TextField("Search...", text: $viewModel.searchText)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    if viewModel.searchText != "" {
                        Button(action: {
                            viewModel.searchImages()
                        }) {
                            Text("Поиск")
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    }
                    
                    Button(action: {
                        withAnimation {
                            viewModel.expand = false
                            viewModel.searchText = ""
                        }
                    }) {
                        Image(systemName: "xmark")
                            .font(.system(size: 15, weight: .bold))
                            .foregroundColor(.black)
                    }
                    .padding(.leading, 10)
                }
                
            }
            .padding(.top,
                     UIApplication.shared.windows.first?.safeAreaInsets.top)
            .padding()
            .background(Color.white)
            
            if viewModel.randomImages.isEmpty && viewModel.images.isEmpty {
                Spacer()
                
                Indicator()
                
                Spacer()
                
            } else {
                List(viewModel.images.isEmpty ? viewModel.randomImages : viewModel.images) { image in
                    VStack(alignment: .leading) {
                        AsyncImage(url: URL(string: image.url)) {phase in
                            if let image = phase.image {
                                image.resizable()
                            }
                        }
                        .aspectRatio(contentMode: .fill)
                        .cornerRadius(10)
                        .frame(width: UIScreen.main.bounds.width - 50)
                    }
                }
                .padding(.top)
            }
        }
        .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/))
        .edgesIgnoringSafeArea(.top)
    }
}

#Preview {
    ContentView()
}
