//
//  Home.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 27/12/21.
//

import SwiftUI

struct Home: View {
    @EnvironmentObject var viewModel: AppViewModel
    
    @State var showMenu = false
    
    var body: some View {
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < 100 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        return NavigationView {
            GeometryReader { geometry in
                ZStack(alignment: .trailing) {
                    MainView(showMenu: self.$showMenu)
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .offset(x: self.showMenu ? geometry.size.width/2 : 0)
                        .disabled(self.showMenu ? true : false)
                    if self.showMenu {
                        MenuView()
                            .frame(width: geometry.size.width/2)
                            .transition(.move(edge: .trailing))
                    }
                }
                    .gesture(drag)
            }
                .navigationBarTitle(viewModel.client.nombre, displayMode: .inline)
                .navigationBarItems(trailing: (
                    Button(action: {
                        withAnimation {
                            self.showMenu.toggle()
                        }
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                ))
        }
    }
}

struct MainView: View {
    
    @Binding var showMenu: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
               self.showMenu = true
            }
        }) {
            HStack{
                Spacer()
                Image("home1")
                    .resizable()
                    .scaledToFit()
                    .frame(width:100,height: 50)
                    Text("Estas son las opciones que tenemos para ti:")
                        .padding(5)
                        .foregroundColor(Color(
                            red: 152/255,
                            green: 13/255,
                            blue:36/255))
            }
        }
    }
}

/**
 struct MainView: View {
     @EnvironmentObject var viewModel: AppViewModel
             
     @Binding var showMenu: Bool
             
     var body: some View {
         Button(action: {
             viewModel.signOut()
         }, label: {Text("back")
                 .padding()
                 .frame(width: 10, height: 5)
                 .foregroundColor(Color.white)
                 .background(Color(red: 152/255,
                                 green: 13/255,
                                 blue:36/255))
                 .cornerRadius(25)
             })

         VStack{
                 Text(viewModel.client.nombre)
                     .font(.largeTitle)
                     
                 VStack{
                     Image("home1")
                         .resizable()
                         .scaledToFit()
                         .frame(width:150,height: 150)
                     Text("Estas son las opciones que tenemos para ti:")
                         .padding(5)
                         .foregroundColor(Color(
                             red: 152/255,
                             green: 13/255,
                             blue:36/255))
                     }
                 }
             }
         }
     }
 }
 
 */
