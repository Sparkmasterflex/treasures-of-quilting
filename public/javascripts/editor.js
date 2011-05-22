document.observe('dom:loaded', function(){
  if($('admin-user') || $('super-user')) observeImageElements();
  collapseHelp();
  $$('nav a.disabled').invoke('observe', 'click', enablePage);
  $$('a.access').invoke('observe', 'click', enablePage);
  $$('.style').invoke('observe', 'click', addStyle);
  if($('webpage_template') && findSelected($('webpage_template')) != '10') {
    $('widgets').hide();
    $$('a.widget').invoke('hide');
  }
	$$('ul.subpages').invoke('hide');
	$$('a.expand').invoke('observe', 'click', function(e){
  	e.stop();
  	var el = Event.element(e),
  			parent = el.up('li'),
  			toggle = parent.down('ul.subpages');
  	
  	new Effect.toggle(toggle, 'blind', {duration: .25});
  	el.hasClassName('collapse') ?
  		el.removeClassName('collapse') :
  			el.addClassName('collapse'); 
  });
});

function observeImageElements() {
  if($('slides') || $('page-widgets')) {
    $$('li a.add', 'li a.remove').invoke('observe', 'click', setImageState);
    $$('.rightcol .formfield input[type=text]').invoke('observe', 'blur', upDateImages);
    $('image_display').observe('change', setImageDisplay);
    $$('.delete').invoke('observe', 'click', ajaxDestroy);
  }
}

function collapseHelp() {
  /*
   * Toggle help elements (hide/show)
   **/
  $$('.collapse').invoke('hide');
  $$('a.help').invoke('observe', 'click', function(e) {
    e.stop();
    var el = Event.element(e),
        expand = $(el.readAttribute('data-help'));
    new Effect.toggle(expand, 'blind', {duration: 0.5});
  });
  //$$('.img-details .formfield select').invoke('observe', 'change', attachToFeature);
}

function setImageState(e) {
  e.stop();
  var el = Event.element(e),
      href = el.readAttribute('href'),
      enable = el.hasClassName('add'),
      parent = el.up('.images') || el.up('.widgets');

  if(!el.hasClassName('disabled')) {
    new Ajax.Updater(parent, href, {
      method: 'put',
      parameters: {enable: enable},
      onComplete: function(transport) {
        observeImageElements();
        collapseHelp();
      }
    });
  }
}

function upDateImages(e) {
  var el = Event.element(e),
      val = el.value,
      previous = el.readAttribute('data-position') || el.readAttribute('data-caption'),
      url = el.readAttribute('data-url'),
      parent = el.up('.images') || el.up('.widgets');

  if(val != previous) {
    new Ajax.Updater(parent, url, {
      method: 'put',
      parameters: {sending: val},
      onComplete: function(transport) {
        observeImageElements();
        collapseHelp();
      }
    });
  }
}


function attachToFeature(e) {
  var el = Event.element(e),
      selected = el.value,
      image = el.up('li').identify().sub("image-", ""),
      refresh = el.up('.rightcol'),
      msg = "Are you sure you wish to connect this image to the selected feature?"

  if(selected) {
    if(confirm(msg)) {
      new Ajax.Request('/features/attach_image',{
        method: 'put',
        parameters: {image: image, to: selected},
        onComplete: function(transport) {
          var json = transport.responseText.evalJSON();
          if(json.valid) {
            refresh.replace(json.output);
            observeImageElements();
            collapseHelp();
          }
        }
      });
    }
  }
}

function setImageDisplay(e) {
  var el = Event.element(e),
      selected = el.value,
      refresh = el.up('.rightcol'),
      type = el.readAttribute('data_type').split('-'),
      href = '/widgets';
  new Ajax.Updater(refresh, href, {
    method: 'post',
    parameters: {widget: selected, object_id: type[0], type: type[1]},
    onComplete: function(transport) { observeImageElements(); }
  });
}

function enablePage(e) {
  e.stop();
  var el = Event.element(e),
      page = el.readAttribute('data-page').split("-"),
      enable = el.hasClassName('disabled'),
      web = page[0],
      sub = page[1],
      href = page[1] ?
              '/editor/webpages/' + page[0] + '/subpages/' + page[0] + '/set_accessability' :
                '/editor/webpages/' + page[0] + '/set_accessability',
      msg = "";
   if(page[1]) {
     msg = enable ?
             "This subpage has been disabled from public view would you like to enable it?\n\nThis will enable it's parent page as well." :
               "This subpage is currently visible to the public would you like to disable it?"
   } else {
     msg = enable ?
             "This webpage and it's subpages have been disabled from public view would you like to enable it?" :
               "This webpage and it's subpages are visible to the public, would you like to disable it?\n\nThis will disable it's subpage as well."
   }

   if(!el.hasClassName('access')) msg += "\n\nClicking \"Cancel\" will simply direct you to this page."
  if(confirm(msg)) {
    new Ajax.Request(href, {
      method: 'put',
      parameters: {web: page[0], sub: page[1], enable: enable},
      onComplete: function(transport) { window.location.href = el.readAttribute('href'); }
    });
  } else {
    window.location.href = el.readAttribute('href');
  }
}

function ajaxDestroy(e) {
  e.stop();
  var el = Event.element(e),
      num = el.readAttribute('href').gsub(/\/(images|widgets)\//, ''),
      target = el.up('li#' + el.readAttribute('data-delete') + '-' + num);

if (confirm('Are you sure you want to remove this?\nThis action cannot be undone.')) {
    removeFromDom(target, function() {
      var href = el.readAttribute('href');

      new Ajax.Request(href, {method: 'delete', onComplete: function(transport) {
        target.remove();
      }});
    });
  }
}

function removeFromDom(target, afterfinish) {
  new Effect.Parallel([
    new Effect.Opacity(target, {from: 1.0, to: 0}),
    new Effect.Highlight(target) ], {
      duration: 1,
      afterFinish: afterfinish
  });
}

function addStyle(e) {
  e.stop();
  var el = Event.element(e),
      style = el.readAttribute('href'),
      text = $('webpage_preview_text'),
      selected = text.value.getRangeAt,
      add = style == '#strong' ? '<strong></strong>' : '<em></em>';

  //alert(style)
  //text.insert(add);
}

function findSelected(select) {
  var option = '';
  for(var i = 0; i < select.options.length; i++) {
    if(select.options[i].readAttribute('selected') == 'selected') option = select.options[i].value;
  }
  return option;
}


function updateWidgetValue(e) {
  e.stop();
  var el = Event.element(e),
      val = el.value,
      parent = el.up('.widget'),
      update = parent.down('.widget-content'),
      obj = parent.down('input[type=hidden]').readAttribute('data-object');

  new Ajax.Updater(update, '/widgets/update_content', {
    method: 'get',
    parameters: {widget: val, object: obj},
    onComplete: function(transport) {
      if($('content_select')) $('content_select').observe('change', setWidgetContent);
      if($('content_text')) $('content_text').observe('blur', setWidgetContent);
    }
  });
}

function setWidgetContent(e) {
  var el = Event.element(e),
      parent = el.up('.widget'),
      hidden = parent.down('input[type=hidden]');
  hidden.value = el.value;
}