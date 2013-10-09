# PushBuilder

[![Build Status](https://travis-ci.org/fphilipe/push_builder.png)](https://travis-ci.org/fphilipe/push_builder)
[![Gem Version](https://badge.fury.io/rb/push_builder.png)](http://badge.fury.io/rb/push_builder)
[![Dependency Status](https://gemnasium.com/fphilipe/push_builder.png)](https://gemnasium.com/fphilipe/push_builder)
[![Code Climate](https://codeclimate.com/github/fphilipe/push_builder.png)](https://codeclimate.com/github/fphilipe/push_builder)

PushBuilder was born with one mission only: construct JSON payloads for Apple's push notification service.

## What it Does

- Automatically crops the alert so that the payload does not exceed the allowed 256 bytes.
- Supports specifying custom data (data that the iOS app can read from the push notification).
- Supports specifying data for a third party (data that is intended for a "man in the middle" such as Urban Airship; this data is assumed to be stripped from the payload by the third party and thus does not count towards the 256 bytes limit).
- Performs some basic type checking.

## Usage

```ruby
PushBuilder.build(alert: 'Hello World!', badge: 3, sound: 'default').to_json
# => {"aps":{"badge":3,"alert":"Hello World!","sound":"default"}}

# Specifying custom data:
payload = PushBuilder.build(alert: 'Hello World!')
payload.custom_data[:notification_id] = 1234
payload.to_json
# => {"notification_id":1234,"aps":{"alert":"Hello World!"}}

# Specifying third party data (such as UrbanAirship aliases):
payload = PushBuilder.build(alert: 'Hello World!')
payload.third_party_data[:aliases] = %w[ 123 456 789 ]
payload.to_json
# => {"aliases":["123","456","789"],"aps":{"alert":"Hello World!"}}

# Auto crops alerts to not exceed max payload size of 256 bytes:
PushBuilder.build(alert: 'Hello World ' * 100, badge: 3, sound: 'default').to_json
# => {"aps":{"badge":3,"alert":"Hello World [...] H…","sound":"default"}}
```

## Limitations

The `alert` key of the `aps` dictionary only supports strings at the moment.
Technically, the alert can be customized further as described in [PAYLOAD.md](PAYLOAD.md).

## Additional Information

### Useful Links

- [Anatomy of a Payload](PAYLOAD.md)
- [Local and Push Notification Programming Guide](http://developer.apple.com/library/mac/#documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/ApplePushService/ApplePushService.html)

### Maintainers

- Philipe Fatio ([@fphilipe](https://github.com/fphilipe))

### License

MIT License. Copyright 2013 Philipe Fatio


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/fphilipe/push_builder/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

