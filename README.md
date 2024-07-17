# @capacitor-community/exif

This plugin offers utility functions for interacting with jpeg exif metadata

## Install

```bash
npm install @capacitor-community/exif
npx cap sync
```

## API

<docgen-index>

* [`setCoordinates(...)`](#setcoordinates)
* [`getCoordinates(...)`](#getcoordinates)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### setCoordinates(...)

```typescript
setCoordinates(options: SetCoordinatesOptions) => Promise<void>
```

Set the coordinates to the image EXIF metadata.

| Param         | Type                                                                    |
| ------------- | ----------------------------------------------------------------------- |
| **`options`** | <code><a href="#setcoordinatesoptions">SetCoordinatesOptions</a></code> |

**Since:** 6.0.0

--------------------


### getCoordinates(...)

```typescript
getCoordinates(options: GetCoordinatesOptions) => Promise<{ latitude: number; longitude: number; } | undefined>
```

Set the coordinates to the image EXIF metadata.

| Param         | Type                                                                    |
| ------------- | ----------------------------------------------------------------------- |
| **`options`** | <code><a href="#getcoordinatesoptions">GetCoordinatesOptions</a></code> |

**Returns:** <code>Promise&lt;{ latitude: number; longitude: number; }&gt;</code>

**Since:** 6.0.0

--------------------


### Interfaces


#### SetCoordinatesOptions

| Prop              | Type                | Description                                                        | Since |
| ----------------- | ------------------- | ------------------------------------------------------------------ | ----- |
| **`pathToImage`** | <code>string</code> | The path to the image to set the coordinates to the EXIF metadata. | 6.0.0 |
| **`latitude`**    | <code>number</code> | The latitude of the image.                                         | 6.0.0 |
| **`longitude`**   | <code>number</code> | The longitude of the image.                                        | 6.0.0 |


#### GetCoordinatesOptions

| Prop              | Type                | Description                                                        | Since |
| ----------------- | ------------------- | ------------------------------------------------------------------ | ----- |
| **`pathToImage`** | <code>string</code> | The path to the image to set the coordinates to the EXIF metadata. | 6.0.0 |

</docgen-api>
