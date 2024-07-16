package com.ryltsov.alex.plugins.exif;

import android.util.Log;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "Exif")
public class ExifPlugin extends Plugin {

    private static final String TAG = "ExifPlugin";

    private final Exif implementation = new Exif();

    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", implementation.echo(value));
        call.resolve(ret);
    }

    @PluginMethod(returnType = PluginMethod.RETURN_PROMISE)
    public void setCoordinates(final PluginCall call) {
        
        if (!call.getData().has("pathToImage")) {
            call.reject("Must provide an pathToImage");
            return;
        }
        if (!call.getData().has("latitude")) {
            call.reject("Must provide an latitude");
            return;
        }
        if (!call.getData().has("longitude")) {
            call.reject("Must provide an longitude");
            return;
        }

        String pathToImage = call.getString("pathToImage");
        double latitude = call.getDouble("latitude");
        double longitude = call.getDouble("longitude");

        try {
            implementation.setCoordinates(pathToImage, latitude, longitude);
        } catch (Exception e) {
            Log.e(TAG, "Error setting GPS data to photo", e);
            call.reject(e.getLocalizedMessage(), null, e);
            return;
        }

        call.resolve();
    }

    @PluginMethod(returnType = PluginMethod.RETURN_PROMISE)
    public void getCoordinates(final PluginCall call) {
        
        if (!call.getData().has("pathToImage")) {
            call.reject("Must provide an pathToImage");
            return;
        }

        String pathToImage = call.getString("pathToImage");

        double[] latLong = null;
        try {
            latLong = implementation.getCoordinates(pathToImage);
        } catch (Exception e) {
            // throw new RuntimeException(e);
            Log.e(TAG, "Error getting GPS data to photo", e);
            call.reject(e.getLocalizedMessage(), null, e);
            return;
        }
        if ((latLong != null ? latLong.length : 0) == 2) {
            JSObject ret = new JSObject();
            double latitude = latLong[0];
            double longitude = latLong[1];
            ret.put("latitude", latitude);
            ret.put("longitude", longitude);
            call.resolve(ret);
            return;
        }
        call.resolve();
    }

}
