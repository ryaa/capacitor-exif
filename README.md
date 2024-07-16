# @capacitor-community/exif

This plugin offers utility functions for interacting with jpeg exif metadata

## Install

```bash
npm install @capacitor-community/exif
npx cap sync
```

## API

<docgen-index>

* [`echo(...)`](#echo)
* [`setCoordinates(...)`](#setcoordinates)
* [`getCoordinates(...)`](#getcoordinates)
* [Interfaces](#interfaces)

</docgen-index>

<docgen-api>
<!--Update the source file JSDoc comments and rerun docgen to update the docs below-->

### echo(...)

```typescript
echo(options: { value: string; }) => Promise<{ value: string; }>
```

| Param         | Type                            |
| ------------- | ------------------------------- |
| **`options`** | <code>{ value: string; }</code> |

**Returns:** <code>Promise&lt;{ value: string; }&gt;</code>

--------------------


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
getCoordinates(options: GetCoordinatesOptions) => Promise<{ value: { latitude: number; longitude: number; }; }>
```

Set the coordinates to the image EXIF metadata.

| Param         | Type                                                                    |
| ------------- | ----------------------------------------------------------------------- |
| **`options`** | <code><a href="#getcoordinatesoptions">GetCoordinatesOptions</a></code> |

**Returns:** <code>Promise&lt;{ value: { latitude: number; longitude: number; }; }&gt;</code>

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
