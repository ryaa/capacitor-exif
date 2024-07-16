import { WebPlugin } from '@capacitor/core';

import type { ExifOptions, ExifPlugin } from './definitions';

export class ExifWeb extends WebPlugin implements ExifPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
  public async setCoordinates(_options: ExifOptions): Promise<void> {
    throw new Error('setCoordinates is not supported on web');
  }
}
