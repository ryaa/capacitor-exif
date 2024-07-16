import Foundation
import ImageIO
import MobileCoreServices
import CoreLocation

public enum PhotoError: Error {
    case invalidImageData
    case unableToCreateSource
    case unableToCreateDestination
    case unableToFinalizeDestination
    case unableToWriteData
    case missingGPSData
}

@objc public class Exif: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }

    func loadImageFromFilePathOLD(filePath: String) -> UIImage? {
        let imageURL = URL(fileURLWithPath: filePath)
        guard let imageData = try? Data(contentsOf: imageURL) else {
            return nil
        }
        return UIImage(data: imageData)
    }
    func loadImageFromFilePath2(filePath: String) throws -> UIImage {
        let imageURL = URL(fileURLWithPath: filePath)
        guard let imageData = try? Data(contentsOf: imageURL),
              let image = UIImage(data: imageData) else {
            throw PhotoError.invalidImageData
        }
        return image
    }
    func loadImageFromFilePath(filePath: String) throws -> UIImage {
        let imageURL = URL(fileURLWithPath: filePath)
        do {
            let imageData = try Data(contentsOf: imageURL)
            let image = UIImage(data: imageData)
            return image!
        } catch {
            print(error)
            throw PhotoError.invalidImageData
        }
    }

    
    func addCoordinatesToPhotoOLD(image: UIImage, latitude: Double, longitude: Double) -> Data? {
        guard let imageData = image.jpegData(compressionQuality: 1.0),
              let source = CGImageSourceCreateWithData(imageData as CFData, nil),
              let uniformTypeIdentifier = CGImageSourceGetType(source) else {
            return nil
        }
        
        let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: Any] ?? [:]
        
        // Create GPS Dictionary
        var gpsData: [String: Any] = [:]
        gpsData[kCGImagePropertyGPSLatitude as String] = latitude
        gpsData[kCGImagePropertyGPSLatitudeRef as String] = latitude >= 0 ? "N" : "S"
        gpsData[kCGImagePropertyGPSLongitude as String] = longitude
        gpsData[kCGImagePropertyGPSLongitudeRef as String] = longitude >= 0 ? "E" : "W"
        
        var updatedMetadata = metadata
        updatedMetadata[kCGImagePropertyGPSDictionary as String] = gpsData
        
        // Create a destination to write the updated image data
        let updatedImageData = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(updatedImageData, uniformTypeIdentifier, 1, nil) else {
            return nil
        }
        
        // Add the image with updated metadata
        CGImageDestinationAddImageFromSource(destination, source, 0, updatedMetadata as CFDictionary)
        
        // Finalize the destination
        guard CGImageDestinationFinalize(destination) else {
            return nil
        }
        
        return updatedImageData as Data
    }
    func addCoordinatesToPhoto(image: UIImage, latitude: Double, longitude: Double) throws -> Data {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else {
            throw PhotoError.invalidImageData
        }
        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else {
            throw PhotoError.unableToCreateSource
        }
        guard let uniformTypeIdentifier = CGImageSourceGetType(source) else {
            throw PhotoError.unableToCreateSource
        }
        
        let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: Any] ?? [:]
        
        // Create GPS Dictionary
        var gpsData: [String: Any] = [:]
        gpsData[kCGImagePropertyGPSLatitude as String] = latitude
        gpsData[kCGImagePropertyGPSLatitudeRef as String] = latitude >= 0 ? "N" : "S"
        gpsData[kCGImagePropertyGPSLongitude as String] = longitude
        gpsData[kCGImagePropertyGPSLongitudeRef as String] = longitude >= 0 ? "E" : "W"
        
        var updatedMetadata = metadata
        updatedMetadata[kCGImagePropertyGPSDictionary as String] = gpsData
        
        // Create a destination to write the updated image data
        let updatedImageData = NSMutableData()
        guard let destination = CGImageDestinationCreateWithData(updatedImageData, uniformTypeIdentifier, 1, nil) else {
            throw PhotoError.unableToCreateDestination
        }
        
        // Add the image with updated metadata
        CGImageDestinationAddImageFromSource(destination, source, 0, updatedMetadata as CFDictionary)
        
        // Finalize the destination
        guard CGImageDestinationFinalize(destination) else {
            throw PhotoError.unableToFinalizeDestination
        }
        
        return updatedImageData as Data
    }


    func saveImageToFilePathOLD(data: Data, filePath: String) -> Bool {
        let imageURL = URL(fileURLWithPath: filePath)
        do {
            try data.write(to: imageURL)
            return true
        } catch {
            print("Error saving image: \(error)")
            return false
        }
    }
    func saveImageToFilePath(data: Data, filePath: String) throws {
        let imageURL = URL(fileURLWithPath: filePath)
        do {
            try data.write(to: imageURL)
        } catch {
            throw PhotoError.unableToWriteData
        }
    }


    // @objc public func setCoordinates(_ pathToImage: String, _ latitude: Double, _ longitude: Double) throws -> void {
    func setCoordinates(_ pathToImage: String, _ latitude: Double, _ longitude: Double) throws {
        print(pathToImage)
        print(latitude)
        print(longitude)
        
        /*
        if let image = loadImageFromFilePath(filePath: filePath) {
            if let imageWithCoordinates = addCoordinatesToPhoto(image: image, latitude: latitude, longitude: longitude) {
                // let newFilePath = "/path/to/your/new_image_with_coordinates.jpg"
                let success = saveImageToFilePath(data: imageWithCoordinates, filePath: pathToImage)
                if success {
                    print("Image saved successfully with coordinates.")
                } else {
                    print("Failed to save the image.")
                    throw ExifError.saveFailed
                }
            } else {
                print("Failed to add coordinates to the image.")
            }
        } else {
            print("Failed to load image from file path.")
        }
        */
        
        let image = try loadImageFromFilePath(filePath: pathToImage)
        let imageWithCoordinates = try addCoordinatesToPhoto(image: image, latitude: latitude, longitude: longitude)
        // let newFilePath = "/path/to/your/new_image_with_coordinates.jpg"
        try saveImageToFilePath(data: imageWithCoordinates, filePath: pathToImage)
        print("Image saved successfully with coordinates.")
        
    }
    
    func getCoordinatesFromImageFile(filePath: String) throws -> CLLocationCoordinate2D {
        let imageURL = URL(fileURLWithPath: filePath)
        guard let imageData = try? Data(contentsOf: imageURL) else {
            throw PhotoError.invalidImageData
        }
        guard let source = CGImageSourceCreateWithData(imageData as CFData, nil) else {
            throw PhotoError.unableToCreateSource
        }
        
        let metadata = CGImageSourceCopyPropertiesAtIndex(source, 0, nil) as? [String: Any]
        guard let gpsData = metadata?[kCGImagePropertyGPSDictionary as String] as? [String: Any] else {
            throw PhotoError.missingGPSData
        }
        
        guard let latitude = gpsData[kCGImagePropertyGPSLatitude as String] as? Double,
              let latitudeRef = gpsData[kCGImagePropertyGPSLatitudeRef as String] as? String,
              let longitude = gpsData[kCGImagePropertyGPSLongitude as String] as? Double,
              let longitudeRef = gpsData[kCGImagePropertyGPSLongitudeRef as String] as? String else {
            throw PhotoError.missingGPSData
        }
        
        let lat = latitudeRef == "N" ? latitude : -latitude
        let lon = longitudeRef == "E" ? longitude : -longitude
        
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }

}
