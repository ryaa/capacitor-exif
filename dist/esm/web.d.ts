import { WebPlugin } from '@capacitor/core';
import type { ExifOptions, ExifPlugin } from './definitions';
export declare class ExifWeb extends WebPlugin implements ExifPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
    setCoordinates(_options: ExifOptions): Promise<void>;
}
