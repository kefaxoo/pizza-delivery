# pizza-delivery

## Запросы

### Получение стран

Адрес: `https://mapi.dodopizza.ru/api/v2/countries`

Метод: `GET`

Headers:
|Key|Value|
|-|-|
|LanguageCode|ru|

В этом запросе сохраняется код страны в формате цифрового ISO-3166-1 (`countryCode`)

___

### Получение локаций (городов)

Адрес: `https://mapi.dodopizza.ru/api/v3/localities`

Метод: `GET`

Headers:
|Key|Value|
|-|-|
|LanguageCode|ru|
|CountryCode|`countryCode`|

В этом запросе сохраняется id города (`locationId`)

___

### Получение пиццерий

Адрес: `https://mapi.dodopizza.ru/api/v1/Pizzeria?LocalityId={locationId}`

Метод: `GET`

Params:
|Key|Value|
|-|-|
|LocalityId|`locationId`|

Headers:
|Key|Value|
|-|-|
|LanguageCode|ru|
|CountryCode|`countryCode`|

В этом запросе сохраняется id пиццерии (`pizzeriaId`)

___

### Получение меню

Адрес: `https://mapi.dodopizza.ru/api/v3/menu/restaurant/{countryCode}/{pizzeriaId}`

Метод: `GET`

Params:
|Key|Value|
|-|-|
|PreferredImageFormat|heic|
|withMetaProducts|true|

Headers:
|Key|Value|
|-|-|
|LanguageCode|ru|
|CountryCode|`countryCode`|

Запрос отдаёт доступные товары в пиццерии с `pizzeriaId`

___

### Получение sdk key

Запрос нужен для дальнейшего получения промо пиццерии

Адрес: `https://mapi.dodopizza.ru/api/v1/stories/sdkkey`

Метод: `GET`

Headers:
|Key|Value|
|-|-|
|LanguageCode|ru|
|CountryCode|`countryCode`|

В этом запросе сохраняется `inAppStorySdkKey` (`sdkKey`)

___

### Получение id сессии

Запрос нужен для дальнейшего получения промо пиццерии

Адрес: `https://api.inappstory.ru/v2/session/open`

Метод: `POST`

Headers:
|Key|Value|
|-|-|
|Authorization|`Bearer sdkKey`|

В этом методе сохраняется `id` из `session` (`sessionId`)

___

### Получение промо пиццерии

Адрес: `https://api.inappstory.ru/v2/feed/default`

Метод: `GET`

Params:
|Key|Value|
|-|-|
|tags|not-authorized%2Cru-RU%2C%D0%BC%D0%B8%D0%BD%D1%81%D0%BA_restaurant%2C%D0%BC%D0%B8%D0%BD%D1%81%D0%BA-12_restaurant%2Crestaurant|

Headers:
|Key|Value|
|-|-|
|Authorization|`Bearer sdkKey`|
|auth-session-id|`sessionId`|
