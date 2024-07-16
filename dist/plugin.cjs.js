'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

const Exif = core.registerPlugin('Exif', {
    web: () => Promise.resolve().then(function () { return web; }).then(m => new m.ExifWeb()),
});

class ExifWeb extends core.WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
        return options;
    }
    async setCoordinates(_options) {
        throw new Error('setCoordinates is not supported on web');
    }
}

var web = /*#__PURE__*/Object.freeze({
    __proto__: null,
    ExifWeb: ExifWeb
});

exports.Exif = Exif;
//# sourceMappingURL=plugin.cjs.js.map
