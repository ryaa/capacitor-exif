export interface ExifOptions {

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
  echo(options: { value: string }): Promise<{ value: string }>;

  /**
   * Set the coordinates to the image EXIF metadata.
   *
   * @since 6.0.0
   */
  setCoordinates(options: ExifOptions): Promise<void>;

}
