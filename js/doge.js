$(function(){
  var btn = '<div class="symbol">Ð </div><p><span class="currency">Dogecoin</span></p>';
  $('.btn-dogecoin').each(function(){
    $(this).append(btn);
  });
    $('.btn-dogecoin').click(function(event) {
        var that = this;
        $(this).addClass('opened');  
        $(this).children('p').children('.currency').text($(this).data('address'));  
        $('html').one('click',function() {
            $(that).removeClass('opened');
            $(that).children('p').children('.currency').text('Dogecoin');   
        });
        event.stopPropagation();
    });
});