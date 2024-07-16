import { registerPlugin } from '@capacitor/core';
const Exif = registerPlugin('Exif', {
    web: () => import('./web').then(m => new m.ExifWeb()),
});
export * from './definitions';
export { Exif };
//# sourceMappingURL=index.js.map