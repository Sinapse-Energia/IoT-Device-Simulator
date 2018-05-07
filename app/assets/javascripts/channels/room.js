function device_message(device_id, topic, params) {
  App.devices = App.cable.subscriptions.create({
      channel: 'DevicesChannel',
      device_id: device_id
    },
    {
      connected: function() {},
      disconnected: function() {},
      received: function(data) {
        $('#subscribe-table-body').append(
          "<tr>" +
            "<td>" + data['topic'] + "</td>" +
            "<td>" + data['msg'] + "</td>" +
            "<td>" + data['hours'] + "</td>" +
          "</tr>"
        );
      },
      get_message: function(data, topic, params) {
        return this.perform('get_message', {
          device_id: device_id,
          topic: topic,
          config: params
        });
      }
    });
  App.devices.get_message(device_id, topic, params);
}
