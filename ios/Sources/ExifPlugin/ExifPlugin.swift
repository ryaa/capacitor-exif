import Foundation
import Capacitor

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(ExifPlugin)
public class ExifPlugin: CAPPlugin, CAPBridgedPlugin {
    public let identifier = "ExifPlugin"
    public let jsName = "Exif"
    public let pluginMethods: [CAPPluginMethod] = [
        CAPPluginMethod(name: "echo", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "setCoordinates", returnType: CAPPluginReturnPromise),
        CAPPluginMethod(name: "getCoordinates", returnType: CAPPluginReturnPromise)
    ]
    
    //case invalidImageData
    //case unableToCreateSource
    //case unableToCreateDestination
    //case unableToFinalizeDestination
    //case unableToWriteData
    
    // Message constants
    static let INVALID_IMAGE_DATA_ERROR = "Invalid resultType option";
    static let UNABLE_TO_CREATE_SOURCE_ERROR = "Unable to create image source";
    static let UNABLE_TO_CREATE_DESTINATION_ERROR = "Unable to create image destination";
    static let UNABLE_TO_FINALIZE_DESTINATION_ERROR = "Unable to finaize image destination";
    static let UNABLE_TO_WRITE_DATA_ERROR = "Unable to write image data";
    static let UNEXPECTED_ERROR = "Unable to write image data";
    
    private let implementation = Exif()

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

    @objc func setCoordinates(_ call: CAPPluginCall) {


//        guard (pathToImage != nil) else {
//            call.reject("pathToImage is required")
//            return
//        }
        guard let pathToImage = call.options["pathToImage"] as? String else {
            call.reject("Must provide an pathToImage")
            return
          }
//        guard (latitude != nil) else {
//            call.reject("latitude is required")
//            return
//        }
        guard let latitude = call.options["latitude"] as? Double else {
            call.reject("Must provide an latitude")
            return
          }
//        guard (longitude != nil) else {
//            call.reject("longitude is required")
//            return
//        }
        guard let longitude = call.options["longitude"] as? Double else {
            call.reject("Must provide an longitude")
            return
          }
        
//        let pathToImage = call.getString("pathToImage")
//        let latitude = call.getDouble("latitude")
//        let longitude = call.getDouble("longitude")

        do {
            try implementation.setCoordinates(pathToImage, latitude, longitude)
            call.resolve()
        } catch PhotoError.invalidImageData {
            call.reject(ExifPlugin.INVALID_IMAGE_DATA_ERROR)
        } catch PhotoError.unableToCreateSource {
            call.reject(ExifPlugin.UNABLE_TO_CREATE_SOURCE_ERROR)
        } catch PhotoError.unableToCreateDestination {
            call.reject(ExifPlugin.UNABLE_TO_CREATE_DESTINATION_ERROR)
        } catch PhotoError.unableToFinalizeDestination {
            call.reject(ExifPlugin.UNABLE_TO_FINALIZE_DESTINATION_ERROR)
        } catch PhotoError.unableToWriteData {
            call.reject(ExifPlugin.UNABLE_TO_WRITE_DATA_ERROR)
        } catch {
            // All other errors
            // call.reject(ExifPlugin.UNEXPECTED_ERROR)
            call.reject(error.localizedDescription, nil, error)
        }



    }
    
    @objc func getCoordinates(_ call: CAPPluginCall) {
        
        guard let pathToImage = call.options["pathToImage"] as? String else {
            call.reject("Must provide an pathToImage")
            return
        }
        
        do {
            // let filePath = "/path/to/your/image.jpg"
            let coordinates = try implementation.getCoordinates(filePath: pathToImage)
            print("Latitude: \(coordinates.latitude), Longitude: \(coordinates.longitude)")
            call.resolve([
              "latitude": coordinates.latitude,
              "longitude": coordinates.longitude
            ])
        }
//        catch {
//            print("Failed to get coordinates with error: \(error)")
//        }
        catch PhotoError.invalidImageData {
            call.reject(ExifPlugin.INVALID_IMAGE_DATA_ERROR)
        } catch PhotoError.unableToCreateSource {
            call.reject(ExifPlugin.UNABLE_TO_CREATE_SOURCE_ERROR)
        } catch PhotoError.missingGPSData {
            // call.reject(ExifPlugin.UNABLE_TO_WRITE_DATA_ERROR)
            call.resolve()
        } catch {
            // All other errors
            // call.reject(ExifPlugin.UNEXPECTED_ERROR)
            call.reject(error.localizedDescription, nil, error)
        }
        
    }

}
