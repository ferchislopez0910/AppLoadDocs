//
//  MenuView.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 27/12/21.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "doc.richtext")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Enviar Documentos")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            HStack {
                Image(systemName: "doc.viewfinder")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Ver Documentos")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
                .padding(.top, 30)
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Oficinas")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            Spacer()
        }
            .padding()
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}


/**


struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "doc.richtext")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Enviar Documentos")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 100)
            HStack {
                Image(systemName: "doc.viewfinder")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Ver Documentos")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
                .padding(.top, 30)
            HStack {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.gray)
                    .imageScale(.large)
                Text("Oficinas")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding(.top, 30)
            Spacer()
        }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(red: 32/255, green: 32/255, blue: 32/255))
            .edgesIgnoringSafeArea(.all)
    }
}

struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView()
    }
}
*/
