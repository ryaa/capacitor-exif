import { WebPlugin } from '@capacitor/core';
import type { GetCoordinatesOptions, SetCoordinatesOptions, ExifPlugin } from './definitions';
export declare class ExifWeb extends WebPlugin implements ExifPlugin {
    setCoordinates(_options: SetCoordinatesOptions): Promise<void>;
    getCoordinates(_options: GetCoordinatesOptions): Promise<{
        lat: number;
        lng: number;
    } | undefined>;
}
