export interface GetCoordinatesOptions {

  /**
   * The path to the image to set the coordinates to the EXIF metadata.
   * 
   * @since 6.0.0
   */
  pathToImage: string;

}

export interface SetCoordinatesOptions {

  /**
   * The path to the image to set the coordinates to the EXIF metadata.
   * 
   * @since 6.0.0
   */
  pathToImage: string;

  /**
   * The latitude of the image.
   *
   * @since 6.0.0
   */
  latitude: number;

  /**
   * The longitude of the image.
   *
   * @since 6.0.0
   */
  longitude: number;

}

export interface ExifPlugin {

  /**
   * Set the coordinates to the image EXIF metadata.
   *
   * @since 6.0.0
   */
  setCoordinates(options: SetCoordinatesOptions): Promise<void>;

  /**
   * Set the coordinates to the image EXIF metadata.
   *
   * @since 6.0.0
   */
  getCoordinates(options: GetCoordinatesOptions): Promise<{
      latitude: number;
      longitude: number;
    }>;

}
