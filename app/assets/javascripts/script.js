$(document).ready(function() {
  $("a.fancybox").fancybox();

  $(".editable").hover(function() {
    $(".hiddenpopup").show();}, function() {
    $(".hiddenpopup").hide();
  });
});