//
//  LocalFileManager.swift
//  NetflixSeries
//
//  Created by Vojtěch Kalivoda on 10.04.2023.
//

import Foundation
import SwiftUI

class LocalFileManager {
    
    static let shared = LocalFileManager()
    
    private let imagesFolderName = "profile_picture"
    @Published var profilePicture: UIImage? = nil
    
    private init() { }
    
    func deleteImage(imageName: String) {
        guard
            let url = getURLForImage(imageName: imageName),
            FileManager.default.fileExists(atPath: url.path)
            else { return print("Error getting deleted image url 🙃") }
        
        do {
            try FileManager.default.removeItem(at: url)
            print("succesfully deleted last profile picture!")
        } catch {
            print("error removing profile picture \(error)")
        }
        
        
    }
    
    func saveImage(image: UIImage, imageName: String) {
        // Create folder
        createFolderIfNeeded()
        
        // Get path for image
        guard
            let data = image.pngData(),
            let url = getURLForImage(imageName: imageName)
            else { return }
        
        // Save image to path
        do {
            try data.write(to: url)
        } catch {
            print("LocalFileManager error: \(error.localizedDescription)")
        }
    }
    
    func getImage(imageName: String) -> UIImage? {
        guard
            let url = getURLForImage(imageName: imageName),
            FileManager.default.fileExists(atPath: url.path) else {
            return nil
        }
        return UIImage(contentsOfFile: url.path)
    }
    
    private func createFolderIfNeeded() {
        guard let url = getURLForFolder() else { return }
        
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
            } catch {
                print("error creating folder directory: \(error.localizedDescription), for folderName\(imagesFolderName)")
            }
        }
    }
    
    private func getURLForFolder() -> URL? {
        guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        return url.appending(path: imagesFolderName)
    }
    
    private func getURLForImage(imageName: String) -> URL? {
        guard let folderURL = getURLForFolder() else {
            return nil
        }
        return folderURL.appending(path: imageName + ".png")
    }
    
}
