import { WebPlugin } from '@capacitor/core';
export class ExifWeb extends WebPlugin {
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    async setCoordinates(_options) {
        throw new Error('setCoordinates is not supported on web');
    }
    // eslint-disable-next-line @typescript-eslint/no-unused-vars
    async getCoordinates(_options) {
        throw new Error('getCoordinates is not supported on web');
    }
}
//# sourceMappingURL=web.js.map