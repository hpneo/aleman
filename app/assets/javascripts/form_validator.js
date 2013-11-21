var FormValidator = function(model_name, form, validators, messages) {
  var validator_callbacks = {
    greater_than: function(actual, expected) {
      return (actual > expected);
    },
    greater_than_or_equal_to: function(actual, expected) {
      return (actual >= expected);
    }
  };

  var are_valid = [];

  var selectorFor = function(attribute) {
    return '[name="' + model_name + '[' + attribute + ']"]';
  };

  var validateElement = function(element, validator) {
    var is_valid = true;

    for (validator_rule in validator.options) {
      (function(validator_rule) {
        var actual = element.val();
        var expected = validator.options[validator_rule];

        if (validator_rule in validator_callbacks) {
          is_valid = validator_callbacks[validator_rule](actual, expected);
          are_valid.push(is_valid);

          if (!is_valid) {
            element.parents('.input').find('.error').remove();
            var message = messages[validator_rule].replace(/%{count}/ig, expected);
            element.parents('.input').append('<span class="error">' + message + '</span>');
          }
          else {
            element.parents('.input').find('.error').remove();
          }
        }
      })(validator_rule);
    }
  };

  var validateForm = function(form, validators) {
    for (var i = 0; i < validators.length; i++) {
      (function(validator) {
        var input = form.find(selectorFor(validator.attributes[0]));

        validateElement(input, validator);
      })(validators[i]);
    };
  };

  if (form.data('remote')) {
    form.on('ajax:beforeSend', function(e) {
      validateForm($(this), validators);

      var is_valid = are_valid.indexOf(false) == -1;
      are_valid = [];

      return is_valid;
    });
  }
  else {
    form.on('submit', function(e) {
      validateForm($(this), validators);

      var is_valid = are_valid.indexOf(false) == -1;
      are_valid = [];

      if (!is_valid) {
        e.preventDefault();
        e.stopImmediatePropagation();
      }
    });
  }
  for (var i = 0; i < validators.length; i++) {
    (function(validator) {
      var input = form.find(selectorFor(validator.attributes[0]));

      input.on('blur', function() {
        validateElement($(this), validator);

        are_valid = [];
      });
    })(validators[i]);
  }
};