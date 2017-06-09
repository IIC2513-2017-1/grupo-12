$(document).on('turbolinks:load', function () {
  var $container;
  if (($container = $('#boton')).length)
    $container.on('ajax:success', function (e, data) {
      var $button = $("#boton a");
      //var $followers = $("li.#followers-tag")
      if (data.saved) {
        $button.data('method', 'delete');
        $button.text('Unfollow');
        $container.attr('value', 'Unfollow');
        $button.attr('href', '/projects/' + data.saved.id + '/forget.json');
        $("#followers-tag").text(data.followers.num);
      } else {
        $button.text('Follow');
        $button.data('method', 'post');
        $container.attr('value', 'Follow');
        $button.attr('href', '/projects/' + data.unfollowing.id + '/save.json');
        $("#followers-tag").text(data.followers.num);


      }
    }).on('ajax:error', function (e, data) {
      console.log(data);
    });
});
