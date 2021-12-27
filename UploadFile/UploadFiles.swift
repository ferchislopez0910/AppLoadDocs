//
//  UploadFiles.swift
//  AppUploadDocs
//
//  Created by Valeria Castaño on 26/12/21.
//

import SwiftUI
import UIKit

let fileName = ""
let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)

let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")

let text = "my text for my text file"
do {
        try text.write(to: fileURL, atomically: true, encoding: .utf8)
} catch {
        print("failed with error: \(error)")
    }

do {
       let text2 = try String(contentsOf: fileURL, encoding: .utf8)
        print("Read back text: \(text2)")
    }
catch {
        print("failed with error: \(error)")
    }
