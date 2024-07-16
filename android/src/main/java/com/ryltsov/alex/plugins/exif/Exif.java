package com.ryltsov.alex.plugins.exif;

import android.util.Log;

public class Exif {

    public String echo(String value) {
        Log.i("Echo", value);
        return value;
    }

    public String setCoordinates(String pathToImage, int latitude, int longitude) {
        Log.i("pathToImage", pathToImage);
        Log.i("latitude", latitude);
        Log.i("longitude", longitude);
        // return value;
    }

}
