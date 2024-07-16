import { WebPlugin } from '@capacitor/core';
import type { GetCoordinatesOptions, SetCoordinatesOptions, ExifPlugin } from './definitions';
export declare class ExifWeb extends WebPlugin implements ExifPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    setCoordinates(_options: SetCoordinatesOptions): Promise<void>;
    getCoordinates(_options: GetCoordinatesOptions): Promise<{
        value: {
            latitude: number;
            longitude: number;
        };
    }>;
}
