//
//  PhotosHelper.swift
//  WeatherToday
//
//  Created by Alaattin Bedir on 11.06.2022.
//

import Foundation
import Photos
import UIKit

enum PhotosHelperError: Error {
    case unauthorized
    case other
}

class PhotosHelper {
    static let albumName = "MobilDeniz"
    static let shared = PhotosHelper()
    private let photoLibaryPermissionManager = PhotoLibraryPermission()

    var assetCollection: PHAssetCollection?

    func createAlbum(completion: @escaping (Bool, Error?) -> Void) {
        if let collection = fetchAssetCollectionForAlbum() {
            assetCollection = collection
            completion(true, nil)
            return
        }

        PHPhotoLibrary.shared().performChanges({
            // create an asset collection with the album name
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: PhotosHelper.albumName)
        }, completionHandler: { success, _ in
            if success {
                self.assetCollection = self.fetchAssetCollectionForAlbum()
                completion(true, nil)
            } else {
                completion(false, nil)
            }
        })
    }

    private func fetchAssetCollectionForAlbum() -> PHAssetCollection? {
        let fetchOptions = PHFetchOptions()
        fetchOptions.predicate = NSPredicate(format: "title = %@", PhotosHelper.albumName)
        if let album = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: fetchOptions).firstObject {
            return album
        } else if let withoutAlbumName = PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil).firstObject {
            return withoutAlbumName
        } else if let smartAlbum = PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .any, options: nil).firstObject {
            return smartAlbum
        } else {
            return PHAssetCollection.fetchAssetCollections(with: .moment, subtype: .any, options: nil).firstObject
        }
    }

    // Gonderilen fotografi MobilDeniz klasorune kaydeder. Izin alma ve album olusturma durumlarini isler.
    func saveToMobilDenizAlbum(_ image: UIImage, completionHandler: @escaping ((Bool, PhotosHelperError?) -> Void)) {
        photoLibaryPermissionManager.request { status in
            if status != .authorized {
                completionHandler(false, PhotosHelperError.unauthorized)
                return
            }

            self.createAlbum(completion: { success, _ in
                if !success {
                    completionHandler(false, PhotosHelperError.other)
                }

                self.savePhotoToAlbum(image: image, completionHandler: { success, _ in
                    if success {
                        completionHandler(true, nil)
                    } else {
                        completionHandler(false, PhotosHelperError.other)
                    }
                })
            })
        }
    }

    private func savePhotoToAlbum(image: UIImage, completionHandler: @escaping ((Bool, Error?) -> Swift.Void)) {
        guard let assetCollection = self.assetCollection else {
            completionHandler(false, PhotosHelperError.other)
            return
        }

        PHPhotoLibrary.shared().performChanges({
            let assetChangeRequest = PHAssetChangeRequest.creationRequestForAsset(from: image)
            let assetPlaceHolder: PHObjectPlaceholder = assetChangeRequest.placeholderForCreatedAsset.required()
            let albumChangeRequest = PHAssetCollectionChangeRequest(for: assetCollection)
            let enumeration: [PHObjectPlaceholder] = [assetPlaceHolder]
            albumChangeRequest.required().addAssets(enumeration as NSFastEnumeration)
        }, completionHandler: completionHandler)
    }
}
