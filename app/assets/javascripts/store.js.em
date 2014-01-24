# http://emberjs.com/guides/models/using-the-store/

DS.RESTAdapter.reopen(
  host: 'http://127.0.0.1:3000'
)

class PickwickApp.Adapter extends DS.RESTAdapter
  serializer: DS.RESTSerializer

PickwickApp.Store = DS.Store.extend
  adapter: PickwickApp.Adapter.create(serializer: PickwickApp.RESTSerializer)

class PickwickApp.Store extends DS.Store
  # Override the default adapter with the `DS.ActiveModelAdapter` which
  # is built to work nicely with the ActiveModel::Serializers gem.
  adapter: 'PickwickApp.Adapter'

