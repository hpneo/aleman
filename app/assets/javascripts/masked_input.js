var MaskedInput = function(input, mask, actual) {
  this.mask = mask;
  this.actual = actual;

  var self = this;

  input.on('focus', function() {
    var val = self.actual($(this).val());

    if (isNaN(val)) {
      val = 0;
    }

    $(this).val(val);
  });

  input.on('blur', function() {
    $(this).val(self.mask($(this).val()));
  });

  input.each(function(){
    $(this).addClass('masked-input');
    $(this).val(self.mask($(this).val()));
  });

  input.parents('form').on('ajax:beforeSend', function(e) {
    e.preventDefault();
  });

  input.parents('form').on('submit', function() {
    $(this).find('.masked-input').each(function(){
      var val = self.actual($(this).val());

      if (isNaN(val)) {
        val = 0;
      }

      $(this).val(val);
    });
  });
};

MaskedInput.prototype.add = function(input) {
  var self = this;

  if (input.is('.masked-input')) {
    return false;
  }

  input.on('focus', function() {
    $(this).val(self.actual($(this).val()));
  });

  input.on('blur', function() {
    $(this).val(self.mask($(this).val()));
  });

  input.each(function(){
    $(this).addClass('masked-input');
    $(this).val(self.mask($(this).val()));
  });
};

MaskedInput.prototype.remove = function(input) {
  var self = this;

  input.each(function(){
    if ($(this).is('.masked-input')) {
      $(this).off('focus');
      $(this).off('blur');

      $(this).removeClass('masked-input');
      $(this).val(self.actual($(this).val()));
    }
  });
};