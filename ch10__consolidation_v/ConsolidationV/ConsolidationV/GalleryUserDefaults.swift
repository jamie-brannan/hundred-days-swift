//
//  GalleryUserDefaults.swift
//  ConsolidationV
//
//  Created by Jamie Brannan on 25/03/2021.
//

import Foundation

class GalleryUserDefaults {
  static var galleryItemKey = "Item"
  
  static func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
  
  static func getGalleryItemURL(for photoName: String) -> URL {
    return getDocumentsDirectory().appendingPathComponent(photoName)
  }
  
  // run in background thread
  static func saveGalleryItem(items: [Photo]) {
    if let encodedGalleryItems = try? JSONEncoder().encode(items) {
      UserDefaults.standard.set(encodedGalleryItems, forKey: galleryItemKey)
    }
  }
  
  // run in background thread
  static func loadGalleryItems() -> [Photo] {
    if let loadedGalleryItems = UserDefaults.standard.object(forKey: galleryItemKey) as? Data {
      if let decodedGalleryItems = try? JSONDecoder().decode([Photo].self, from: loadedGalleryItems) {
        return decodedGalleryItems
      }
    }
    
    return [Photo]()
  }
}
