function selected_device(event) {
  var device_id = event.val();
  if(device_id == "0"){
    window.location.href = window.location.origin + "/devices/new"
  }else {
    $.ajax({
      url: "/devices/" + device_id + "/get_device",
      type: 'GET',
      dataType: 'html',
      success: function (data) {
        var activ_tab = $('li.js-device-li.active a').attr('aria-controls');
        $("#deviceTabs").html(data);
        $('#deviceTabs .tab-pane.active').removeClass('active');
        $('#deviceTabs #' + activ_tab).addClass('active');
        $.mCustomScrollbar.defaults.scrollButtons.enable = true;
        $.mCustomScrollbar.defaults.axis = "yx";
        $(".roundscroll").mCustomScrollbar({theme: "rounded"});
      }
    });
  }
}

function disconnectMqttDevice(device_id){
  var data = $('#mqtt_frm').serialize();

  $.ajax({
    url: "/devices/"+ device_id +"/disconnect",
    type: 'POST',
    dataType: 'html',
    data: data,
    success: function( data ){
      console.log("success");
    }
  });
}
