var Tabs = function(container) {
  this.tabs = container.find('.tabs');
  this.tab_panels = container.find('.tab-panel');
  this.current_tab = null;

  this.tabs.find('a').eq(0).addClass('current');
  this.tab_panels.eq(0).addClass('current');

  var self = this;

  this.tabs.find('a').on('click', function(e) {
    e.preventDefault();

    var index = $(this).index();

    self.tabs.find('a').removeClass('current');
    $(this).addClass('current');

    self.tab_panels.removeClass('current');
    self.tab_panels.eq(index).addClass('current');
  });
};