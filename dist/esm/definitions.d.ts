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
    lat: number;
    /**
     * The longitude of the image.
     *
     * @since 6.0.0
     */
    lng: number;
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
        lat: number;
        lng: number;
    } | undefined>;
}
