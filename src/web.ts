import { WebPlugin } from '@capacitor/core';

import type { GetCoordinatesOptions, SetCoordinatesOptions, ExifPlugin } from './definitions';

export class ExifWeb extends WebPlugin implements ExifPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  public async setCoordinates(_options: SetCoordinatesOptions): Promise<void> {
    throw new Error('setCoordinates is not supported on web');
  }
  // eslint-disable-next-line @typescript-eslint/no-unused-vars
  public async getCoordinates(_options: GetCoordinatesOptions): Promise<{
    value: {
      latitude: number;
      longitude: number;
    }
  }> {
    throw new Error('getCoordinates is not supported on web');
  }
}
