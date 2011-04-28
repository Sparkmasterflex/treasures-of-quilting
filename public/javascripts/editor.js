document.observe('dom:loaded', function(){
  observeImageElements();
  $$('.delete').invoke('observe', 'click', ajaxDestroy);
  $$('nav a.disabled').invoke('observe', 'click', enablePage);
  $$('a.access').invoke('observe', 'click', enablePage);
  $$('.style').invoke('observe', 'click', addStyle);
});

function observeImageElements() {
  if($('slides')) {
    $$('ul.image-links li a.add', 'ul.image-links li a.remove').invoke('observe', 'click', setImageState);
    $$('.img-details .formfield input[type=text]').invoke('observe', 'blur', upDateImages);
    $('image_display').observe('change', setImageDisplay);    
  }

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
      parent = el.up('.images') || el.up('.section');

  if(!el.hasClassName('disabled')) {
    new Ajax.Updater(parent, href, {
      method: 'put',
      parameters: {enable: enable},
      onComplete: function(transport) {
        observeImageElements();
      }
    });
  }
}

function upDateImages(e) {
  var el = Event.element(e),
      val = el.value,
      previous = el.readAttribute('data-position') || el.readAttribute('data-caption'),
      url = el.readAttribute('data-url'),
      parent = el.up('.images') || el.up('.section');

  if(val != previous) {
    new Ajax.Updater(parent, url, {
      method: 'put',
      parameters: {sending: val},
      onComplete: function(transport) {
        observeImageElements();
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
      imgNum = el.readAttribute('href').gsub(/\/images\//, ''),
      target = el.up('li#image-' + imgNum);

if (confirm('Are you sure you want to remove this?\nThis action cannot be undone.')) {
    removeFromDom(target, function() {
      var href = el.readAttribute('href');

      new Ajax.Request(href, {method: 'delete', onComplete: function(transport) {
        target.remove();
      }});
    });
  }
}

function addStyle(e) {
  e.stop();
  var el = Event.element(e),
      style = el.readAttribute('href'),
      text = $('webpage_preview_text'),
      selected = text.value.getRangeAt,
      add = style == '#strong' ? '<strong></strong>' : '<em></em>';

  alert(style)
  //text.insert(add);
}
