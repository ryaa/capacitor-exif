package com.ryltsov.alex.plugins.exif;

import com.getcapacitor.JSObject;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;
import com.getcapacitor.annotation.CapacitorPlugin;

@CapacitorPlugin(name = "Exif")
public class ExifPlugin extends Plugin {

    private Exif implementation = new Exif();

    @PluginMethod
    public void echo(PluginCall call) {
        String value = call.getString("value");

        JSObject ret = new JSObject();
        ret.put("value", implementation.echo(value));
        call.resolve(ret);
    }

    @PluginMethod(returnType = PluginMethod.RETURN_PROMISE)
    public void setCoordinates(final PluginCall call) {

        String pathToImage = call.getString("pathToImage");
        int pathToImage = call.getInt("latitude");
        int pathToImage = call.getInt("longitude");

        implementation.setCoordinates(pathToImage, latitude, longitude);

        call.resolve();

    }

}
