var EditableField = function(fields, editable_field_labels, after_show_callback) {
  $(document).on('click', function(e) {
    var target = $(e.target);
    if (target.parents("#payment-form-modal").length > 0 || target.is("#payment-form-modal")) {
      $('#payment-form-modal').show();
    }
    else {
      $('#payment-form-modal').hide();
    }
  });

  $('.editable-field').on('click', function() {
    var payment_id = $(this).parents('tr').attr('id').replace('payment-', '');

    var field = $(this).attr('class').replace('editable-field', '').trim().replace('payment_', '').trim();

    var position = $(this).first().position();
    var width = $(this).outerWidth() + 10;

    $.ajax({
      url: '/payments/' + payment_id + '/form',
      type: 'GET',
      dataType: 'html',
      data: {
        field: field,
        label: editable_field_labels[field]
      },
      success: function(data) {
        $('#payment-form-modal').html(data);

        position.left = position.left + width;
        position.top = position.top - ($('#payment-form-modal').height() / 2);

        $('#payment-form-modal').css(position).show();

        if (after_show_callback) {
          after_show_callback($('#payment-form-modal').find('form'));
        }
      }
    });
  });
};