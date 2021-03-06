document.observe('dom:loaded', function() {
	// observe pagination links
  $$('.ajax.pagination a').invoke('observe', 'click', ajaxPagination);
  $$('a[rel=scrollTo]').invoke('observe', 'click', function(e){
  	e.stop();
  	var el = Event.element(e),
  			to = el.readAttribute('href').gsub(/#/, '');

  	new Effect.ScrollTo(to, { duration:'0.5', offset:-20 });
  })

  if($('slideshow')) {
    new SlideShow({
      parent: $('slideshow'),
      slides: $$('ul#slideshow li'),
      links: 'next',
      caption: true,
      seconds: 4
    });
  }
  
  setupSubpagePreview();
  // if($('gallery')) $('gallery').select('li a').each(function(el) {new Gallery({el: el, images: $('gallery').select('li a')});});
  $$('ul.gallery').each(function(ul){
  	ul.select('li a').each(function(el) {new Gallery({el: el, images: ul.select('li a')});});
  });
  
  if($('contact-form')) {
  	$('contact-form').observe('submit', function(e) {
	  	e.stop();
	  	var form = Event.element(e),
	  			serial = form.serialize();
	  	
	  	new Ajax.Updater($('contact'), '/editor/contacts', {
	  		method: 'post',
	  		parameters: serial
	  	});
  	});
  }
  
  $$('.read-more').invoke('hide');
  $$('a.expand').invoke('observe', 'click', function(e){
  	e.stop();
  	var el = Event.element(e),
  			parent = el.up(),
  			toggle = parent.down('.' + el.readAttribute('rel'));
  	new Effect.toggle(toggle, 'blind', {duration: 0.5});
  	if(el.hasClassName('alternate')) alternateText(el);
   });
  
  $('calculator-form').down('form').observe('submit', submitForm);
});

function ajaxPagination(e) {
  e.stop();
  var el = Event.element(e),
      href = el.readAttribute('href'),
      update = $('subpage-preview');

  update.fade({duration: 0.05, from: 1, to: 0.01, afterFinish: function(){
    new Ajax.Updater(update, href, {
    	method: 'get',
			onComplete: function() {
	      update.select('.ajax.pagination a').invoke('observe', 'click', ajaxPagination);
	      update.fade({duration: 0.15, from: 0.01, to: 1});
	      setupSubpagePreview();
    	}
    });
  } });
}

function setupSubpagePreview() {
  if($('subpages-link')) {
    $$('.drop-down').first().hide();
    $('subpages-link').observe('click', displayDropDown);
    $('sub-page-desc').select('li').invoke('observe', 'click', function(e){
      var el = Event.element(e),
      		li = el.up('li') || el,
      		href = li.down('a').readAttribute('href');
      window.location = href;
    });
  }
}


function displayDropDown(e) {
  e.stop();
  var el = $('subpages-link'),
      dropDown = $$('.' + el.readAttribute('rel')).first(),
      count = dropDown.select('.webpage').length,
      ddWidth = (count >= 3) ? (200 * 3) +  'px' : (200 * count) + 'px',
      style = dropDown.visible() ?
        {color: '#000', 'text-decoration': 'underline'} :
        {color: '#fff', 'text-decoration': 'none'};
      
  el.setStyle(style);
  dropDown.setStyle('width', ddWidth);
  dropDown.toggle();
}

function alternateText(link) {
	link.innerHTML == 'Read More' ?
		link.update('Hide') :
			link.update('Read More');
}


function submitForm(e) {
	e.stop();
	var form = Event.element(e),
			href = form.readAttribute('action');
	
	new Ajax.Updater(form.up(), href, {
		method: 'post',
		parameters: form.serialize(),
		onComplete: function(transport) {
			if(!$('calculator-form').down('table'))
				$('calculator-form').down('form').observe('submit', submitForm) 
		}
	});
}