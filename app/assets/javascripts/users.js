$(document).on('turbolinks:load', function () {
  var $container;
  if (($container = $('#user-follow-btn')).length)
    var $followers = $(".user-followers>a>strong");
    $container.on('ajax:success', function (e, data) {
      var $button = $("#user-follow-btn a");
      if (data.following) {
        $button.data('method', 'delete');
        $button.text('Unfollow');
        $button.attr('href', '/relationships/' + data.follow.id + '.json');
        $container.attr("value", "Unfollow");
        $followers.text(data.follow.followers);
      } else {
        $button.text('Follow');
        $button.data('method', 'post');
        $button.attr('href', '/relationships.json?id=' + data.unfollowing.id);
        $container.attr("value", "Follow");
        $followers.text(data.unfollowing.followers);
      }
    }).on('ajax:error', function (e, data) {
      console.log(data);
    });
});
