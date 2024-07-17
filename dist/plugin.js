var capacitorExif = (function (exports, core) {
    'use strict';

    const Exif = core.registerPlugin('Exif', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.ExifWeb()),
    });

    class ExifWeb extends core.WebPlugin {
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        async setCoordinates(_options) {
            throw new Error('setCoordinates is not supported on web');
        }
        // eslint-disable-next-line @typescript-eslint/no-unused-vars
        async getCoordinates(_options) {
            throw new Error('getCoordinates is not supported on web');
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        ExifWeb: ExifWeb
    });

    exports.Exif = Exif;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
