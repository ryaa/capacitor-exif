import { WebPlugin } from '@capacitor/core';
export class ExifWeb extends WebPlugin {
    async echo(options) {
        console.log('ECHO', options);
        return options;
    }
    async setCoordinates(_options) {
        throw new Error('setCoordinates is not supported on web');
    }
}
//# sourceMappingURL=web.js.map