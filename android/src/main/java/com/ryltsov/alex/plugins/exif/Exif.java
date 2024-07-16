package com.ryltsov.alex.plugins.exif;

import android.net.Uri;
import android.util.Log;

import androidx.exifinterface.media.ExifInterface;

import java.io.IOException;

public class Exif {

    public String echo(String value) {
        Log.i("Echo", value);
        return value;
    }

    public void setCoordinates(String pathToImage, double latitude, double longitude) throws IOException {
        Log.i("pathToImage", pathToImage);
        Log.i("latitude", String.valueOf(latitude));
        Log.i("longitude", String.valueOf(longitude));
        // return value;

        Uri fileUri = Uri.parse(pathToImage);
        // Convert the file:// URI to a file path string
        String filePath = fileUri.getPath();
        // Create an ExifInterface instance using the file path
        ExifInterface exif = new ExifInterface(filePath);
        exif.setLatLong(latitude, longitude);
        // Save the changes
        exif.saveAttributes();
    }


    public double[] getCoordinates(String pathToImage) throws IOException {
        Log.i("pathToImage", pathToImage);

        Uri fileUri = Uri.parse(pathToImage);
        // Convert the file:// URI to a file path string
        String filePath = fileUri.getPath();
        // Create an ExifInterface instance using the file path
        ExifInterface exif = new ExifInterface(filePath);

        return exif.getLatLong();
    }

}
