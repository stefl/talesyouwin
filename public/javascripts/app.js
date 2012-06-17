$(function() {
  $(".tale_embed, .step_embed").embedly({key:':3ac13794740911e1ab094040d3dc5c07'});
  $(".delete").click(function(e) {
    e.preventDefault();
    var ctx = this;
    $.ajax({
      type: "DELETE",
      url: $(this).attr("href"),
      success: function() {
        $(ctx).closest(".delete_target").remove();
      }
    });
  });
});