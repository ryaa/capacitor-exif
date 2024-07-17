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
public enum ImageProcessingError: Error {
    case invalidURL
    case failedToLoadImage
    case failedToCreateDestination
    case failedToSaveImage
}
public enum ImageReadError: Error {
    case invalidURL
    case failedToLoadImage
    case noGPSData
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
        // let imageURL = URL(fileURLWithPath: filePath)
        let imageURL = URL(string: filePath)
        do {
            let imageData = try Data(contentsOf: imageURL!)
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
            print("Error saving image: \(error)")
            throw PhotoError.unableToWriteData
        }
    }


    /*
    func setCoordinates(_ pathToImage: String, _ latitude: Double, _ longitude: Double) throws {
        print(pathToImage)
        print(latitude)
        print(longitude)
        
        let image = try loadImageFromFilePath(filePath: pathToImage)
        let imageWithCoordinates = try addCoordinatesToPhoto(image: image, latitude: latitude, longitude: longitude)
        // let newFilePath = "/path/to/your/new_image_with_coordinates.jpg"
        try saveImageToFilePath(data: imageWithCoordinates, filePath: pathToImage)
        print("Image saved successfully with coordinates.")
        
    }
    */
    /*
    func setCoordinatesOLD(_ pathToImage: String, _ latitude: Double, _ longitude: Double) throws {
        print(pathToImage)
        print(latitude)
        print(longitude)
        
        guard let fileURL = URL(string: filePath),
              let imageSource = CGImageSourceCreateWithURL(fileURL as CFURL, nil) else {
            print("Failed to load image")
            return
        }

        let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as Dictionary?
        print("Original metadata: \(String(describing: imageProperties))")

        var metadata = imageProperties ?? [:]

        var exifData = metadata[kCGImagePropertyExifDictionary as String] as? [String: Any] ?? [:]
        exifData[kCGImagePropertyExifUserComment as String] = "Updated comment"
        metadata[kCGImagePropertyExifDictionary as String] = exifData
        print("Modified metadata: \(metadata)")

        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, kUTTypeJPEG, 1, nil) else {
            print("Failed to create image destination")
            return
        }

        CGImageDestinationAddImageFromSource(destination, imageSource, 0, metadata as CFDictionary)

        if CGImageDestinationFinalize(destination) {
            print("Successfully saved image with updated metadata")
        } else {
            print("Failed to save image with updated metadata")
        }
        
    }
    */
    func setCoordinates(_ pathToImage: String, _ latitude: Double, _ longitude: Double) throws {
        // Convert the file path to a URL
        guard let fileURL = URL(string: pathToImage) else {
            throw ImageProcessingError.invalidURL
        }

        // Create an image source from the URL
        guard let imageSource = CGImageSourceCreateWithURL(fileURL as CFURL, nil) else {
            throw ImageProcessingError.failedToLoadImage
        }

        // Get the image metadata
        guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [String: Any] else {
            throw ImageProcessingError.failedToLoadImage
        }

        print("Original metadata: \(imageProperties)")

        // Create a mutable copy of the metadata
        var metadata = imageProperties

        // Modify the GPS metadata
        var gpsData = metadata[kCGImagePropertyGPSDictionary as String] as? [String: Any] ?? [:]
        gpsData[kCGImagePropertyGPSLatitude as String] = abs(latitude)
        gpsData[kCGImagePropertyGPSLatitudeRef as String] = (latitude >= 0.0) ? "N" : "S"
        gpsData[kCGImagePropertyGPSLongitude as String] = abs(longitude)
        gpsData[kCGImagePropertyGPSLongitudeRef as String] = (longitude >= 0.0) ? "E" : "W"
        metadata[kCGImagePropertyGPSDictionary as String] = gpsData

        print("Modified metadata: \(metadata)")

        // Create a destination to write the new image data
        guard let destination = CGImageDestinationCreateWithURL(fileURL as CFURL, kUTTypeJPEG, 1, nil) else {
            throw ImageProcessingError.failedToCreateDestination
        }

        // Add the image and the updated metadata to the destination
        CGImageDestinationAddImageFromSource(destination, imageSource, 0, metadata as CFDictionary)

        // Finalize the destination to write the data
        if !CGImageDestinationFinalize(destination) {
            throw ImageProcessingError.failedToSaveImage
        }

        print("Successfully saved image with updated metadata")
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
    
    func getCoordinates(filePath: String) throws -> CLLocationCoordinate2D {
        // Convert the file path to a URL
        guard let fileURL = URL(string: filePath) else {
            throw ImageReadError.invalidURL
        }

        // Create an image source from the URL
        guard let imageSource = CGImageSourceCreateWithURL(fileURL as CFURL, nil) else {
            throw ImageReadError.failedToLoadImage
        }

        // Get the image metadata
        guard let imageProperties = CGImageSourceCopyPropertiesAtIndex(imageSource, 0, nil) as? [String: Any] else {
            throw ImageReadError.failedToLoadImage
        }

        // Extract the GPS metadata
        guard let gpsData = imageProperties[kCGImagePropertyGPSDictionary as String] as? [String: Any],
              let latitude = gpsData[kCGImagePropertyGPSLatitude as String] as? Double,
              let latitudeRef = gpsData[kCGImagePropertyGPSLatitudeRef as String] as? String,
              let longitude = gpsData[kCGImagePropertyGPSLongitude as String] as? Double,
              let longitudeRef = gpsData[kCGImagePropertyGPSLongitudeRef as String] as? String else {
            throw ImageReadError.noGPSData
        }

        // Calculate the coordinates
        let finalLatitude = (latitudeRef == "N") ? latitude : -latitude
        let finalLongitude = (longitudeRef == "E") ? longitude : -longitude

        return CLLocationCoordinate2D(latitude: finalLatitude, longitude: finalLongitude)
    }

}
